//+------------------------------------------------------------------+
//|                                                 ZeroPosition.mqh |
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
class MACDZeroPosition: public Signal
  {
protected:

public:
                     MACDZeroPosition(void);
                    ~MACDZeroPosition(void);
   char              Check(void);
   bool              ValidateParameter(void);
   bool              FastEMAPeriod(int value);
   bool              SlowEMAPeriod(int value);
   bool              SignalPeriod(int value);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDZeroPosition::MACDZeroPosition(void)
  {
   this.SetID("MACD:ZeroPosition");
   this.SetShortName("MACD Zero Position");
   this.SetDescription("Mua khi MACD lớn hơn 0, bán khi MACD nhỏ hơn 0.");
   this.EveryTick(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDZeroPosition::~MACDZeroPosition(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MACDZeroPosition::Check(void)
  {
   int MACDHandle;
   double MACD[];

   MACDHandle=iMACD(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("FastEMAPeriod"),(int)this.GetParameterValue("SlowEMAPeriod"),(int)this.GetParameterValue("SignalPeriod"),PRICE_CLOSE);
   CopyBuffer(MACDHandle,0,0,2,MACD); ArraySetAsSeries(MACD,true);

   if(MACD[1]>0)
     {
      return(1);
     }
   if(MACD[1]<0)
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroPosition::ValidateParameter(void)
  {
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroPosition::FastEMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","FastEMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroPosition::SlowEMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SlowEMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDZeroPosition::SignalPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SignalPeriod",(string)value)));
  }
//+------------------------------------------------------------------+