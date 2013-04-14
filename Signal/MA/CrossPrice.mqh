//+------------------------------------------------------------------+
//|                                                   CrossPrice.mqh |
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
class MACrossPrice: public Signal
  {
public:
                     MACrossPrice(void);
                    ~MACrossPrice(void);
   char              Check(void);
   bool              ValidateParameter(void);
   bool              MAPeriod(int value);
   bool              MAShift(int value);
  };
//+------------------------------------------------------------------+
MACrossPrice::MACrossPrice(void)
  {
   this.SetID("MA:CrossPrice");
   this.SetShortName("MA Cross Price");
   this.SetDescription("Đường MA cắt bar tăng thì mua, cắt bar giảm thì bán.");
   this.EveryTick(false);
   this.SignalType(SIGNAL_POINT);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MACrossPrice::~MACrossPrice(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
char MACrossPrice::Check(void)
  {
   int MAHandle;
   double MA[],OpenLocal[],CloseLocal[];

   MAHandle=iMA(Symbol(),PERIOD_CURRENT,(int)this.GetParameterValue("MAPeriod"),(int)this.GetParameterValue("MAShift"),MODE_EMA,PRICE_CLOSE);
   CopyBuffer(MAHandle,0,0,2,MA);ArraySetAsSeries(MA,true);

   CopyOpen(Symbol(),PERIOD_CURRENT,0,2,OpenLocal); ArraySetAsSeries(OpenLocal,true);
   CopyClose(Symbol(),PERIOD_CURRENT,0,2,CloseLocal); ArraySetAsSeries(CloseLocal,true);

   if(MA[1]>OpenLocal[1] && MA[1]<CloseLocal[1])
     {
      return(1);
     }
   if(MA[1]<OpenLocal[1] && MA[1]>CloseLocal[1])
     {
      return(-1);
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACrossPrice::ValidateParameter(void)
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
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACrossPrice::MAPeriod(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAPeriod",(string)value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACrossPrice::MAShift(int value)
  {
   return(this.AddParameter(new SignalParameter("int","MAShift",(string)value)));
  }
//+------------------------------------------------------------------+
