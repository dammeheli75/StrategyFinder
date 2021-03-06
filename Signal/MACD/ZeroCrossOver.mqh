//+------------------------------------------------------------------+
//|                                                ZeroCrossOver.mqh |
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
class MACDZeroCrossOver: public Signal
  {
protected:

public:
                     MACDZeroCrossOver(void);
                    ~MACDZeroCrossOver(void);
   char              Check(void);
   bool              ValidateParameter(void);
   bool              FastEMAPeriod(int value);
   bool              SlowEMAPeriod(int value);
   bool              SignalPeriod(int value);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDZeroCrossOver::MACDZeroCrossOver(void)
  {
   this.SetID("MACD:ZeroCrossOver");
   this.SetShortName("MACD Zero CrossOver");
   this.SetDescription("Mua khi MACD cắt lên đường level 0, bán khi MACD cắt xuống đường level 0.");
   this.EveryTick(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDZeroCrossOver::~MACDZeroCrossOver(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MACDZeroCrossOver::Check(void)
  {
   int MACDHandle;
   double MACD[];

   MACDHandle=iMACD(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("FastEMAPeriod"),(int)this.GetParameterValue("SlowEMAPeriod"),(int)this.GetParameterValue("SignalPeriod"),PRICE_CLOSE);
   CopyBuffer(MACDHandle,0,0,3,MACD); ArraySetAsSeries(MACD,true);

   if(MACD[2]<0 && MACD[1]>0)
     {
      return(1);
     }
   if(MACD[2]>0 && MACD[1]<0)
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroCrossOver::ValidateParameter(void)
  {
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroCrossOver::FastEMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","FastEMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroCrossOver::SlowEMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SlowEMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroCrossOver::SignalPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SignalPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
