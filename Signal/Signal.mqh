//+------------------------------------------------------------------+
//|                                                       Signal.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
#include <Arrays\ArrayString.mqh>
#include <Arrays\ArrayObj.mqh>
#include "SignalParameter.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Signal: public CObject
  {
protected:
   string            m_id;
   string            m_shortname;
   string            m_description;
   bool              m_every_tick;
   CArrayObj         m_parameter;

public:
                     Signal(void);
                    ~Signal(void);
   string            GetID(void);
   virtual void      SetID(string id);
   string            GetShortName(void);
   virtual void      SetShortName(string shortname);
   string            GetDescription(void);
   virtual void      SetDescription(string desc);
   string            GetParameterValue(string name); // Get by name
   string            GetParameterValue(int index); // Get by index
   string            GetParameterType(string name); // Get by name
   string            GetParameterType(int index); // Get by index
   virtual bool      ValidateParameter(void);
   bool              ParameterExists(string name);
   bool              ParameterExists(int index);
   virtual bool      EveryTick(void);
   virtual void      EveryTick(bool every_tick);
   bool              AddParameter(SignalParameter *parameter);
   string            GetJSONString();
   virtual char      Check(void);
   string            Unique(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Signal::Signal(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Signal::~Signal(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Signal::GetID(void)
  {
   return(m_id);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Signal::SetID(string id)
  {
   m_id=id;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Signal::GetShortName(void)
  {
   return(m_shortname);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Signal::SetShortName(string shortname)
  {
   m_shortname=shortname;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Signal::GetDescription(void)
  {
   return(m_description);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Signal::SetDescription(string desc)
  {
   m_description=desc;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Signal::GetParameterValue(string name)
  {
   for(int i=0;i<m_parameter.Total();i++)
     {
      SignalParameter *parameter=m_parameter.At(i);
      if(parameter.GetName()==name)
        {
         return(parameter.GetValue());
        }
     }
   return("");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Signal::GetParameterValue(int index)
  {
   SignalParameter *parameter=m_parameter.At(index);
   return(parameter.GetValue());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Signal::GetParameterType(string name)
  {
   for(int i=0;i<m_parameter.Total();i++)
     {
      SignalParameter *parameter=m_parameter.At(i);
      if(parameter.GetName()==name)
        {
         return(parameter.GetType());
        }
     }
   return("");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Signal::GetParameterType(int index)
  {
   SignalParameter *parameter=m_parameter.At(index);
   return(parameter.GetType());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Signal::ValidateParameter(void)
  {
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Signal::ParameterExists(int index)
  {
   if(index>=0 && index<m_parameter.Total())
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Signal::ParameterExists(string name)
  {
   for(int i=0;i<m_parameter.Total();i++)
     {
      SignalParameter *parameter=m_parameter.At(i);
      if(parameter.GetName()==name)
        {
         return(true);
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Signal::EveryTick(void)
  {
   return m_every_tick;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Signal::EveryTick(bool every_tick)
  {
   m_every_tick=every_tick;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Signal::AddParameter(SignalParameter *parameter)
  {
   return(m_parameter.Add(parameter));
  }
//+------------------------------------------------------------------+
//| Hàm này cực kỳ hữu ích, nó giúp tạo ra một chuỗi duy nhất cho    |
//| mỗi tín hiệu với cặp tham số khác nhau                           |
//+------------------------------------------------------------------+
string Signal::Unique(void)
  {
   string StringInput="",UniqueString;
   for(int i=0;i<m_parameter.Total();i++)
     {
      SignalParameter *parameter=m_parameter.At(i);

      // Chỉ lưu lại nếu name và type có giá trị
      if(StringLen(parameter.GetName())>0)
        {
         StringInput+=(string)parameter.GetName()+":"+(string)parameter.GetValue()+"|";
        }
     }
   if(StringLen(StringInput)>0)
     {
      StringTrimLeft(StringInput);StringTrimRight(StringInput); // Xóa bỏ khoảng trắng ở đầu và cuối
      StringInput=StringSubstr(StringInput,0,StringLen(StringInput)-1);
     }
   else
     {
      StringInput="NoInput";
     }
   StringInput=this.GetID()+StringInput;
// MD5 chuỗi StringInput để được chuỗi Unique
   UniqueString=md5(StringInput); // MD5-hash

   return(UniqueString);
  }
//+------------------------------------------------------------------+
string Signal::GetJSONString(void)
  {
   string JSON;
   CArrayString JSONPart;

   JSONPart.Add("{");
   JSONPart.Add("\"ID\":"+"\""+this.GetID()+"\"");JSONPart.Add(",");
   JSONPart.Add("\"ShortName\":"+"\""+this.GetShortName()+"\"");JSONPart.Add(",");
   JSONPart.Add("\"Description\":"+"\""+this.GetDescription()+"\"");JSONPart.Add(",");
   JSONPart.Add("\"parameters\":");
   JSONPart.Add("[");
// Parameter
   if(m_parameter.Total()>0)
     {

      for(int i=0;i<m_parameter.Total();i++)
        {
         SignalParameter *parameter=m_parameter.At(i);
         JSONPart.Add("{");
         JSONPart.Add("\"type\":"+"\""+parameter.GetType()+"\"");JSONPart.Add(",");
         JSONPart.Add("\"name\":"+"\""+parameter.GetName()+"\"");JSONPart.Add(",");
         JSONPart.Add("\"value\":"+"\""+parameter.GetValue()+"\"");
         JSONPart.Add("}");
         JSONPart.Add(",");
        }
      // Xóa dấu phẩy (,) cuối cùng
      JSONPart.Delete(JSONPart.Total()-1);
     }
   JSONPart.Add("]");
   JSONPart.Add("}");
//--- Gộp dữ liệu vào chuỗi JSON
   for(int i=0;i<JSONPart.Total();i++)
     {
      JSON=JSON+JSONPart.At(i);
     }
   return(JSON);
  }
//+------------------------------------------------------------------+
char Signal::Check(void)
  {
   return(0);
  }
//+------------------------------------------------------------------+
