
#property indicator_color1 White
#property indicator_color2 Orange
#property indicator_color3 Red
#property indicator_color4 Green
#property indicator_color5 Blue
#property indicator_color6 White
#property indicator_color7 White
#property indicator_color8 White

#property indicator_separate_window
#property indicator_minimum 0
#property indicator_maximum 100
#property indicator_buffers 8
#property indicator_level1 80
#property indicator_level2 20
#property indicator_level3 50

extern int RSIperiod=9;
extern int RSIprice =0;
string RSI_Price_note_1="CLOSE= 0, OPEN=1, HIGH=2, LOW=3";
string RESI_Price_note2="MEDIAN=4, TYPICAL=5, WEIGHTED=6";

bool ShowRSI_M1 = false;
bool ShowRSI_M5 = true;
bool ShowRSI_M15 = true;
bool ShowRSI_M30 = true;
bool ShowRSI_M60 = true;
bool ShowRSI_M240= false;
bool ShowRSI_M1440=false;
bool ShowRSI_M10080=false;

color M1_color=White;
color M5_color=Orange;
color M15_color=Red;
color M30_color=Green;
color M60_color=Blue;
color M240_color=White;
color M1440_color=White;
color M10080_color=White;

double M1Buffer[];
double M5Buffer[];
double M15Buffer[];
double M30Buffer[];
double M60Buffer[];
double M240Buffer[];
double M1440Buffer[];
double M10080Buffer[];

int TF1=1;
int TF5=5;
int TF15=15;
int TF30=30;
int TF60=60;
int TF240=240;
int TF1440=1440;
int TF10080=10080;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
//============================================================================================

   SetIndexBuffer(0,M1Buffer);
   SetIndexLabel(0,"M1 RSI");
   SetIndexStyle(0,DRAW_LINE,0,1,M1_color);
//============================================================================================
   SetIndexBuffer(1,M5Buffer);
   SetIndexLabel(1,"M5 RSI");
   SetIndexStyle(1,DRAW_LINE,0,1,M5_color);
//============================================================================================
   SetIndexBuffer(2,M15Buffer);
   SetIndexLabel(2,"M15 RSI");
   SetIndexStyle(2,DRAW_LINE,0,1,M15_color);
//============================================================================================
   SetIndexBuffer(3,M30Buffer);
   SetIndexLabel(3,"M30 RSI");
   SetIndexStyle(3,DRAW_LINE,0,1,M30_color);
//============================================================================================
   SetIndexBuffer(4,M60Buffer);
   SetIndexLabel(4,"H1 RSI");
   SetIndexStyle(4,DRAW_LINE,0,1,M60_color);
//============================================================================================
   SetIndexBuffer(5,M240Buffer);
   SetIndexLabel(5,"H4 RSI");
   SetIndexStyle(5,DRAW_LINE,0,1,M240_color);
//============================================================================================
   SetIndexBuffer(6,M1440Buffer);
   SetIndexLabel(6,"D1 RSI");
   SetIndexStyle(6,DRAW_LINE,0,1,M1440_color);
//============================================================================================
   SetIndexBuffer(7,M10080Buffer);
   SetIndexLabel(7,"W1 RSI");
   SetIndexStyle(7,DRAW_LINE,0,1,M10080_color);
//============================================================================================

   IndicatorShortName("TS261 MTF_RSI("+RSIperiod+")");

   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   ObjectDelete("M1RSI");
   ObjectDelete("M5RSI");
   ObjectDelete("M15RSI");
   ObjectDelete("M30RSI");
   ObjectDelete("H1RSI");
   ObjectDelete("H4RSI");
   ObjectDelete("D1RSI");
   ObjectDelete("W1RSI");
   ObjectDelete("M1ValueRSI");
   ObjectDelete("M5ValueRSI");
   ObjectDelete("M15ValueRSI");
   ObjectDelete("M30ValueRSI");
   ObjectDelete("H1ValueRSI");
   ObjectDelete("H4ValueRSI");
   ObjectDelete("D1ValueRSI");
   ObjectDelete("W1ValueRSI");

//----
   return(0);
  }
