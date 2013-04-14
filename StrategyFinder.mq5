//+------------------------------------------------------------------+
//|                                               StrategyFinder.mq5 |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
#property version   "1.00"

//+------------------------------------------------------------------+
//| #include                                                         |
//+------------------------------------------------------------------+
#include <Charts\Chart.mqh>

// Custom library
#include "Util.mqh";
#include "Finder.mqh"
#include "Position.mqh"
#include "Signal\MA\CrossOver.mqh"
#include "Signal\MA\CrossPrice.mqh"
#include "Signal\MACD\CrossOver.mqh"
//+------------------------------------------------------------------+
//| Các biến Global                                                  |
//+------------------------------------------------------------------+
Finder finder;
Util *util=new Util;
datetime AttachTime; // Thời gian EA được attach vào chart
//+------------------------------------------------------------------+
//| Các hằng số đầu vào                                              |
//+------------------------------------------------------------------+
sinput int ZigZagDepth=12;
sinput int ZigZagDeviation=5;
sinput int ZigZagBackstep=3;
//+------------------------------------------------------------------+
//| Các biến đầu vào                                                 |
//+------------------------------------------------------------------+
// MA:CrossOver
input int FastMAPeriod=10;
input int FastMAShift = 0;
input int SlowMAPeriod= 20;
input int SlowMAShift = 0;
// MA:CrossPrice
input int MAPeriod= 14;
input int MAShift = 0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
// Thiết lập Attach Time
   AttachTime=Time(0);
   Print("Attach Time: ",(string)AttachTime);
// Thiết lập tham số cho Signal
// MA:CrossOver
   MACrossOver *ma_crossover=new MACrossOver;
   ma_crossover.FastMAPeriod(FastMAPeriod);ma_crossover.FastMAShift(FastMAShift);
   ma_crossover.SlowMAPeriod(SlowMAPeriod);ma_crossover.SlowMAShift(SlowMAShift);
   finder.AddSignal(ma_crossover);
// MA:CrossPrice
   MACrossPrice *ma_crossprice=new MACrossPrice;
   ma_crossprice.MAPeriod(MAPeriod); ma_crossprice.MAShift(MAShift);
//finder.AddSignal(ma_crossprice);
// MACD:CrossOver
   MACDCrossOver *macd_crossover=new MACDCrossOver;
//finder.AddSignal(macd_crossover);
//---
   return(0);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   finder.SaveJSON();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   finder.Run();
   Comment("Tick Volume: "+(string)Rate(0).tick_volume);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---

  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction &trans,
                        const MqlTradeRequest &request,
                        const MqlTradeResult &result)
  {
//---

  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| TesterInit function                                              |
//+------------------------------------------------------------------+
void OnTesterInit()
  {
//---

  }
//+------------------------------------------------------------------+
//| TesterPass function                                              |
//+------------------------------------------------------------------+
void OnTesterPass()
  {
//---

  }
//+------------------------------------------------------------------+
//| TesterDeinit function                                            |
//+------------------------------------------------------------------+
void OnTesterDeinit()
  {
//---

  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
//---

  }
//+------------------------------------------------------------------+
//| Global Version of Util::Open(int)                                |
//+------------------------------------------------------------------+
double Open(int ind)
  {
   return(util.Open(ind));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Open(datetime)                           |
//+------------------------------------------------------------------+
double Open(datetime time)
  {
   return(util.Open(time));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::High(int)                                |
//+------------------------------------------------------------------+
double High(int ind)
  {
   return(util.High(ind));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::High(datetime)                           |
//+------------------------------------------------------------------+
double High(datetime time)
  {
   return(util.High(time));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Low(int)                                 |
//+------------------------------------------------------------------+
double Low(int ind)
  {
   return(util.Low(ind));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Low(datetime)                            |
//+------------------------------------------------------------------+
double Low(datetime time)
  {
   return(util.Low(time));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Close(int)                               |
//+------------------------------------------------------------------+
double Close(int ind)
  {
   return(util.Close(ind));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Close(datetime)                          |
//+------------------------------------------------------------------+
double Close(datetime time)
  {
   return(util.Close(time));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Spread(int)                              |
//+------------------------------------------------------------------+
int Spread(int ind)
  {
   return(util.Spread(ind));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Spread(datetime)                         |
//+------------------------------------------------------------------+
int Spread(datetime time)
  {
   return(util.Spread(time));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Time                                     |
//+------------------------------------------------------------------+
datetime Time(int ind)
  {
   return(util.Time(ind));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::Tick                                     |
//+------------------------------------------------------------------+
MqlRates Rate(int ind)
  {
   return(util.Rate(ind));
  }
//+------------------------------------------------------------------+
//| Global Version of Util::MD5(string)                              |
//+------------------------------------------------------------------+
string md5(string str)
  {
   return(util.MD5(str));
  }
//+------------------------------------------------------------------+
