//+------------------------------------------------------------------+
//|                                                    Direction.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include "..\Signal.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MACDDirection: public Signal
  {
protected:

public:
                     MACDDirection(void);
                    ~MACDDirection(void);
   char              Check(void);
   bool              ValidateParameter(void);
   bool              FastEMAPeriod(int value);
   bool              SlowEMAPeriod(int value);
   bool              SignalPeriod(int value);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDDirection::MACDDirection(void)
  {
   this.SetID("MACD:Direction");
   this.SetShortName("MACD Direction");
   this.SetDescription("Mua khi MACD tăng, bán khi MACD giảm.");
   this.EveryTick(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDDirection::~MACDDirection(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MACDDirection::Check(void)
  {
   int MACDHandle;
   double MACD[];

   MACDHandle=iMACD(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("FastEMAPeriod"),(int)this.GetParameterValue("SlowEMAPeriod"),(int)this.GetParameterValue("SignalPeriod"),PRICE_CLOSE);
   CopyBuffer(MACDHandle,0,0,3,MACD); ArraySetAsSeries(MACD,true);

   if(MACD[2]<MACD[1])
     {
      return(1);
     }
   if(MACD[2]>MACD[1])
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDDirection::ValidateParameter(void)
  {
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDDirection::FastEMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","FastEMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDDirection::SlowEMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SlowEMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDDirection::SignalPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SignalPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
