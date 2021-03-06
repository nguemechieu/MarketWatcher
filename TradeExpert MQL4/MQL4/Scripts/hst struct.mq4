//+------------------------------------------------------------------+
//|                                                   HST Struct.mq4 |
//|                   Copyright 2006-2015, MetaQuotes Software Corp. |
//+------------------------------------------------------------------+
#property strict
#property show_inputs

input int InpPeriodMultiplier=3; // Period multiplier factor
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
struct HISTORY_BAR_401
{  datetime time;         // Period start time
   double   open;         // Open price
   double   high;         // The highest price of the period
   double   low;          // The lowest price of the period
   double   close;        // Close price
   long     tick_volume;  // Tick volume
   int      spread;       // Spread
   long     real_volume;  // Trade volume
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
{  datetime time0;
   ulong    last_fpos=0;
   long     last_volume=0;
   int      i,start_pos,periodseconds;
   int      cnt=0;
//---- History header
   int      file_version=401;
   string   c_copyright;
   string   c_symbol=Symbol();
   int      i_period=Period()*InpPeriodMultiplier;
   int      i_digits=Digits;
   int      i_unused[13];
   MqlRates rate;
//---
   int ExtHandle=FileOpenHistory(c_symbol+(string)i_period+".hst",FILE_BIN|FILE_WRITE|FILE_SHARE_WRITE|FILE_SHARE_READ|FILE_ANSI);
   if(ExtHandle<0) return;

   c_copyright="(C)opyright 2003, MetaQuotes Software Corp.";
   ArrayInitialize(i_unused,0);
//--- write history file header
   FileWriteInteger(ExtHandle,file_version,LONG_VALUE);
   FileWriteString(ExtHandle,c_copyright,64);
   FileWriteString(ExtHandle,c_symbol,12);
   FileWriteInteger(ExtHandle,i_period,LONG_VALUE);
   FileWriteInteger(ExtHandle,i_digits,LONG_VALUE);
   FileWriteInteger(ExtHandle,0,LONG_VALUE);
   FileWriteInteger(ExtHandle,0,LONG_VALUE);
   FileWriteArray(ExtHandle,i_unused,0,13);

//--- write history file
   periodseconds=i_period*60;
   start_pos=Bars-1;
   
   rate.open=Open[start_pos];
   rate.low=Low[start_pos];
   rate.high=High[start_pos];
   rate.tick_volume=(long)Volume[start_pos];
   rate.spread=0;
   rate.real_volume=0;
   //--- normalize open time
   rate.time=Time[start_pos]/periodseconds;
   rate.time*=periodseconds;

   for(i=start_pos-1; i>=0; i--)
   {  if(IsStopped()) break;
      time0=Time[i];

      //--- history may be updated
      if(i==0)
      {  //--- modify index if history was updated
         if(RefreshRates())
            i=iBarShift(NULL,0,time0);
      }

      //---
      if(time0>=rate.time+periodseconds || i==0)
      {  if(i==0 && time0<rate.time+periodseconds)
         {  rate.tick_volume+=(long)Volume[0];
            if(rate.low>Low[0])
               rate.low=Low[0];
            if(rate.high<High[0])
               rate.high=High[0];
            rate.close=Close[0];
         }
         last_fpos=FileTell(ExtHandle);
         last_volume=(long)Volume[i];

         FileWriteStruct(ExtHandle,rate);
         cnt++;

         if(time0>=rate.time+periodseconds)
         {  rate.time=time0/periodseconds;
            rate.time*=periodseconds;
            rate.open=Open[i];
            rate.low=Low[i];
            rate.high=High[i];
            rate.close=Close[i];
            rate.tick_volume=last_volume;
         }
      }
      else
      {  rate.tick_volume+=(long)Volume[i];
         if(rate.low>Low[i])
            rate.low=Low[i];
         if(rate.high<High[i])
            rate.high=High[i];
         rate.close=Close[i];
      }
   }

   FileFlush(ExtHandle);
   PrintFormat("%d record(s) written",cnt);
   FileClose(ExtHandle);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
