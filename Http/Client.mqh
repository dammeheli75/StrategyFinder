//+------------------------------------------------------------------+
//|                                                       Client.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "wininet.dll"
int InternetAttemptConnect(int x);
int InternetOpenW(string &sAgent,int lAccessType,string &sProxyName,string &sProxyBypass,int lFlags);
int InternetConnectW(int hInternet,string &szServerName,int nServerPort,string &lpszUsername,string &lpszPassword,int dwService,int dwFlags,int dwContext);
int HttpOpenRequestW(int hConnect,string &Verb,string &ObjectName,string &Version,string &Referer,string &AcceptTypes,uint dwFlags,int dwContext);
int HttpSendRequestW(int hRequest,string &lpszHeaders,int dwHeadersLength,uchar &lpOptional[],int dwOptionalLength);
int HttpQueryInfoW(int hRequest,int dwInfoLevel,int &lpvBuffer[],int &lpdwBufferLength,int &lpdwIndex);
int InternetReadFile(int hFile,uchar &sBuffer[],int lNumBytesToRead,int &lNumberOfBytesRead);
int InternetCloseHandle(int hInet);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//To make it clear, we will use the constant names from wininet.h.
#define OPEN_TYPE_PRECONFIG     0           // use the configuration by default
#define FLAG_KEEP_CONNECTION    0x00400000  // do not terminate the connection
#define FLAG_PRAGMA_NOCACHE     0x00000100  // no cashing of the page
#define FLAG_RELOAD             0x80000000  // receive the page from the server when accessing it
#define SERVICE_HTTP            3           // the required protocol
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
#include <Arrays\ArrayObj.mqh>
#include "Header.mqh"
#include "Parameter.mqh"
#include "File.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class HttpClient: CObject
  {
protected:
   enum HTTP_METHOD
     {
      HTTP_OPTIONS=0,// OPTIONS
      HTTP_GET= 1,// GET
      HTTP_HEAD=2,// HEAD
      HTTP_POST=3,// POST
      HTTP_PUT=4,// PUT
      HTTP_DELETE=5,// DELETE
      HTTP_TRACE=6,// TRACE
      HTTP_CONNECT=7,// CONNECT
      HTTP_PATCH=8,// PATCH
      HTTP_PROPFIND=9 // PROPFIND
     };

   string            m_useragent;
   int               m_connection;
   int               m_session;
   string            m_host;
   int               m_port;
   HTTP_METHOD       m_method;
   string            m_proxy_name;
   string            m_proxy_bypass;
   string            m_username;
   string            m_password;
   string            m_http_version;
   bool              m_keep_alive;

   CArrayObj         m_headers;
   CArrayObj         m_parameters;
   CArrayObj         m_files;

   int               ConnectReal(void);

public:
                     HttpClient(void);
                    ~HttpClient(void);
   void              Host(string host);
   string            Host(void);
   void              Port(int port);
   int               Port(void);
   void              Method(HTTP_METHOD method);
   HTTP_METHOD       Method(void);
   void              UserAgent(string useragent);
   string            UserAgent(void);
   void              ProxyName(string proxyname);
   string            ProxyName(void);
   void              ProxyByPass(string proxybypass);
   string            ProxyByPass(void);
   void              UserName(string username);
   string            UserName(void);
   void              Password(string password);
   string            Password(void);
   void              HttpVersion(string http_version);
   string            HttpVersion(void);
   void              KeepAlive(bool keepalive);
   bool              KeepAlive(void);
   int               Connect(string host,int port=80);
   int               Connect(void);
   string            Send(void);
   void              Close(void);
   void              Connection(int connection);
   int               Connection(void);
   void              Session(int session);
   int               Session(void);
   bool              RequestHeader(string name,string value);
   string            RequestHeader(string name);
   bool              RequestParameter(string name,string value);
   string            RequestParameter(string name);
   bool              RequestFile(string name,string path);
   string            RequestFile(string name);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpClient::HttpClient(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HttpClient::~HttpClient(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::Host(string host)
  {
   if(host!=NULL)
      m_host=host;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::Host(void)
  {
   if(m_host==NULL)
      m_host="";

   return(m_host);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::Port(int port)
  {
   if(port!=NULL)
      m_port=port;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HttpClient::Port(void)
  {
   if(m_port==NULL) m_port=80;

   return(m_port);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::Method(HTTP_METHOD method)
  {
   m_method=method;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HTTP_METHOD HttpClient::Method(void)
  {
   if(m_method==NULL) m_method=HTTP_GET;

   return(m_method);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::UserAgent(string useragent)
  {
   if(StringLen(useragent)>0) m_useragent=useragent;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::UserAgent(void)
  {
   if(StringLen(m_useragent)<1)
      m_useragent="Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31";

   return(m_useragent);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::ProxyName(string proxyname)
  {
   if(proxyname!=NULL)
      m_proxy_name=proxyname;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::ProxyName(void)
  {
   if(m_proxy_name== NULL)
      m_proxy_name="";

   return(m_proxy_name);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::ProxyByPass(string proxybypass)
  {
   if(proxybypass!=NULL)
      m_proxy_bypass=proxybypass;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::ProxyByPass(void)
  {
   if(m_proxy_bypass==NULL)
      m_proxy_bypass="";

   return(m_proxy_bypass);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::UserName(string username)
  {
   if(username!=NULL)
      m_username=username;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::UserName(void)
  {
   if(m_username==NULL)
      m_username="";

   return(m_username);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::Password(string password)
  {
   if(password!=NULL)
      m_password=password;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::Password(void)
  {
   if(m_password== NULL)
      m_password="";

   return(m_password);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::HttpVersion(string http_version)
  {
   if(StringLen(http_version)>0) m_http_version=http_version;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::HttpVersion(void)
  {
   if(StringLen(m_http_version)<1) m_http_version="HTTP/1.1";

   return(m_http_version);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::KeepAlive(bool keepalive)
  {
   m_keep_alive=keepalive;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HttpClient::KeepAlive(void)
  {
   return(m_keep_alive);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HttpClient::Connect(string host,int port=80)
  {
   this.Host(host);
   this.Port(port);

   return(this.ConnectReal());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HttpClient::Connect(void)
  {
   return(this.ConnectReal());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::Send(void)
  {
   return(NULL);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HttpClient::ConnectReal(void)
  {
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Print("DLL is not allowed.");
      return(-1);
     }
   if(InternetAttemptConnect(0)!=0)
     {
      Print("-Err AttemptConnect");
      return(false);
     }
// open a session
   string UserAgent   = UserAgent();
   string ProxyName   = ProxyName();
   string ProxyByPass = ProxyByPass();
   m_session=InternetOpenW(UserAgent,OPEN_TYPE_PRECONFIG,ProxyName,ProxyByPass,0);
// if we were not able to open a session, then exit
   if(m_session<=0)
     {
      Print("Error create Session");
      //Close();
      return(false);
     }
//int InternetConnectW(int hInternet,string &szServerName,int nServerPort,string &lpszUsername,string &lpszPassword,int dwService,int dwFlags,int dwContext);
   string Host=Host();
   int    Port=Port();
   string UserName = UserName();
   string Password = Password();
   m_connection=InternetConnectW(m_session,Host,Port,UserName,Password,SERVICE_HTTP,0,0);
   if(m_connection<=0)
     {
      Print("Error create Connection");
      //Close();
      return(false);
     }

   return(m_connection);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::Close(void)
  {
   Print("Closing Connection...");
   if(m_session>0) InternetCloseHandle(m_session); m_session=-1;
   if(m_connection>0) InternetCloseHandle(m_connection); m_connection=-1;
   Print("Connection to ",Host(),":",Port()," is closed.");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::Connection(int connection)
  {
   m_connection=connection;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HttpClient::Connection(void)
  {
   return(m_connection);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HttpClient::Session(int session)
  {
   m_session=session;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HttpClient::Session(void)
  {
   return(m_session);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HttpClient::RequestHeader(string name,string value)
  {
   for(int i=0;i<m_headers.Total();i++)
     {
      HttpHeader *header=m_headers.At(i);
      if(header.Name()==name)
        {
         header.Value(value);
         return(true);
        }
     }
   return(m_headers.Add(new HttpHeader(name,value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::RequestHeader(string name)
  {
   for(int i=0;i<m_headers.Total();i++)
     {
      HttpHeader *header=m_headers.At(i);
      if(header.Name()==name)
         return(header.Value());
     }
   return(NULL);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HttpClient::RequestParameter(string name,string value)
  {
   for(int i=0;i<m_parameters.Total();i++)
     {
      HttpParameter *parameter=m_parameters.At(i);
      if(parameter.Name()==name)
        {
         parameter.Value(value);
         return(true);
        }
     }
   return(m_parameters.Add(new HttpParameter(name,value)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::RequestParameter(string name)
  {
   for(int i=0;i<m_parameters.Total();i++)
     {
      HttpParameter *parameter=m_parameters.At(i);
      if(parameter.Name()==name)
         return(parameter.Value());
     }
   return(NULL);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HttpClient::RequestFile(string name,string path)
  {
   for(int i=0;i<m_files.Total();i++)
     {
      HttpFile *file=m_files.At(i);
      if(file.Name()==name)
        {
         file.Path(path);
         return(true);
        }
     }
   return(m_files.Add(new HttpFile(name,path)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HttpClient::RequestFile(string name)
  {
   for(int i=0;i<m_files.Total();i++)
     {
      HttpFile *file=m_files.At(i);
      if(file.Name()==name)
         return(file.Path());
     }
   return(NULL);
  }
//+------------------------------------------------------------------+
