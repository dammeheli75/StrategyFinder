//+------------------------------------------------------------------+
//|                                                       Header.mqh |
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
class HttpHeader: public CObject
  {
protected:
   string            m_name;
   string            m_value;

public:
                     HttpHeader(void);
                     HttpHeader(string name,string value);
                    ~HttpHeader(void);
   void              Name(string name);
   string            Name(void);
   void              Value(string value);
   string            Value(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpHeader::HttpHeader(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpHeader::HttpHeader(string name,string value)
  {
   this.Name(name);
   this.Value(value);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpHeader::~HttpHeader(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpHeader::Name(string name)
  {
   m_name=name;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpHeader::Name(void)
  {
   if(m_name==NULL) m_name="";

   return m_name;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpHeader::Value(string value)
  {
   m_value=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpHeader::Value(void)
  {
   if(m_value==NULL) m_value="";

   return(m_value);
  }
//+------------------------------------------------------------------+