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
class MADirection: public Signal
  {
protected:

public:
                     MADirection(void);
                    ~MADirection(void);
   char              Check(void);
   bool              ValidateParameter(void);
   bool              MAPeriod(int value);
   bool              MAShift(int value);
   bool              MAMethod(int value);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MADirection::MADirection(void)
  {
   this.SetID("MA:Direction");
   this.SetShortName("MA Direction");
   this.SetDescription("Mua khi MA tăng, bán khi MA giảm.");
   this.EveryTick(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MADirection::~MADirection(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MADirection::Check(void)
  {
   int MAHandle;
   double MA[];

   MAHandle=iMA(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("MAPeriod"),(int)this.GetParameterValue("MAShift"),(ENUM_MA_METHOD)(int)this.GetParameterValue("MAMethod"),PRICE_CLOSE);
   CopyBuffer(MAHandle,0,0,3,MA); ArraySetAsSeries(MA,true);

   if(MA[2]<MA[1])
     {
      return(1);
     }
   if(MA[2]>MA[1])
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MADirection::ValidateParameter(void)
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
bool MADirection::MAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MADirection::MAShift(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAShift",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MADirection::MAMethod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAMethod",(string)value)));
  }
//+------------------------------------------------------------------+
