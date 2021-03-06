//+------------------------------------------------------------------+
//|                                                         Util.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
#include <Arrays\ArrayInt.mqh>
#include <Arrays\ArrayObj.mqh>
#include "Position.mqh"
#include "MD5Hash.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Util: public CObject
  {
protected:

public:
                     Util(void);
                    ~Util(void);
   string            PeriodToString(ENUM_TIMEFRAMES period);
   int               StringToPeriod(string StringPeriod);
   int               SearchPosition(CArrayObj *positions,datetime from,datetime to);
   datetime          SearchPosition(CArrayObj *positions,int from,int to);
   int               TimeToIndex(datetime time); // Index tương đối tại thời điểm hiện tại
   double            Open(int ind);// Index tương đối tại thời điểm hiện tại
   double            Open(datetime time); // Thời gian tuyệt đối
   double            High(int ind);// Index tương đối tại thời điểm hiện tại
   double            High(datetime time); // Thời gian tuyệt đối
   double            Low(int ind);// Index tương đối tại thời điểm hiện tại
   double            Low(datetime time); // Thời gian tuyệt đối
   double            Close(int ind);// Index tương đối tại thời điểm hiện tại
   double            Close(datetime time); // Thời gian tuyệt đối
   int               Spread(int ind);// Index tương đối tại thời điểm hiện tại
   int               Spread(datetime time); // Thời gian tuyệt đối
   datetime          Time(int ind);// Index tương đối tại thời điểm hiện tại
   MqlRates          Rate(int ind);// Index tương đối tại thời điểm hiện tại
   string            MD5(string str);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Util::Util(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Util::~Util(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Util::PeriodToString(ENUM_TIMEFRAMES period)
  {
   switch(period)
     {
      case  PERIOD_M1:
         return("M1");
         break;
      case  PERIOD_M2:
         return("M2");
         break;
      case  PERIOD_M3:
         return("M3");
         break;
      case  PERIOD_M4:
         return("M4");
         break;
      case  PERIOD_M5:
         return("M5");
         break;
      case  PERIOD_M6:
         return("M6");
         break;
      case  PERIOD_M10:
         return("M10");
         break;
      case  PERIOD_M12:
         return("M12");
         break;
      case  PERIOD_M15:
         return("M15");
         break;
      case  PERIOD_M20:
         return("M20");
         break;
      case  PERIOD_M30:
         return("M30");
         break;
      case  PERIOD_H1:
         return("H1");
         break;
      case  PERIOD_H2:
         return("H2");
         break;
      case  PERIOD_H3:
         return("H3");
         break;
      case  PERIOD_H4:
         return("H4");
         break;
      case  PERIOD_H6:
         return("H6");
         break;
      case  PERIOD_H8:
         return("H8");
         break;
      case  PERIOD_H12:
         return("H12");
         break;
      case  PERIOD_D1:
         return("D1");
         break;
      case  PERIOD_W1:
         return("W1");
         break;
      case  PERIOD_MN1:
         return("MN1");
         break;
      default:
         return("Undefined");
         break;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Util::StringToPeriod(string StringPeriod)
  {
   if(StringPeriod=="M1") return(PERIOD_M1);
   if(StringPeriod=="M2") return(PERIOD_M2);
   if(StringPeriod=="M3") return(PERIOD_M3);
   if(StringPeriod=="M4") return(PERIOD_M4);
   if(StringPeriod=="M5") return(PERIOD_M5);
   if(StringPeriod=="M6") return(PERIOD_M6);
   if(StringPeriod=="M10") return(PERIOD_M10);
   if(StringPeriod=="M12") return(PERIOD_M12);
   if(StringPeriod=="M15") return(PERIOD_M15);
   if(StringPeriod=="M20") return(PERIOD_M20);
   if(StringPeriod=="M30") return(PERIOD_M30);
   if(StringPeriod=="H1") return(PERIOD_H1);
   if(StringPeriod=="H2") return(PERIOD_H2);
   if(StringPeriod=="H3") return(PERIOD_H3);
   if(StringPeriod=="H4") return(PERIOD_H4);
   if(StringPeriod=="H6") return(PERIOD_H6);
   if(StringPeriod=="H8") return(PERIOD_H8);
   if(StringPeriod=="H12") return(PERIOD_H12);
   if(StringPeriod=="D1") return(PERIOD_D1);
   if(StringPeriod=="W1") return(PERIOD_W1);
   if(StringPeriod=="MN1") return(PERIOD_MN1);
   else return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Util::SearchPosition(CArrayObj *positions,datetime from,datetime to)
  {
   for(int i=0;i<positions.Total();i++)
     {
      Position *position=positions.At(i);
      if(position.GetTime()>=from && position.GetTime()<=to) return(i);
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime Util::SearchPosition(CArrayObj *positions,int from,int to)
  {
   if(from<0 || from>positions.Total() || to<0 || to>positions.Total() || from>to) return(-1);

   for(int i=from;i<=to;i++)
     {
      Position *position=positions.At(i);
      return(position.GetTime());
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Util::TimeToIndex(datetime time)
  {
   for(int i=0;i<Bars(Symbol(),PERIOD_CURRENT);i++)
     {
      if(Time(i)==time) return(i);
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::Open(int ind)
  {
   double OpenTemp[];
   CopyOpen(Symbol(),PERIOD_CURRENT,ind,1,OpenTemp); ArraySetAsSeries(OpenTemp,true);
   return(OpenTemp[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::Open(datetime time)
  {
   return(this.Open(this.TimeToIndex(time)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::High(int ind)
  {
   double HighTemp[];
   CopyHigh(Symbol(),PERIOD_CURRENT,ind,1,HighTemp); ArraySetAsSeries(HighTemp,true);
   return(HighTemp[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::High(datetime time)
  {
   return(this.High(this.TimeToIndex(time)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::Low(int ind)
  {
   double LowTemp[];
   CopyLow(Symbol(),PERIOD_CURRENT,ind,1,LowTemp); ArraySetAsSeries(LowTemp,true);
   return(LowTemp[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::Low(datetime time)
  {
   return(this.Low(this.TimeToIndex(time)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::Close(int ind)
  {
   double CloseTemp[];
   CopyClose(Symbol(),PERIOD_CURRENT,ind,1,CloseTemp); ArraySetAsSeries(CloseTemp,true);
   return(CloseTemp[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Util::Close(datetime time)
  {
   return(this.Close(this.TimeToIndex(time)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Util::Spread(int ind)
  {
   int SpreadTemp[];
   CopySpread(Symbol(),PERIOD_CURRENT,ind,1,SpreadTemp); ArraySetAsSeries(SpreadTemp,true);
   return(SpreadTemp[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Util::Spread(datetime time)
  {
   return(this.Spread(this.TimeToIndex(time)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime Util::Time(int ind)
  {
   datetime TimeTemp[];
   CopyTime(Symbol(),PERIOD_CURRENT,ind,1,TimeTemp); ArraySetAsSeries(TimeTemp,true);
   return(TimeTemp[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MqlRates Util::Rate(int ind)
  {
   MqlRates Rates[];
   CopyRates(Symbol(),PERIOD_CURRENT,ind,1,Rates); ArraySetAsSeries(Rates,true);
   return(Rates[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Util::MD5(string str)
  {
// Chuyển đổi sang mảng char
   uchar bytes[];StringToCharArray(str,bytes);
   CMD5Hash *MD5Hash=new CMD5Hash;
   return(MD5Hash.Hash(bytes,ArraySize(bytes)));
  }
//+------------------------------------------------------------------+
