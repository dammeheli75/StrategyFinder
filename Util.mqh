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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Util: public CObject
  {
protected:

public:
                     Util(void);
                    ~Util(void);
   string            PeriodToString(int period);
   int               StringToPeriod(string StringPeriod);
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
string Util::PeriodToString(int period)
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