//============================================================================================
int start()
  {
   if(ShowRSI_M1 && Period()<=1) {start1();CreateLabel("M1_RSI",10,30,2,M1_color,"M1",10);CreateLabel("M1Value_RSI",10,10,2,M1_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF1,RSIperiod,0,0),1),1),10);}
   if(ShowRSI_M5 && Period()<=5) {start2();CreateLabel("M5_RSI",50,30,2,M5_color,"M5",10);CreateLabel("M5Value_RSI",50,10,2,M5_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF5,RSIperiod,0,0),1),1),10);}
   if(ShowRSI_M15 && Period()<=15) {start3();CreateLabel("M15_RSI",90,30,2,M15_color,"M15",10);CreateLabel("M15Value_RSI",90,10,2,M15_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF15,RSIperiod,0,0),1),1),10);}
   if(ShowRSI_M30 && Period()<=30) {start4();CreateLabel("M30_RSI",130,30,2,M30_color,"M30",10);CreateLabel("M30Value_RSI",130,10,2,M30_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF30,RSIperiod,0,0),1),1),10);}
   if(ShowRSI_M60 && Period()<=60) {start5();CreateLabel("H1_RSI",170,30,2,M60_color,"H1",10);CreateLabel("H1Value_RSI",170,10,2,M60_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF60,RSIperiod,0,0),1),1),10);}
   if(ShowRSI_M240  &&  Period()<=240) {start6();CreateLabel("H4_RSI",210,30,2,M240_color,"H4",10);CreateLabel("H4Value_RSI",210,10,2,M240_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF240,RSIperiod,0,0),1),1),10);}
   if(ShowRSI_M1440 && Period()<=1440) {start7();CreateLabel("D1_RSI",250,30,2,M1440_color,"D1",10);CreateLabel("D1Value_RSI",250,10,2,M1440_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF1440,RSIperiod,0,0),1),1),10);}
   if(ShowRSI_M10080 && Period()<=10080) {start8();CreateLabel("W1_RSI",290,30,2,M10080_color,"W1",10);CreateLabel("W1Value_RSI",290,10,2,M10080_color,DoubleToStr(NormalizeDouble(iRSI(NULL,TF10080,RSIperiod,0,0),1),1),10);}

   return(0);
  }
//============================================================================================
//============================================================================================
int start1()
  {
   datetime TimeArray1[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray1,MODE_TIME,Symbol(),1);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray1)) {if(Time[i]<TimeArray1[y]) y++;}
      M1Buffer[i]=iRSI(NULL,1,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
int start2()
  {
   datetime TimeArray2[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray2,MODE_TIME,Symbol(),TF5);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray2)) {if(Time[i]<TimeArray2[y]) y++;}
      M5Buffer[i]=iRSI(NULL,TF5,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
int start3()
  {
   datetime TimeArray3[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray3,MODE_TIME,Symbol(),TF15);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray3)) {if(Time[i]<TimeArray3[y]) y++;}
      M15Buffer[i]=iRSI(NULL,TF15,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
int start4()
  {
   datetime TimeArray4[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray4,MODE_TIME,Symbol(),TF30);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray4)) {if(Time[i]<TimeArray4[y]) y++;}
      M30Buffer[i]=iRSI(NULL,TF30,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
int start5()
  {
   datetime TimeArray5[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray5,MODE_TIME,Symbol(),TF60);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray5)) {if(Time[i]<TimeArray5[y]) y++;}
      M60Buffer[i]=iRSI(NULL,TF60,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
int start6()
  {
   datetime TimeArray6[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray6,MODE_TIME,Symbol(),TF240);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray6)) {if(Time[i]<TimeArray6[y]) y++;}
      M240Buffer[i]=iRSI(NULL,TF240,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
int start7()
  {
   datetime TimeArray7[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray7,MODE_TIME,Symbol(),TF1440);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray7)) {if(Time[i]<TimeArray7[y]) y++;}
      M1440Buffer[i]=iRSI(NULL,TF1440,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
int start8()
  {
   datetime TimeArray8[];
   int    i,limit,y=0,counted_bars=IndicatorCounted();
   ArrayCopySeries(TimeArray8,MODE_TIME,Symbol(),TF10080);
   limit=Bars-counted_bars;
   for(i=0,y=0;i<limit;i++)
     {
      if (y<ArraySize(TimeArray8)) {if(Time[i]<TimeArray8[y]) y++;}
      M10080Buffer[i]=iRSI(NULL,TF10080,RSIperiod,RSIprice,y);
     }
   return(0);  
  }
//============================================================================================
//============================================================================================
void CreateLabel(string name,int x,int y,int corner,int z,string text,int size,
                 string font="Arial")
  {
   ObjectCreate(name,OBJ_LABEL,WindowFind("TS261 MTF_RSI("+RSIperiod+")"),0,0);
   ObjectSet(name,OBJPROP_CORNER,corner);
   ObjectSet(name,OBJPROP_COLOR,z);
   ObjectSet(name,OBJPROP_XDISTANCE,x);
   ObjectSet(name,OBJPROP_YDISTANCE,y);
   ObjectSetText(name,text,size,font,z);
  }
//============================================================================================
