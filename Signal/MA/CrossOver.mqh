//+------------------------------------------------------------------+
//|                                                    CrossOver.mqh |
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
class MACrossOver: public Signal
  {
protected:

public:
                     MACrossOver(void);
                    ~MACrossOver(void);
   char              Check(void);
   bool              ValidateParameter(void);
   bool              FastMAPeriod(int value);
   bool              SlowMAPeriod(int value);
   bool              FastMAShift(int value);
   bool              SlowMAShift(int value);
  };
//+------------------------------------------------------------------+
MACrossOver::MACrossOver(void)
  {
   this.SetID("MA:CrossOver");
   this.SetShortName("MA CrossOver");
   this.SetDescription("Tín hiệu giao dịch dựa trên 2 đường MA cắt nhau. MA nhanh cắt lên MA chậm là tín hiệu mua, MA nhanh cắt xuống MA chậm là tín hiệu bán");
   this.EveryTick(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACrossOver::~MACrossOver(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MACrossOver::Check(void)
  {
   int FastMAHandle,SlowMAHandle;
   double FastMA[],SlowMA[];

   FastMAHandle=iMA(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("FastMAPeriod"),(int)this.GetParameterValue("FastMAShift"),MODE_EMA,PRICE_CLOSE);
   CopyBuffer(FastMAHandle,0,0,3,FastMA); ArraySetAsSeries(FastMA,true);
   SlowMAHandle=iMA(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("SlowMAPeriod"),(int)this.GetParameterValue("SlowMAShift"),MODE_EMA,PRICE_CLOSE);
   CopyBuffer(SlowMAHandle,0,0,3,SlowMA); ArraySetAsSeries(SlowMA,true);

   if(FastMA[1]>SlowMA[1] && FastMA[2]<SlowMA[2])
     {
      return(1);
     }
   if(FastMA[1]<SlowMA[1] && FastMA[2]>SlowMA[2])
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool  MACrossOver::ValidateParameter(void)
  {
   if(!this.ParameterExists("FastMAPeriod"))
     {
      Print("Signal: \""+this.GetID()+"\" thiếu tham số FastMAPeriod");
      return(false);
     }
   else if(!this.ParameterExists("SlowMAPeriod"))
     {
      Print("Signal: \""+this.GetID()+"\" thiếu tham số SlowMAPeriod");
      return(false);
     }
   else if(!this.ParameterExists("FastMAShift"))
     {
      Print("Signal: \""+this.GetID()+"\" thiếu tham số FastMAShift");
      return(false);
     }
   else if(!this.ParameterExists("SlowMAShift"))
     {
      Print("Signal: \""+this.GetID()+"\" thiếu tham số SlowMAShift");
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACrossOver::FastMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","FastMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACrossOver::SlowMAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SlowMAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACrossOver::FastMAShift(int value)
  {
   return(this.AddParameter(new SignalParameter("int","FastMAShift",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACrossOver::SlowMAShift(int value)
  {
   return(this.AddParameter(new SignalParameter("int","SlowMAShift",(string)value)));
  }
//+------------------------------------------------------------------+
