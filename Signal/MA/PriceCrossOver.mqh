//+------------------------------------------------------------------+
//|                                               PriceCrossOver.mqh |
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
class MAPriceCrossOver: public Signal
  {
protected:

public:
                     MAPriceCrossOver(void);
                    ~MAPriceCrossOver(void);
   char              Check(void);
   bool              ValidateParameter(void);
   bool              MAPeriod(int value);
   bool              MAShift(int value);
   bool              MAMethod(int value);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MAPriceCrossOver::MAPriceCrossOver(void)
  {
   this.SetID("MA:PriceCrossOver");
   this.SetShortName("MA Price CrossOver");
   this.SetDescription("Mua khi MA cắt bar tăng, bán khi MA cắt bar giảm.");
   this.EveryTick(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MAPriceCrossOver::~MAPriceCrossOver(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MAPriceCrossOver::Check(void)
  {
   int MAHandle;
   double MA[];

   MAHandle=iMA(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("MAPeriod"),(int)this.GetParameterValue("MAShift"),(ENUM_MA_METHOD)(int)this.GetParameterValue("MAMethod"),PRICE_CLOSE);
   CopyBuffer(MAHandle,0,0,2,MA); ArraySetAsSeries(MA,true);

   if(Open(1)<MA[1] && Close(1)>MA[1])
     {
      return(1);
     }
   if(Open(1)>MA[1] && Close(1)<MA[1])
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MAPriceCrossOver::ValidateParameter(void)
  {
   if(!this.ParameterExists("MAPeriod"))
     {
      Print("Signal: \""+this.GetID()+"\" thiếu tham số MAPeriod");
      return(false);
     }
   else if(!this.ParameterExists("MAShift"))
     {
      Print("Signal: \""+this.GetID()+"\" thiếu tham số MAShift");
      return(false);
     }
   else if(!this.ParameterExists("MAMethod"))
     {
      Print("Signal: \""+this.GetID()+"\" thiếu tham số MAMethod");
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MAPriceCrossOver::MAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MAPriceCrossOver::MAShift(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAShift",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MAPriceCrossOver::MAMethod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAMethod",(string)value)));
  }
//+------------------------------------------------------------------+
