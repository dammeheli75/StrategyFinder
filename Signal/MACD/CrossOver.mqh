//+------------------------------------------------------------------+
//|                                                    CrossOver.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//| #include                                                         |
//+------------------------------------------------------------------+
#include "..\Signal.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MACDCrossOver: public Signal
  {
protected:

public:
                     MACDCrossOver(void);
                    ~MACDCrossOver(void);
   char              Check(void);
   bool              ValidateParameter(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDCrossOver::MACDCrossOver(void)
  {
   this.SetID("MACD:CrossOver");
   this.SetShortName("MACD Signal Cross Over");
   this.SetDescription("Đường Signal cắt lên đường MACD và MACD đang dương thì bán. Đường Signal cắt xuống đường MACD và MACD âm thì mua.");
   this.EveryTick(false);
   this.SignalType(SIGNAL_POINT);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACDCrossOver::~MACDCrossOver(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACDCrossOver::ValidateParameter(void)
  {
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MACDCrossOver::Check(void)
  {
   int MACDHandle;
   double MACDLine[],SignalLine[];

   MACDHandle=iMACD(Symbol(),PERIOD_CURRENT,26,12,9,PRICE_CLOSE);
   CopyBuffer(MACDHandle,0,0,3,MACDLine); // Main Line
   CopyBuffer(MACDHandle,1,0,3,SignalLine); // Signal Line
   ArraySetAsSeries(MACDLine,true);
   ArraySetAsSeries(SignalLine,true);

   if(MACDLine[1]>SignalLine[1] && MACDLine[2]<SignalLine[2] && MACDLine[1]<0)
     {
      return(1);
     }
   if(MACDLine[1]<SignalLine[1] && MACDLine[2]>SignalLine[2] && MACDLine[1]>0)
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+"
