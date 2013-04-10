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
#include "Finder.mqh"
#include "Position.mqh"
#include "Signal\MA\CrossOver.mqh"
#include "Signal\MA\CrossPrice.mqh"
#include "Signal\MACD\CrossOver.mqh"
//+------------------------------------------------------------------+
//| Các biến Global                                                  |
//+------------------------------------------------------------------+
Finder finder;
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
