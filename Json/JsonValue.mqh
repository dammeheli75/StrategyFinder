//+------------------------------------------------------------------+
//|                                                    JsonValue.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
#include "Json.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class JsonValue: public Json
  {
public:
                     JsonValue(void);
                    ~JsonValue(void);
  };
//+------------------------------------------------------------------+
