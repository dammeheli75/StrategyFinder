//+------------------------------------------------------------------+
//|                                              SignalParameter.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class SignalParameter : public CObject
  {
protected :
   string            m_type;
   string            m_name;
   string            m_value;

public:
                     SignalParameter(string type,string name,string value);
                     SignalParameter(void);
                    ~SignalParameter(void);
   string            GetType(void);
   string            GetName(void);
   string            GetValue(void);
  };
//+------------------------------------------------------------------+
SignalParameter::SignalParameter(string type,string name,string value)
  {
   m_type = type;
   m_name = name;
   m_value= value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalParameter::SignalParameter(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalParameter::~SignalParameter(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SignalParameter::GetType(void)
  {
   return(m_type);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SignalParameter::GetName(void)
  {
   return(m_name);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SignalParameter::GetValue(void)
  {
   return(m_value);
  }
//+------------------------------------------------------------------+
