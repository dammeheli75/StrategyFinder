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
#include "MD5Hash.mqh"
//+------------------------------------------------------------------+
//| Các biến global                                                  |
//+------------------------------------------------------------------+
double Open[],High[],Low[],Close[];
int Spread[];
datetime Time[];
MqlRates Rate[];
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

   //+------------------------------------------------------------------+
   //| Signal                                                        |
   //+------------------------------------------------------------------+
   CArrayObj         m_signal;

   //+------------------------------------------------------------------+
   //| Position                                                         |
   //+------------------------------------------------------------------+
   CArrayObj         m_position;

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
   CopyOpen(Symbol(),PERIOD_CURRENT,0,2,Open); ArraySetAsSeries(Open,true);
   CopyHigh(Symbol(),PERIOD_CURRENT,0,2,High); ArraySetAsSeries(High,true);
   CopyLow(Symbol(),PERIOD_CURRENT,0,2,Low); ArraySetAsSeries(Low,true);
   CopyClose(Symbol(),PERIOD_CURRENT,0,2,Close); ArraySetAsSeries(Close,true);
   CopySpread(Symbol(),PERIOD_CURRENT,0,2,Spread); ArraySetAsSeries(Spread,true);
   CopyTime(Symbol(),PERIOD_CURRENT,0,2,Time); ArraySetAsSeries(Time,true);
   CopyRates(_Symbol,_Period,0,2,Rate); ArraySetAsSeries(Rate,true);

//--- Chạy tất cả các signal đã được add vào
   char LastCheck=NULL; // Không có giá trị
   char CheckResult=NULL;
   if(m_signal.Total()==0) return(1); // Không có signal nào tồn tại, hủy.
   for(int i=0;i<m_signal.Total();i++)
     {
      Signal *signal=m_signal.At(i);
      // Chế độ chạy theo tick hay theo bar?
      if(!signal.EveryTick() && Rate[0].tick_volume>1)
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
      this.AddPosition(Time[0],CheckResult);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Finder::AddSignal(Signal *signal)
  {
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
   m_position.Add(new Position(time,type));

   return(true);
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
   switch(e_timeframe)
     {
      case  PERIOD_M1:
         TimeFrame="M1";
         break;
      case  PERIOD_M2:
         TimeFrame="M2";
         break;
      case  PERIOD_M3:
         TimeFrame="M3";
         break;
      case  PERIOD_M4:
         TimeFrame="M4";
         break;
      case  PERIOD_M5:
         TimeFrame="M5";
         break;
      case  PERIOD_M6:
         TimeFrame="M6";
         break;
      case  PERIOD_M10:
         TimeFrame="M10";
         break;
      case  PERIOD_M12:
         TimeFrame="M12";
         break;
      case  PERIOD_M15:
         TimeFrame="M15";
         break;
      case  PERIOD_M20:
         TimeFrame="M20";
         break;
      case  PERIOD_M30:
         TimeFrame="M30";
         break;
      case  PERIOD_H1:
         TimeFrame="H1";
         break;
      case  PERIOD_H2:
         TimeFrame="H2";
         break;
      case  PERIOD_H3:
         TimeFrame="H3";
         break;
      case  PERIOD_H4:
         TimeFrame="H4";
         break;
      case  PERIOD_H6:
         TimeFrame="H6";
         break;
      case  PERIOD_H8:
         TimeFrame="H8";
         break;
      case  PERIOD_H12:
         TimeFrame="H12";
         break;
      case  PERIOD_D1:
         TimeFrame="D1";
         break;
      case  PERIOD_W1:
         TimeFrame="W1";
         break;
      case  PERIOD_MN1:
         TimeFrame="MN1";
         break;
      default:
         TimeFrame="Undefined";
         break;
     }

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
   CMD5Hash md5;
   uchar bytes[];StringToCharArray(StringInput,bytes); // transferred string to the byte array // without the last one\0
   FileName=Folder+"\\"+md5.Hash(bytes,ArraySize(bytes))+".json"; // MD5-hash

   return(FileName);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Finder::SaveJSON()
  {
   string JSON="",LastElement;
   CArrayString JSONPart;
//--- Check Indicator
   if(m_position.Total()<1)
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
//--- Add Signals Information
   JSONPart.Add("\"total_signals\" : "+(string)this.CountSignal());JSONPart.Add(",");
   JSONPart.Add("\"indicators\" : ");
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
   Print(__FUNCTION__," line ",(string)__LINE__);
   for(int i=0;i<m_position.Total();i++)
     {
      Position *position=m_position.At(i);

      JSONPart.Add("{");
      JSONPart.Add("\"time\" : \""+(string)position.GetTime()+"\"");JSONPart.Add(","); // Ex: "time" : "2013.04.08 23:11:43",
      JSONPart.Add("\"type\" : "+(string)position.GetType()); // Ex: "type" : true,
      JSONPart.Add("}");
      JSONPart.Add(",");
     }
   Print(__FUNCTION__," line ",(string)__LINE__);
// Xóa dấu phẩy (,) cuối cùng
   JSONPart.Delete(JSONPart.Total()-1);

   JSONPart.Add("]");
//--- End
   JSONPart.Add("}");
//--- Gộp dữ liệu vào chuỗi JSON
   Print(__FUNCTION__," line ",(string)__LINE__);
   for(int i=0;i<JSONPart.Total();i++)
     {
      JSON=JSON+JSONPart.At(i);
     }
//--- Lưu vào File
   Print(__FUNCTION__," line ",(string)__LINE__);
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
   Print(__FUNCTION__," line ",(string)__LINE__);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Finder::ReadJSON()
  {
   return(true);
  }
//+------------------------------------------------------------------+
