//+------------------------------------------------------------------+
//|                                                         File.mqh |
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
class HttpFile: public CObject
  {
protected:
   string            m_name;
   string            m_path;
   string            m_path_escaped;
   string            m_content_type;

public:
                     HttpFile(void);
                     HttpFile(string name,string path,string content_type="text/plain");
                    ~HttpFile(void);
   void              ContentType(string content_type);
   string            ContentType(void);
   void              Name(string name);
   string            Name(void);
   void              Path(string path);
   string            Path(bool escapse=false);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpFile::HttpFile(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpFile::HttpFile(string name,string path,string content_type="text/plain")
  {
   this.Name(name);
   this.Path(path);
   this.ContentType(content_type);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpFile::~HttpFile(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpFile::ContentType(string content_type)
  {
   if(StringLen(content_type)>0)
      m_content_type=content_type;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpFile::ContentType(void)
  {
   if(StringLen(m_content_type)<1) m_content_type="text/plain";
   return(m_content_type);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  HttpFile::Name(string name)
  {
   if(StringLen(name)>0)
      m_name=name;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpFile::Name(void)
  {
   if(m_name==NULL) m_name="";

   return(m_name);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpFile::Path(string path)
  {
   m_path=path;
   StringReplace(path,"\\","\\\\");
   m_path_escaped=path;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpFile::Path(bool escape=false)
  {
   if(m_path==NULL) m_path="";
   if(escape)
      return(m_path_escaped);

   return(m_path);
  }
//+------------------------------------------------------------------+
