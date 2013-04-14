//+------------------------------------------------------------------+
//|                                              TradeOportunity.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
#include <Charts\Chart.mqh>
#include <Arrays\ArrayString.mqh>
#include <Arrays\ArrayObj.mqh>
#include "Signal\Signal.mqh"
#include "Signal\SignalParameter.mqh"
#include "Position.mqh"
#include "Util.mqh";
#include "ZigZag\ZigZag.mqh"
#include "ZigZag\ZigZagPoint.mqh"
//+------------------------------------------------------------------+
//| Lớp tổng hợp thực hiện tất cả các nhiệm vụ                       |
//+------------------------------------------------------------------+
class Finder: public CObject
  {
protected:
   //+------------------------------------------------------------------+
   //| Environment                                                      |
   //+------------------------------------------------------------------+
   string            e_symbol;
   ENUM_TIMEFRAMES   e_timeframe;
   int               e_zigzag_depth;
   int               e_zigzag_deviation;
   int               e_zigzag_backstep;

   //+------------------------------------------------------------------+
   //| Signal                                                           |
   //+------------------------------------------------------------------+
   CArrayObj         m_signal;

   //+------------------------------------------------------------------+
   //| Position                                                         |
   //+------------------------------------------------------------------+
   CArrayObj         m_position;

   //+------------------------------------------------------------------+
   //| Mark Position                                                    |
   //+------------------------------------------------------------------+
   void              MarkPosition(void);
   datetime          LastProcessedPoint;

public:
                     Finder(void);
                    ~Finder(void);
   int               Run(void);
   bool              AddSignal(Signal *signal);
   uint              CountSignal(void);
   bool              AddPosition(datetime Time,char Type);
   uint              CountPosition(void);
   string            UniqueFileName(void);
   bool              SaveJSON();
   bool              ReadJSON();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Finder::Finder(void)
  {
   CChart chart;

   chart.Attach();
   e_symbol=chart.Symbol();
   e_timeframe=chart.Period();
   chart.Detach();

   e_zigzag_depth=ZigZagDepth;
   e_zigzag_deviation=ZigZagDeviation;
   e_zigzag_backstep=ZigZagBackstep;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Finder::~Finder(void)
  {

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Finder::Run(void)
  {
//--- Chạy tất cả các signal đã được add vào
   char LastCheck=NULL; // Không có giá trị
   char CheckResult=NULL;
   if(m_signal.Total()==0) return(1); // Không có signal nào tồn tại, hủy.
   for(int i=0;i<m_signal.Total();i++)
     {
      Signal *signal=m_signal.At(i);
      // Chế độ chạy theo tick hay theo bar?
      if(!signal.EveryTick() && Rate(0).tick_volume>1)
        {
         CheckResult=NULL;
         continue;
        }
      // Kiểm tra dữ liệu đầu vào
      if(!signal.ValidateParameter()) return(2);
      // Kiểm tra tín hiệu
      CheckResult=signal.Check();
      // Đảm bảo tất cả các tín hiệu trả về giá trị 1 hoặc -1
      if(CheckResult!=1 && CheckResult!=-1) return(0);
      // Tất cả các tín hiệu phải có cùng giá trị
      if(LastCheck!=NULL && CheckResult!=LastCheck) return(0);
      LastCheck=CheckResult;
     }
   if(CheckResult==1 || CheckResult==-1)
     {
      // Add Position
      this.AddPosition(Time(0),CheckResult);
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Finder::AddSignal(Signal *signal)
  {
   for(int i=0;i<m_signal.Total();i++)
     {
      Signal *tempsignal=m_signal.At(i);
      if(tempsignal.GetID()==signal.GetID())
        {
         OnDeinit(REASON_INITFAILED);
         return(false);
        }
     }
   return(m_signal.Add(signal));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint Finder::CountSignal(void)
  {
   return(m_signal.Total());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Finder::AddPosition(datetime time,char type)
  {
// Kiểm tra position đã tồn tại hay chưa?
   for(int i=0;i<m_position.Total();i++)
     {
      Position *position=m_position.At(i);
      if(position.GetTime()==time) return(false);
     }
   return(m_position.Add(new Position(time,type)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint Finder::CountPosition(void)
  {
   return(m_position.Total());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Finder::UniqueFileName(void)
  {
// Tạo cấu trúc thư mục
   string TimeFrame,Folder,FileName,StringInput;
// Chuyển đồi Time Frame từ số sang chữ
   TimeFrame=util.PeriodToString(e_timeframe);
   Folder="StrategyFinder"+"\\"+e_symbol+"\\"+TimeFrame;
   if(!FolderCreate(Folder))
     {
      Print("Không tạo được Folder: ",Folder);
      Print("Lưu File vào vị trí mặc định: ",TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL5\\Files");
      Folder=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL5\\Files";
     }

// Tạo file name dựa trên sự mã hóa tất cả các tham số đầu vào của indicator
   StringInput="";
   for(int i=0;i<m_signal.Total();i++)
     {
      Signal *signal=m_signal.At(i);
      StringInput=StringInput+signal.Unique();
     }
// MD5 chuỗi StringInput để được File Name
   FileName=Folder+"\\"+md5(StringInput)+".json"; // MD5-hash

   return(FileName);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Finder::SaveJSON(void)
  {
   string JSON="",LastElement;
   CArrayString JSONPart;
//--- ZigZag
   ZigZag *zigzag=new ZigZag(true);
//--- Check Indicator
   if(this.CountPosition()<1)
     {
      Print("Không có position nào.");
      return(false);
     }
//--- OK, let's do it
   JSONPart.Add("{");
//--- Add Current Environment
   JSONPart.Add("\"time_local\":\""+(string)TimeLocal()+"\"");JSONPart.Add(","); // Ex: "time_local" : "2013.04.08 23:11:43"
   JSONPart.Add("\"symbol\" : \""+(string)e_symbol+"\"");JSONPart.Add(","); // Ex: "symbol" : "EURUSD"
   JSONPart.Add("\"timeframe\" : "+(string)e_timeframe+"");JSONPart.Add(","); // Ex: "timeframe" : 1
//--- Add ZigZag Properties
   JSONPart.Add("\"ZigZag\": ");
   JSONPart.Add("{");
   JSONPart.Add("\"depth\":"+(string)e_zigzag_depth);JSONPart.Add(",");
   JSONPart.Add("\"deviation\":"+(string)e_zigzag_deviation);JSONPart.Add(",");
   JSONPart.Add("\"backstep\":"+(string)e_zigzag_backstep);JSONPart.Add(",");
   JSONPart.Add("\"total_points\" : " + (string)zigzag.CountPoint());JSONPart.Add(",");
   JSONPart.Add("\"points\" : ");
   JSONPart.Add("[");
// Lặp qua các điểm zigzag. Không lấy điểm zigzag đầu tiên vì nó chưa hoàn thành
   for(int i=1;i<zigzag.CountPoint();i++)
     {
      JSONPart.Add("{");
      JSONPart.Add("\"time\" : \""+(string)zigzag.GetTime(i)+"\"");JSONPart.Add(","); // Ex: "time" : "2013.04.08 23:11:43",
      JSONPart.Add("\"price\" : "+(string)zigzag.GetPrice(i));JSONPart.Add(","); // Ex: "type" : true,
      JSONPart.Add("\"spread\" : "+(string)zigzag.GetSpread(i));JSONPart.Add(",");
      if(zigzag.IsTop(i))
         JSONPart.Add("\"location\" : \"top\"");
      else
         JSONPart.Add("\"location\" : \"bottom\"");

      JSONPart.Add("}");
      JSONPart.Add(",");
     }
// Xóa dấu phẩy (,) cuối cùng
   JSONPart.Delete(JSONPart.Total()-1);
   JSONPart.Add("]");
   JSONPart.Add("}");JSONPart.Add(",");
//--- Add Signals Information
   JSONPart.Add("\"total_signals\" : "+(string)this.CountSignal());JSONPart.Add(",");
   JSONPart.Add("\"signals\" : ");
   JSONPart.Add("[");
   for(int i=0;i<m_signal.Total();i++)
     {
      Signal *signal=m_signal.At(i);
      JSONPart.Add(signal.GetJSONString());JSONPart.Add(",");
     }
// Xóa dấu phẩy (,) cuối cùng
   JSONPart.Delete(JSONPart.Total()-1);
   JSONPart.Add("]");JSONPart.Add(",");
//--- Add Position
   Print("Total positions: ",(string)this.CountPosition());
   JSONPart.Add("\"total_positions\" : " + (string)this.CountPosition());JSONPart.Add(",");
   JSONPart.Add("\"positions\":");
   JSONPart.Add("[");
   for(int i=0;i<m_position.Total();i++)
     {
      Position *position=m_position.At(i);
      JSONPart.Add("{");
      JSONPart.Add("\"time\" : \""+(string)position.GetTime()+"\"");JSONPart.Add(","); // Ex: "time" : "2013.04.08 23:11:43",
      JSONPart.Add("\"type\" : "+(string)position.GetType());// Ex: "type" : true
      JSONPart.Add("}");
      JSONPart.Add(",");
     }
// Xóa dấu phẩy (,) cuối cùng
   JSONPart.Delete(JSONPart.Total()-1);

   JSONPart.Add("]");
//--- End
   JSONPart.Add("}");
//--- Gộp dữ liệu vào chuỗi JSON
   for(int i=0;i<JSONPart.Total();i++)
     {
      JSON=JSON+JSONPart.At(i);
     }
//--- Lưu vào File
   int FileHandle=FileOpen(this.UniqueFileName(),FILE_WRITE|FILE_TXT);
   if(FileHandle<0)
     {
      Print("Không thể mở file "+this.UniqueFileName()+" để ghi");
      return(false);
     }
   if(!FileWriteString(FileHandle,JSON))
     {
      Print("Ghi dữ liệu vào File không thành công.");
      FileClose(FileHandle);
      return(false);
     }
   FileClose(FileHandle);
   Print("Dữ liệu đã được lưu vào file: ",this.UniqueFileName());
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Finder::ReadJSON(void)
  {
   return(true);
  }
//+------------------------------------------------------------------+
