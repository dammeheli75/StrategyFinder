//+------------------------------------------------------------------+
//|                                                       ZigZag.mqh |
//|                                         Created by Luu Hoang Nam |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Created by Luu Hoang Nam"
#property link      "http://www.mql5.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Object.mqh>
#include <Arrays\ArrayInt.mqh>
#include <Arrays\ArrayObj.mqh>
#include "ZigZagPoint.mqh";
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ZigZag: public CObject
  {
protected:
   int               m_depth;
   int               m_deviation;
   int               m_backstep;
   int               m_handle; // ZigZag Handle
   CArrayObj         m_points;

public:
                     ZigZag(void);
                    ~ZigZag(void);
   void              Init(void);
   void              Depth(int depth);
   int               Depth(void);
   void              Deviation(int deviation);
   int               Deviation(void);
   void              Backstep(int backstep);
   int               Backstep(void);
   int               Handle(void);
   void              Handle(int ZigZagHandle);
   bool              AddPoint(ZigZagPoint *point);
   int               CountPoint(void);
   int               FindPoint(datetime time);
   int               GetLastPoint(void);
   datetime          GetTime(int ind);
   double            GetPrice(int ind);
   bool              IsTop(int ind);
   bool              IsBottom(int ind);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ZigZag::ZigZag(void)
  {
   this.Init();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ZigZag::~ZigZag(void)
  {
   IndicatorRelease(this.Handle());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ZigZag::Init(void)
  {
// Thiết lập giá trị mặc định
   if(m_depth==NULL) m_depth=12;
   if(m_deviation==NULL) m_deviation=5;
   if(m_backstep==NULL) m_backstep=3;
   if(m_handle==NULL || m_handle<0) m_handle=iCustom(Symbol(),PERIOD_CURRENT,"Examples\ZigzagColor",this.Depth(),this.Deviation(),this.Backstep());

// Lấy vị trí của 4 điểm ZigZag mới nhất
   int i; bool stop;
   for(i=1,stop=false;i<Bars(Symbol(),PERIOD_CURRENT) && stop!=true;i++)
     {
      double Top[],Bottom[];
      CopyBuffer(this.Handle(),0,0,i,Top);ArraySetAsSeries(Top,true);
      CopyBuffer(this.Handle(),1,0,i,Bottom);ArraySetAsSeries(Bottom,true);

      for(int j=0;j<i;j++)
        {
         if(Top[j]!=0)
           {
            ZigZagPoint *point=new ZigZagPoint;
            point.SetTime(Time(j));
            point.SetPrice(Top[j]);
            point.SetTop();
            this.AddPoint(point);
           }
         if(Bottom[j]!=0)
           {
            ZigZagPoint *point=new ZigZagPoint;
            point.SetTime(Time(j));
            point.SetPrice(Bottom[j]);
            point.SetBottom();
            this.AddPoint(point);
           }
         if(m_points.Total()==4) break;
        }
      if(m_points.Total()==4) break;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ZigZag::Depth(int depth)
  {
   if(depth!=m_depth)
     {
      m_depth=depth;
      this.Init();
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ZigZag::Depth(void)
  {
   return(m_depth);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ZigZag::Deviation(int deviation)
  {
   if(deviation!=m_deviation)
     {
      m_deviation=deviation;
      this.Init();
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ZigZag::Deviation(void)
  {
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ZigZag::Backstep(int backstep)
  {
   if(backstep!=m_backstep)
     {
      m_backstep=backstep;
      this.Init();
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ZigZag::Backstep(void)
  {
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ZigZag::Handle(int ZigZagHandle)
  {
   if(ZigZagHandle!=m_handle)
     {
      m_handle=ZigZagHandle;
      this.Init();
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ZigZag::Handle(void)
  {
   return(m_handle);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ZigZag::AddPoint(ZigZagPoint *point)
  {
// Kiểm tra xem point đã tồn tại chưa
   for(int i=0;i<m_points.Total();i++)
     {
      ZigZagPoint *zzpoint=m_points.At(i);
      datetime zztime,ptime;
      zztime= zzpoint.GetTime();
      ptime = point.GetTime();
      if(zzpoint.GetTime()==point.GetTime()) return(false);
     }
   return(m_points.Add(point));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ZigZag::CountPoint(void)
  {
   return(m_points.Total());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ZigZag::FindPoint(datetime time)
  {
   for(int i=0;i<m_points.Total();i++)
     {
      ZigZagPoint *point=m_points.At(i);
      if(point.GetTime()== time)
        {
         return(i);
        }
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ZigZag::GetLastPoint(void)
  {
   return(m_points.Total()-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime ZigZag::GetTime(int ind)
  {
   if(ind<0 || ind>m_points.Total()-1) return(-1);
   ZigZagPoint *point=m_points.At(ind);
   return(point.GetTime());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ZigZag::GetPrice(int ind)
  {
   if(ind<0 || ind>m_points.Total()-1) return(-1);
   ZigZagPoint *point=m_points.At(ind);
   return(point.GetPrice());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ZigZag::IsTop(int ind)
  {
   if(ind<0 || ind>m_points.Total()-1) return(-1);
   ZigZagPoint *point=m_points.At(ind);
   return(point.IsTop());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ZigZag::IsBottom(int ind)
  {
   if(ind<0 || ind>m_points.Total()-1) return(-1);
   ZigZagPoint *point=m_points.At(ind);
   return(point.IsBottom());
  }
//+------------------------------------------------------------------+
