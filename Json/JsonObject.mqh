//+------------------------------------------------------------------+
//|                                                   JsonObject.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
#include <Arrays\ArrayObj.mqh>
#include "Json.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class JsonObject: public Json
  {
public:
                     JsonObject(void);
                    ~JsonObject(void);
  };
//+------------------------------------------------------------------+
