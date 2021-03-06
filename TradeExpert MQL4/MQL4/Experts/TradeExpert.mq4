#property copyright "Copyright 2022,Noel Martial Nguemechieu"
#property strict
#property link "https://github.com/nguemechieu/TradeExpert"
#property tester_file "trade.csv"    // file with the data to be read by an Expert Advisor TradeExpert_file "trade.csv"    // file with the data to be read by an Expert Advisor
#property icon "\\Images\\TradeExpert.ico"

#property tester_library "Libraries"
#property stacksize 10000
#property  version "5.1" //EA VERSION 
#property description "This is a very interactive smart Bot. It uses multiples indicators base on your define strategy to get trade signals a"
#property description "nd open orders. It also integrate news filter to allow you to trade base on news events. In addition the ea generate s"
#property description "ignals with screenshot on telegram or others withoud using dll import.This  give ea ability to trade on your vps witho"
#property description "ut restrictions."
#property description "This Bot will can trade generate ,manage and generate trading signals on telegram ,twitter and discord channel"




#include <DiscordTelegram/TradeExpert_Functions.mqh>//get all mql needed files included libraries

#include <DiscordTelegram/TradeSignal.mqh>
//--- Store trade data
TradeData tradeData;
//----------object Ctrade  to trade
CTrade trad;
bool exitchange=false;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
     


int OnInit()
  {
  
  

//--- Fill in the array of used symbols
   used_symbols=InpUsedSymbols;
   CreateUsedSymbolsArray((ENUM_SYMBOLS_MODE)used_symbols_mode,used_symbols,array_used_symbols);

//--- Set the type of the used symbol list in the symbol collection
   engine.SetUsedSymbols(array_used_symbols);
//--- Displaying the selected mode of working with the symbol object collection
   Print(engine.ModeSymbolsListDescription(),TextByLanguage(". Количество используемых символов: ",". Number of symbols used: "),engine.GetSymbolsCollectionTotal());
   
//--- Create resource text files
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_01",TextByLanguage("Звук упавшей монетки 1","Falling coin 1"),sound_array_coin_01);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_02",TextByLanguage("Звук упавших монеток","Falling coins"),sound_array_coin_02);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_03",TextByLanguage("Звук монеток","Coins"),sound_array_coin_03);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_04",TextByLanguage("Звук упавшей монетки 2","Falling coin 2"),sound_array_coin_04);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_click_01",TextByLanguage("Звук щелчка по кнопке 1","Button click 1"),sound_array_click_01);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_click_02",TextByLanguage("Звук щелчка по кнопке 2","Button click 2"),sound_array_click_02);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_click_03",TextByLanguage("Звук щелчка по кнопке 3","Button click 3"),sound_array_click_03);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_cash_machine_01",TextByLanguage("Звук кассового аппарата","Cash machine"),sound_array_cash_machine_01);
   engine.CreateFile(FILE_TYPE_BMP,"img_array_spot_green",TextByLanguage("Изображение \"Зелёный светодиод\"","Image \"Green Spot lamp\""),img_array_spot_green);
   engine.CreateFile(FILE_TYPE_BMP,"img_array_spot_red",TextByLanguage("Изображение \"Красный светодиод\"","Image \"Red Spot lamp\""),img_array_spot_red);

//--- Pass all existing collections to the trading class
   engine.TradingOnInit();
//--- Set synchronous passing of orders for all used symbols
   engine.TradingSetAsyncMode();
//--- Set standard sounds for trading objects of all used symbols
   engine.SetSoundsStandart();
//--- Check playing a standard sound by macro substitution and a custom sound by description
   engine.PlaySoundByDescription(SND_OK);
   Sleep(600);
   engine.PlaySoundByDescription(TextByLanguage("Звук упавшей монетки 2","Falling coin 2"));
      
//--- Set controlled values for symbols
   //--- Get the list of all collection symbols
   CArrayObj *list=engine.GetListAllUsedSymbols();
   if(list!=NULL && list.Total()!=0)
     {
      //--- In a loop by the list, set the necessary values for tracked symbol properties
      //--- By default, the LONG_MAX value is set to all properties, which means "Do not track this property" 
      //--- It can be enabled or disabled (by setting the value less than LONG_MAX or vice versa - set the LONG_MAX value) at any time and anywhere in the program
      for(int i=0;i<list.Total();i++)
        {
         CSymbol* symbol=list.At(i);
         if(symbol==NULL)
            continue;
         //--- Set control of the symbol price increase by 100 points
         symbol.SetControlBidInc(100*symbol.Point());
         //--- Set control of the symbol price decrease by 100 points
         symbol.SetControlBidDec(100*symbol.Point());
         //--- Set control of the symbol spread increase by 40 points
         symbol.SetControlSpreadInc(40);
         //--- Set control of the symbol spread decrease by 40 points
         symbol.SetControlSpreadDec(40);
         //--- Set control of the current spread by the value of 40 points
         symbol.SetControlSpreadLevel(40);
        }
     }
//--- Set controlled values for the current account
   CAccount* account=engine.GetAccountCurrent();
   if(account!=NULL)
     {
      //--- Set control of the profit increase to 10
      account.SetControlledValueINC(ACCOUNT_PROP_PROFIT,10.0);
      //--- Set control of the funds increase to 15
      account.SetControlledValueINC(ACCOUNT_PROP_EQUITY,15.0);
      //--- Set profit control level to 20
      account.SetControlledValueLEVEL(ACCOUNT_PROP_PROFIT,20.0);
      account.SetChartID(ChartID());
      account.SetControlAssetsDec(10);
     }

      
      //--- CheckConnection
      if(!TerminalInfoInteger(TERMINAL_CONNECTED))
         MessageBox("Warning: No Internet connection found!\nPlease check your network connection.",
                    MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);

      //--- CheckTradingIsAllowed
      if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))//Terminal
        {
         MessageBox("Warning: Check if automated trading is allowed in the terminal settings!",
                    MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);
        }
      else
        {
         if(!MQLInfoInteger(MQL_TRADE_ALLOWED))//CheckBox
           {
            MessageBox("Warning: Automated trading is forbidden in the program settings for "+__FILE__,
                       MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);
           }
        }

      //---
      if(!AccountInfoInteger(ACCOUNT_TRADE_EXPERT))//Server
         MessageBox("Warning: Automated trading is forbidden for the account "+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))+" at the trade server side.",
                    MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);

      //---
      if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))//Investor
         MessageBox("Warning: Trading is forbidden for the account "+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))+"."+
                    "\n\nPerhaps an investor password has been used to connect to the trading account."+
                    "\n\nCheck the terminal journal for the following entry:"+
                    "\n\'"+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))+"\': trading has been disabled - investor mode.",
                    MB_CAPTION+" | "+"#"+IntegerToString(ERR_TRADE_DISABLED), MB_OK|MB_ICONWARNING);

      //---
      if(!SymbolInfoInteger(Symbol(), SYMBOL_TRADE_MODE))//Symbol
         MessageBox("Warning: Trading is disabled for the symbol "+_Symbol+" at the trade server side.",
                    MB_CAPTION+" | "+"#"+IntegerToString(ERR_TRADE_DISABLED), MB_OK|MB_ICONWARNING);

      //--- CheckDotsPerInch
      if(TerminalInfoInteger(TERMINAL_SCREEN_DPI) != 96)
        {
         Comment("Warning: 96 DPI highly recommended !\nThe resolution of information display on the screen is measured as number of Dots in a line per Inch (DPI)."

+"Knowing the parameter value, you can set the size of graphical objects \nso that they look the same on monitors with different resolution characteristics");
         Sleep(3000);
         Comment("");
        }

    

 init_error=smartBot.Token(InpTocken);

//--- set language
   smartBot.Language(InpLanguage);

//--- set token

//--- set filter
   smartBot.UserNameFilter(UserName);

//--- set templates
   smartBot.Templates(Template);
   smartBot.ReplyKeyboardMarkup(KEYB_MAIN,false,false);
 
smartBot.ForceReply();
//--- done
  smartBot.ChartColorSet();//set charcolor
    
if(UseBot){


//--- set timer
   timer_ms=3000;
   switch(InpUpdateMode)
     {
      case UPDATE_FAST:
         timer_ms=1000;
         break;
      case UPDATE_NORMAL:
         timer_ms=2000;
         break;
      case UPDATE_SLOW:
         timer_ms=3000;
         break;
      default:
         timer_ms=3000;
         break;
     };
    };
   

   
                          
  int x0=0,x1=0,x2=0,xf=0,xp=0;
       if(!CheckDemoPeriod(12,7,2022))//ea expiration date control
      return INIT_FAILED;
   else  if(!LicenseControl())
     {
      MessageBox("Invalid LICENSE KEY!\nPlease contact support at nguemechieu@live.com for any assistance","License Control",MB_CANCELTRYCONTINUE);

      messages="Invalid LICENSE KEY!\nPlease contact support at nguemechieu@live.com for any assistance";

      smartBot.SendMessage(InpChatID2,messages,smartBot.ReplyKeyboardMarkup(KEYB_MAIN,FALSE,FALSE),false,false);
  ExpertRemove();

      return INIT_FAILED;
     }else
    
 
    if(EA_TIME_LOCK_ACTION)
     {
      mydate=TimeCurrent();
      message="\nWelcome to TradeExpert\nMy name is "+smartBot.Name()+"\nToday date is "+(string)mydate + "\nI'm your trade assistant\n.My final goal is to help you trade well..!\n Below are some market data you should pay attention to when trading";

      smartBot.SendMessage(InpChannel,message);
     }


     
//--- CheckData
   if(TerminalInfoInteger(TERMINAL_CONNECTED) && (LastReason == 0 || LastReason == REASON_PARAMETERS))
     {
      //---
      ResetLastError();
      //---
         // Load all symbols in to arrays
  for(int index=0;index<NumOfSymbols;index++){
    ArrayResize(Symbols,NumOfSymbols,0);

    Symbols[index]=TradeScheduleSymbol(index,InpSelectPairs_By_Basket_Schedule);
  }
   
  }
  int index=MathRand()%NumOfSymbols;
  if(index<NumOfSymbols){

   
         //---
         double test = iHigh(Symbols[index], PERIOD_CURRENT, 0);
      
               //---
               double _High = iHigh(Symbols[index], PERIOD_CURRENT, 0);
               double _Low = iLow(Symbols[index], PERIOD_CURRENT, 0);
               double _Close = iClose(Symbols[index], PERIOD_CURRENT, 0);
               //---
               double _Bid = SymbolInfoDouble(Symbols[index], SYMBOL_BID);
               double _Ask = SymbolInfoDouble(Symbols[index], SYMBOL_ASK);
               //---
   }


   sendOnce=0;
  
     
//--- set panel corner
   datetime startTime=TimeCurrent();
   
//--- Disclaimer
   if(!GlobalVariableCheck(OBJPREFIX+"Disclaimer" ) || GlobalVariableGet(OBJPREFIX+"Disclaimer") != 1)
     {
      //---
   message = "Welcome to TradeExpert\nRisk Disclaimer:\n Please proceed with caution.\n";
      //---
      if(MessageBox(message, MB_CAPTION, MB_OKCANCEL|MB_ICONWARNING) == IDOK)
         GlobalVariableSet(OBJPREFIX+"Disclaimer", 1);

     }


//---
   if(LastReason == 0)
     {
      //--- OfflineChart
      if(ChartGetInteger(0, CHART_IS_OFFLINE))
        {
         MessageBox("The currenct chart is offline, make sure to uncheck \"Offline chart\" under Properties(F8)->Common.",
                    MB_CAPTION, MB_OK|MB_ICONERROR);

        }
    }
 
NumOfIndicators=StringSplit(Indicators_list,';',indicatorsArrayList);
      
      
  NumOfSymbols=StringSplit(InpUsedSymbols,';',array_used_symbols);
 ArrayResize(array_used_symbols,NumOfSymbols,0);
 
   int size = NumOfSymbols+100;
  ArrayResize( Symbols,size,0);
     
      ArrayResize(MasterSignal,size,size);
      ArrayResize(Signal1,size,size);
      ArrayResize(Signal2,size,size);
      ArrayResize(Signal3,size,size);
      ArrayResize(ExitSignal0,size,size);
      ArrayResize(ExitSignal1,size,size);
      ArrayResize(ExitSignal2,size,size);
      ArrayResize(ExitSignal3,size,size);
      
      ArrayResize(Hist,size,size);
      ArrayResize(lastSupport,size,size);
      ArrayResize(lastResistance,size,size);
      
     ArrayResize(indicatorsArrayList,NumOfSymbols,0);
      
   ArrayResize(indicatorsArrayList,100,0);
             
            
     ArrayResize(indicatorsArrayList,size,0);
     
     ArrayResize(indicatorTimeFrame,size,0);
     
if(Indicators_list==""){MessageBox("Indicator list can't be empty","Error Indcator",1); ExpertRemove();return false;};
 if(StringFind(Indicators_list,",",0)>0){
 
 MessageBox("Make sure you enter Indicator follow by ';' example :RSI;CCI;...","Error IndcatoList Invalid",MB_OK);
 
 
 }   else  {
   NumOfIndicators=StringSplit(Indicators_list,';',indicatorsArrayList);
}
  
   ThisDayOfYear=DayOfYear();
//--- Calling the function displays the list of enumeration constants in the journal 
//--- (the list is set in the strings 22 and 25 of the DELib.mqh file) for checking the constants validity


 
//--- Check if working with the full list is selected
   used_symbols_mode=InpModeUsedSymbols;
   if((ENUM_SYMBOLS_MODE)used_symbols_mode==SYMBOLS_MODE_ALL)
     {
      int total=SymbolsTotal(false);
      string ru_n="\nКоличество символов на сервере "+(string)total+".\nМаксимальное количество: "+(string)SYMBOLS_COMMON_TOTAL+" символов.";
      string en_n="\nNumber of symbols on server "+(string)total+".\nMaximum number: "+(string)SYMBOLS_COMMON_TOTAL+" symbols.";
      string caption=TextByLanguage("Внимание!","Attention!");
      string ru="Выбран режим работы с полным списком.\nВ этом режиме первичная подготовка списка коллекции символов может занять длительное время."+ru_n+"\nПродолжить?\n\"Нет\" - работа с текущим символом \""+Symbol()+"\"";
      string en="Full list mode selected.\nIn this mode, the initial preparation of the collection symbols list may take a long time."+en_n+"\nContinue?\n\"No\" - working with the current symbol \""+Symbol()+"\"";
     message=TextByLanguage(ru,en);
      int flags=(MB_YESNO | MB_ICONWARNING | MB_DEFBUTTON2);
      int mb_res=MessageBox(message,caption,flags);
      switch(mb_res)
        {
         case IDNO : 
           used_symbols_mode=SYMBOLS_MODE_CURRENT; 
           break;
         default:
           break;
        }
     }
   
//initialize LotDigits
   double LotStep = MarketInfo(Symbols[index], MODE_LOTSTEP);
   if(NormalizeDouble(LotStep, 3) == round(LotStep))
     {
      LotDigits = 0;
     }
   else
      if(NormalizeDouble(10*LotStep, 3) == round(10*LotStep))
        {
         LotDigits = 1;
        }
      else
         if(NormalizeDouble(100*LotStep, 3) == round(100*LotStep))
           {
            LotDigits = 2;
           }
         else
           {
            LotDigits = 3;
           }

 
   if(NormalizeDouble(LotStep, 3) == round(LotStep)){
      LotDigits = 0;}
   else if(NormalizeDouble(10*LotStep, 3) == round(10*LotStep))
      LotDigits = 1;
   else if(NormalizeDouble(100*LotStep, 3) == round(100*LotStep)){
      LotDigits = 2;}
   else {LotDigits = 3;
     }
     
  int i=MathRand()%NumOfSymbols;
             
   
OnTimer();


   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- Remove EA graphical objects by an object name prefix
   ObjectsDeleteAll(0,prefix);
    ObjectsDeleteAll(0,OBJ_VLINE);

   if(!IsTesting())
 
     {
      ObjectsDeleteAll(ChartID(),OBJPFX);

     }
   if(reason==REASON_CLOSE ||
      reason==REASON_PROGRAM ||
      reason==REASON_PARAMETERS ||
      reason==REASON_REMOVE ||
      reason==REASON_RECOMPILE ||
      reason==REASON_ACCOUNT ||
      reason==REASON_INITFAILED)
     {
      time_check=0;
      comments.Destroy();
     }


   ChartRedraw();
//--- destroy timer
   EventKillTimer();


//--- Remove EA graphical objects by an object name prefix

   Comment("");
//--- Deinitialize library
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
CTradeSignal tradeSignal[8];
void OnTick()
  {
  
  
   //--- Initializing the last events
   static ENUM_TRADE_EVENT last_trade_event=WRONG_VALUE;
  int i=0; int digits=3;string symbol;
    for(i=0;i<NumOfSymbols;i++){
  symbol=Symbols[i]=TradeScheduleSymbol(i,InpSelectPairs_By_Basket_Schedule);

     }
  printf ("Number of symbol"+(string)NumOfSymbols);
 int jkl=i=MathRand()%NumOfSymbols;
 smartBot.ProcessMessages();
 
 if(jkl<NumOfSymbols){
  
   digits=(int)MarketInfo(Symbols[jkl],MODE_DIGITS);
 int point=(int)MarketInfo(Symbols[jkl],MODE_POINT);
  
     double R3=0,S3=0,S2=0;
    //------ Pivot Points ------
      Rx = (yesterday_high - yesterday_low);
      Px = (yesterday_high + yesterday_low + yesterday_close)/3; //Pivot
     double R1x = Px + (Rx * 0.38);
     double R2x = Px + (Rx * 0.62);
     double R3x = Px + (Rx * 0.99);
    double  S1x = Px - (Rx * 0.38);
    double  S2x = Px - (Rx * 0.62);
     double S3x = Px - (Rx * 0.99);
     double bid =tick.bid;
    if(digits == 5 || digits == 3)
     {
      myPoint *= 10;
      MaxSlippage *= 10;
     
     }
 int mainSignal = 0;
    
        tradeData.MagicNumber=MagicNumber;
        tradeData.date=TimeCurrent();
        tradeData.slippage=(int)InpSlippage;
        tradeData.volume=TradeSize(InpMoneyManagement);
        tradeData.stopLoss=InpStopLoss;
        tradeData.takeProfit=InpTakeProfit;

//--- If working in the tester
   if(MQLInfoInteger(MQL_TESTER))
     {
      engine.OnTimer();
    
     }
   ArrayResize(tradesignals,NumOfSymbols,0);
     
          //--- stop working in tester
      double Free=AccountFreeMargin();
      double One_Lot=0;
      MarketInfo( Symbols[jkl],MODE_MARGINREQUIRED);

      if(One_Lot==NULL){
      
       printf("INSUFFISANT  MARGIN FOR ORDER "+  symbol ); 
       
        }
      else if( (floor(AccountBalance()/Free/(One_Lot*100)/100))<floor(Free/(One_Lot*100))/100)
           {
            Print("NOT ENOUGH MARGING FOR  THIS ORDER "+  symbol);    return;      
         
           }else
         if(TradeSize(InpMoneyManagement)==0){
             MessageBox("Invalid lot size can't be empty\nCheck MoneyManagement parameters!","MoneyManagement",1);
               return ;
       }
        
        
      double prs=0,prb=0;
    



  //News control
      if(CloseBeforNews)
        {
         NewsFilter = True;
        }
      else
        {
         NewsFilter = AvoidNews;
        }

      if(CurrencyOnly)
        {
         NewsSymb ="";
         if(StringLen(NewsSymb)>1)
            str1=NewsSymb;
        }
      else
        {
         str1 =symbol;
        }


      Vtunggal = NewsTunggal;
      Vhigh=NewsHard;
      Vmedium=NewsMedium;
      Vlow=NewsLight;

      MinBefore=BeforeNewsStop;
     MinAfter=AfterNewsStop;
string sf="";
  
      int v2 = (StringLen(symbol)-6);
      if(v2>0)
        {
        sf = StringSubstr(symbol,6,v2);
        }
      postfix=sf;
      TMN=0;
      e_d = expire_date;
      if(CloseBeforNews)
        {
         NewsFilter = True;
        }
      else
        {
         NewsFilter = AvoidNews;
        }

      if(CurrencyOnly)
        {
         NewsSymb ="";
         if(StringLen(NewsSymb)>1)
            str1=NewsSymb;
        }
      else
        {
         str1=Symbols[jkl];
        }
      Vtunggal = NewsTunggal;
      Vhigh=NewsHard;
      Vmedium=NewsMedium;
      Vlow=NewsLight;

      MinBefore=BeforeNewsStop;
      MinAfter=AfterNewsStop;


      if(v2>0)
        {
         sf = StringSubstr(symbol,6,v2);
        }
         trade=newsTrade();
        
      postfix=sf;
      e_d = expire_date;

      y_offset=offset;
      trade=newsTrade();
 //--- Fast check of the account object

//--- Set the number of symbols in SymbolArraySize

               double _High = iHigh(symbol, PERIOD_CURRENT, 0);
               double _Low = iLow(symbol, PERIOD_CURRENT, 0);
               double _Close = iClose(symbol, PERIOD_CURRENT, 0);
               //---
               bid = SymbolInfoDouble(symbol, SYMBOL_BID);
               double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
               //---
      

      if(bid > R3x)
        {
         R3x = 0;
         S3x = R2x;
        }
      if(bid > R2x && bid < R3x)
        {
         R3x = 0;
         S3x = R1x;
        }
      if(bid > R1x && bid < R2x)
        {
         R3x = R3x;
         S3x = Px;
        }
      if(bid > Px && bid < R1x)
        {
         R3x = R2x;
         S3x = S1x;
        }
      if(bid > S1x && bid < Px)
        {
         R3x = R1x;
         S3x = S2x;
        }
      if(bid > S2x && bid < S1x)
        {
         R3x = Px;
         S3x = S3x;
        }
      if(bid > S3x && bid < S2x)
        {
         R3x = S1x;
         S3x = 0;
        }
      if(bid < S3x)
        {
         R3x = S2x;
         S3x = 0;
        }
        
   


   if( AccountBalance() <minbalance){
  Alert("Your account is below the minimum requierement ,please reload it and try it again\nCurrent minimum is set to "+(string)minbalance); 
   }

      if(CheckStochts261m30(symbol))
        {
         overboversellSymbol[0]=symbol;
        };//overbought and oversold signal
         timelockaction(symbol);
   
   if(!IsTesting())
     {
      if(!ChartGetInteger(0,CHART_EVENT_MOUSE_MOVE))
         ChartEventMouseMoveSet(true);
     }
       


      // Calculer les floating profits pour le magic
      for(i=0; i<OrdersTotal(); i++)
        {
         int xx=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderType()==OP_BUY && OrderMagicNumber()==MagicNumber)
           {
            PB+=OrderProfit()+OrderCommission()+OrderSwap();
           }
         if(OrderType()==OP_SELL && OrderMagicNumber()==MagicNumber)
           {
            PS+=OrderProfit()+OrderCommission()+OrderSwap();
           }
        }
   double DailyProfit=P1+PB+PS;

      if(ProfitValue>0 && ((P1+PB+PS)/(AccountEquity()-(P1+PB+PS)))*100 >=ProfitValue && TimeCurrent()<
   (datetime) ( "D'"+(string)Year()+".01."+(string)(Day()+1) +"00:00'"))
        {
         Alert("Daily Target reached. Closed running trades");
         messages="Daily Target reached. Closing running trades.Bot will resume trade tomorow ;";

         smartBot.SendMessageToChannel(InpChannel,messages);
         smartBot.SendMessage(InpChatID2,messages);
         CloseAll();
         TargetReachedForDay=ThisDayOfYear;
         MessageBox(messages,"Money Management",MB_OK);
         return ;
    
        }
      else
        {
         for(i=0; i<OrdersTotal(); i++)
           {
            int xx=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(!xx)
               continue;
            if(OrderType()==OP_BUY && OrderMagicNumber()==MagicNumber)
              {
               TO++;
               TB++;
               PB+=OrderProfit()+OrderCommission()+OrderSwap();
               LTB+=OrderLots();

              
              ClosetradePairs(OrderSymbol());
              }
            if(OrderType()==OP_SELL && OrderMagicNumber()==MagicNumber)
              {
               TO++;
               TS++;
               PS+=OrderProfit()+OrderCommission()+OrderSwap();
               LTS+=OrderLots();
              
              ClosetradePairs(OrderSymbol());
              }
           }
         }

   
   ThisDayOfYear=DayOfYear(); 
   
ObjectDelete(ChartID(),"");

digits=(int)MarketInfo(Symbols[jkl],MODE_DIGITS);
 

 if(AccountBalance()>0)
{
         Persentase1=(P1/AccountBalance())*100;
}
  
  
  
  
 if(inpTradeMode==Signal_Only){ //Signal only mode here
     
    signalMessage(Symbols[jkl],jkl);//generate trade signal only
    //drawing news lines events

 }  else  if(inpTradeMode==Manual){//Manual trading  here 
 //Create Buttons pannels;
 

CreatePannel();
CreateClosePanel();
  tradeResponse(symbol);
 }
 
 else  if(inpTradeMode ==AutoTrade){ 
 
    
  
  
     
     
//--- If the last trading event changed
   if(engine.LastTradeEvent()!=last_trade_event)
     {
      last_trade_event=engine.LastTradeEvent();
      Comment("\nLast trade event: ",engine.GetLastTradeEventDescription());
      engine.ResetLastTradeEvent();
      
    }
     
    if(!time1x){MessageBox("TRADING IS STOP BASE ON YOUR SCHEDULE.\nPLEASE WAIT FOR NEXT TRADE OPENING TIME!\nBOT Will RESUME  AT "+ (string)TOD_From_Hour +":"+ (string)TOD_From_Min,"Time Management",MB_CANCELTRYCONTINUE);comments.Show();
  return;
  
   }//end if time1
 int tickets=-1;
 
 //Auto trading mode here
 
      y_offset = 0;//--- GUI Debugging utils used in GetOpeningSignals,GetClosingSignals

       //--- If there is an account event
   if(engine.IsAccountsEvent())
     {
      //--- If this is a tester
      if(MQLInfoInteger(MQL_TESTER))
        {
         //--- Get the list of all account events occurred simultaneously
         CArrayObj* list=engine.GetListAccountEvents();
         if(list!=NULL)
           {
            //--- Get the next event in a loop
            int total=list.Total();
            for( i=0;i<total;i++)
              {
               //--- take an event from the list
               CEventBaseObj *event=list.At(i);
               if(event==NULL)
                  continue;
               //--- Send an event to the event handler
               long lparam=event.LParam();
               double dparam=event.DParam();
               string sparam=event.SParam();
               OnDoEasyEvent(CHARTEVENT_CUSTOM+event.ID(),lparam,dparam,sparam);
              }
           }
        }
     
     }
 
 // Delete Pending Orders After  Bars
      if(DeletePendingOrder&&PendingOrderExpirationBars>0){DeleteByDuration(PendingOrderExpirationBars);}
        
        
        
        
        
    MasterSignal[0]=    tradeSignal[0].TradeSignal(indicatorsArrayList[inpInd0],inpTF0,"",inpShift0,inpShift0Ex,Symbols[jkl]);
    Signal1[0]=    tradeSignal[1].TradeSignal(indicatorsArrayList[inpInd1],inpTF1,"",inpShift1,inpShift1Ex,Symbols[jkl]);
    
    Signal2[0]=    tradeSignal[2].TradeSignal(indicatorsArrayList[inpInd2],inpTF2,"",inpShift2,inpShift2Ex,Symbols[jkl]);
    
    Signal3[0]=    tradeSignal[3].TradeSignal(indicatorsArrayList[inpInd3],inpTF3,"",inpShift3,inpShift3Ex,Symbols[jkl]);
    
 int tradeNow=0;
    
    if( MasterSignal[0]==1||Signal1[0]==1||Signal2[0]==1||Signal3[0]==1){
    
  tradesignal[jkl]=  tradeNow=1;
    
   }
    else     if( MasterSignal[0]==-1||Signal1[0]==-1||Signal2[0]==-1||Signal3[0]==-1){
    
   tradesignal[jkl]= tradeNow=-1;
    
   }
    
    
    


  if(time1x&&trade&&(((NewBar()&&iTime(Symbols[jkl],PERIOD_CURRENT,1) > sendOnce)|| !NewBar()) && TradesCount(OP_SELL)<MaxOpenTrades && ttlsell<MaxOpenTrades &&
    (tradeNow==-1|| //Open Sell Order
   (iMomentum(Symbols[jkl], PERIOD_CURRENT, 14, PRICE_OPEN, 1) < iMomentum(Symbols[jkl], PERIOD_CURRENT, 200, PRICE_CLOSE, 1) //Momentum > Momentum
   && iATR(Symbols[jkl], PERIOD_CURRENT, 14, 1) > iATR(NULL, PERIOD_CURRENT, 200, 2) //Average True Range > Average True Range
   && iOBV(Symbols[jkl], PERIOD_CURRENT, PRICE_MEDIAN, 1) > iOBV(Symbols[jkl], PERIOD_CURRENT, PRICE_HIGH, 1) //On Balance Volume > On Balance Volume
   )
  
    
    )  && TradesCount(OP_SELL)<MaxShortTrades && ((closetype == opposite ) || (closetype != opposite)) && (inpTradeStyle ==SHORT || inpTradeStyle ==BOTH)))
           {
             RefreshRates();//REFRESS DATA
               
             double tpx2=NormalizeDouble(MaxTP*SetPoint,(int)digits);
                          sendOnce=iTime(symbol,PERIOD_CURRENT,1); RefreshRates();
            if(OrderStopLoss()>0)
              {

              if(UseFibo_TP==No) sls=NormalizeDouble(MarketInfo(Symbols[jkl],MODE_BID)+MaxSL*SetPoint,(int)digits);
              if(UseFibo_TP==No) tpx=NormalizeDouble(MarketInfo(Symbols[jkl],MODE_BID)-MaxTP*SetPoint,(int)digits)-(tpx2*TS);

              }
           
             
               if (PendingOrderDeletes) tradeData.expiration = TimeCurrent()+(PendingOrderExpirationBars*Period()*60);
               if (PendingOrderDeletes && Period() == 1) tradeData.expiration = TimeCurrent()+(MathMax(PendingOrderExpirationBars,12)*Period()*60);
               xlimit =NormalizeDouble(MarketInfo(Symbols[jkl],MODE_BID)+orderdistance*myPoint,(int)digits);
               xstop =NormalizeDouble(MarketInfo(Symbols[jkl],MODE_BID)-orderdistance*myPoint,(int)digits);
               slimit =NormalizeDouble(xlimit+MaxSL*myPoint,(int)digits);
               slstop =NormalizeDouble(xstop+MaxSL*myPoint,(int)digits);
               tplimit =NormalizeDouble(xlimit-MaxTP*myPoint,(int)digits)-(tpx2*TS);
               tpstop =NormalizeDouble(xstop-MaxTP*myPoint,(int)digits)-(tpx2*TS);
              if(UseFibo_TP==Yes){
               sls=NormalizeDouble(R3,(int)digits);
                tpx=NormalizeDouble(S3,(int)digits);
                }
               if(UseFibo_TP==Yes &&R3 == 0 ) slstop=NormalizeDouble(MarketInfo(Symbols[i],MODE_BID)+MaxSL*SetPoint,(int)digits);
               if(UseFibo_TP==Yes &&S3 == 0)  tpx=NormalizeDouble(MarketInfo(Symbols[i],MODE_BID)-MaxTP*SetPoint,(int)digits)-(tpx2*TS);
            if(TS>0){SubLots=TradeSize(InpMoneyManagement);}
            
            tradeData.Symbol=Symbols[jkl];
           
           
             if(IsTradeAllowed()){
           
             
                 switch(Order_Types)
                {
           
                  case MARKET_ORDERS:
                      signalMessage(symbol,jkl);
                      
                    tradeData.price=tick.bid;
                    tradeData.comment="MARKET SELL ORDER OPEN";
                    tradeData.clrName=clrRed;
                    tradeData.type=OP_SELL;
                    trad.OpenTrade(tradeData);
                    
                             break;
                  case STOP_ORDERS:
                      signalMessage(symbol,jkl);
                      tradeData.price=xstop;
                    tradeData.comment="MARKET SELLSTOP ORDER OPEN";
                    tradeData.clrName=clrBlue;
                    tradeData.type=OP_SELLSTOP;
                    trad.OpenTrade(tradeData);
                      break;
                  case LIMIT_ORDERS:
                      signalMessage(symbol,jkl);
                          tradeData.price=xlimit;
                    tradeData.comment="MARKET SELLLIMIT ORDER OPEN";
                    tradeData.clrName=clrYellow;
                    tradeData.type=OP_SELLLIMIT;
                    trad.OpenTrade(tradeData);
                       break;
                  default:break;
                } myOrderModify(tickets,sls,tpx);
                
              if(tickets==-1)return;  
      }else  myOrderModify(tickets,sls,tpx);
      }   
      
         
  
  
   if(time1x&&trade&&(((NewBar()&&iTime(Symbols[jkl],PERIOD_CURRENT,0) > sendOnce)|| !NewBar())&& TradesCount(OP_BUY)<MaxOpenTrades && TradesCount(OP_BUY)<MaxLongTrades &&( 
     tradeNow==1||(iMomentum(Symbols[i], PERIOD_CURRENT, 14, PRICE_OPEN, 1) < iMomentum(Symbols[i], PERIOD_CURRENT, 200, PRICE_CLOSE, 1) //Momentum < Momentum
   && iATR(Symbols[i], PERIOD_CURRENT, 14, 1) < iATR(Symbols[i], PERIOD_CURRENT, 200, 2) //Average True Range < Average True Range
   && iOBV(Symbols[i], PERIOD_CURRENT, PRICE_MEDIAN, 1) < iOBV(Symbols[i], PERIOD_CURRENT, PRICE_HIGH, 1) //On Balance Volume < On Balance Volume
   )
         ) && TradesCount(OP_BUY) <MaxOpenTrades && ((closetype == opposite ) || (closetype != opposite)) && (inpTradeStyle == LONG || inpTradeStyle == BOTH)))
           { sendOnce = iTime(Symbols[jkl],PERIOD_CURRENT,0);
      RefreshRates();
        
        
            double tpx2=NormalizeDouble(takeprofit*SetPoint,(int)digits);
            if(OrderStopLoss()>0)
              {
              if(UseFibo_TP==No) sls=NormalizeDouble(MarketInfo(symbol,MODE_ASK)-MaxSL*SetPoint,(int)digits);
              if(UseFibo_TP==No) tpx=NormalizeDouble(MarketInfo(symbol,MODE_ASK)+MaxTP*SetPoint,(int)digits)+(tpx2*TB);
               
              }
             
               if (PendingOrderExpirationBars ) tradeData.expiration = TimeCurrent()+(PendingOrderExpirationBars*Period()*60);
               if (PendingOrderDeletes && Period() == 1) tradeData.expiration= TimeCurrent()+(MathMax(PendingOrderExpirationBars,12)*Period()*60);
               xlimit =NormalizeDouble(MarketInfo(symbol,MODE_BID)-orderdistance*SetPoint,(int)digits);
               xstop =NormalizeDouble(MarketInfo(symbol,MODE_BID)+orderdistance*SetPoint,(int)digits);
               slimit =NormalizeDouble(xlimit-MaxSL*SetPoint,(int)digits);
               slstop =NormalizeDouble(xstop-MaxSL*SetPoint,(int)digits);
               tplimit =NormalizeDouble(xlimit+MaxTP*SetPoint,(int)digits)+(tpx2*TB);
               tpstop =NormalizeDouble(xstop+MaxTP*SetPoint,(int)digits)+(tpx2*TB);
               if(UseFibo_TP==Yes ) sls=NormalizeDouble(S2,(int)digits);
               if(UseFibo_TP==Yes ) tpx=NormalizeDouble(R3,(int)digits);
               if(UseFibo_TP==Yes && S3 == 0 ) sls=NormalizeDouble(MarketInfo(symbol,MODE_ASK)-MaxSL*SetPoint,(int)digits);
               if(UseFibo_TP==Yes && R3== 0)  tpx=NormalizeDouble(MarketInfo(symbol,MODE_ASK)+MaxTP*SetPoint,(int)digits)+(tpx2*TB);
            if(TB>0){
            lot=SubLots=TradeSize(InpMoneyManagement);}
           
        
            
           if(IsTradeAllowed()){
     
               switch(Order_Types)
                {
                 case MARKET_ORDERS:
                      signalMessage(symbol,jkl);
                      tradeData.price=tick.ask;
                    tradeData.comment="MARKET BUY ORDER OPEN";
                    tradeData.clrName=clrGreen;
                    tradeData.type=OP_BUY;
                    trad.OpenTrade(tradeData);
                  break;
                  case STOP_ORDERS:
                      signalMessage(symbol,jkl);
                  tradeData.price=xstop;
                    tradeData.comment="MARKET BUYSTOP ORDER OPEN";
                    tradeData.clrName=clrBrown;
                    tradeData.type=OP_BUYSTOP;
                    trad.OpenTrade(tradeData);
                      break;
                  case LIMIT_ORDERS:
                      signalMessage(symbol,jkl);
                         tradeData.price=xlimit;
                    tradeData.comment="MARKET BUYLIMIT ORDER OPEN";
                    tradeData.clrName=clrPurple;
                    tradeData.type=OP_BUYLIMIT;
                    trad.OpenTrade(tradeData);
                  
                      default: break;
              
                }
          myOrderModify(tickets,sls,tpx2);
          myOrderModify(tickets,sls,tpx2);
        
              if(tickets==-1)return;  
             }
             else myOrderModify(tickets,sls,0);myOrderModify(tickets,sls,tpx);
             }
   tradeResponse(symbol);   
   
       
        
   //DISPLAY INFOS
         //---Displayy menu
      
   
  HUD();
  HUD2();
  GUI();
  snrfibo(Show_Support_Resistance);//draw supprt and resistance

 snr(jkl);
createFibo();//draw fibo
   GetSetCoordinates(); 
  CreateSymbolPanel(ShowTradedSymbols);
takeprofit=InpTakeProfit;  
 CopyRightlogo();  
   if(UsePartialClose) {
      CheckPartialClose();
   }
   if(UseTrailingStop)
     {
      checkTrail();

     }
   if(UseBreakEven)
     {   _funcBE();
     }
     
  CloseByDuration(MaxTradeDurationBars * PeriodSeconds());
  DeleteByDuration(PendingOrderExpirationBars * PeriodSeconds());
  DeleteByDistance(DeleteOrderAtDistance * myPoint);
  CloseTradesAtPL(CloseAtPL);
  TrailingStopBE(OP_BUY, Trail_Above * myPoint, 0); //Trailing Stop = go break even
  TrailingStopBE(OP_SELL, Trail_Above * myPoint, 0); //Trailing Stop = go break even
    tradeResponse(Symbols[jkl]);//reply trade messages
   
   
   
   
   
   
   
   
   
   
  printf("TRADE STATUS "+(string)trade);

  
  
printf("Signal "+(string)tradesignals[jkl]);
  SetPoint=pointx;
  
      if(LongTradingts261M30)
     {   smartBot.SendChatAction(InpChatID2,ACTION_TYPING);
  

      message="\n_______Overbought______ \nsymbol: "+overboversellSymbol[0] +"Period:"+EnumToString(PERIOD_M30);
    
     if(EventSetTimer(10000))   smartBot.SendMessageToChannel(InpChannel,message);
     }
   else
      if(!LongTradingts261M30)
        {   smartBot.SendChatAction(InpChatID2,ACTION_TYPING);
  

         message="\n_______OverSold______ \nsymbol:"+overboversellSymbol[0]  +"Period:"+EnumToString(PERIOD_M30);

         if(EventSetTimer(10000))  smartBot.SendMessageToChannel(InpChannel,message);
        } 
              
       
    
  TradeReport(symbol,sendcontroltrade);
  
//--- If there is a symbol collection event
   if(engine.IsSymbolsEvent())
     {
      //--- If this is a tester
      if(MQLInfoInteger(MQL_TESTER))
        {
         //--- Get the list of all symbol events occurred simultaneously
         CArrayObj* list=engine.GetListSymbolsEvents();
         if(list!=NULL)
           {
            //--- Get the next event in a loop
            int total=list.Total();
            for(i=0;i<total;i++)
              {
               //--- take an event from the list
               CEventBaseObj *event=list.At(i);
               if(event==NULL)
                  continue;
               //--- Send an event to the event handler
               long lparam=event.LParam();
               double dparam=event.DParam();
               string sparam=event.SParam();
               OnDoEasyEvent(CHARTEVENT_CUSTOM+event.ID(),lparam,dparam,sparam);
              }
           }
        }
     }//event
     

  
    }//autotrade
 }//jkl

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//--- Launch the library timer (only not in the tester)
 
      CustomInfo info;
smartBot.ProcessMessages();
  
  //--- Launch the library timer (only not in the tester)
   if(!MQLInfoInteger(MQL_TESTER))
      //--- show init error
      if(init_error!=0)
        {
         //--- show error on display
         comments.Clear();
         comments.SetText(0,StringFormat("%s v.%s",EXPERT_NAME,5.1),CAPTION_COLOR);
         comments.SetText(1,info.text1, LOSS_COLOR);
         if(info.text2!="")
            comments.SetText(2,info.text2,LOSS_COLOR);
         comments.Show();

        }


//--- show web error
   if(run_mode==RUN_LIVE)
     {

      //--- check bot registration
      if(time_check<TimeLocal()-PeriodSeconds(PERIOD_H1))
        {
         time_check=TimeLocal();
         if(TerminalInfoInteger(TERMINAL_CONNECTED))
           {
            //---
            web_error=smartBot.GetMe();
            if(web_error!=0)
              {
               //---
               if(web_error==ERR_NOT_ACTIVE)
                 {
                  time_check=TimeLocal()-PeriodSeconds(PERIOD_H1)+300;
                 }
               //---
               else
                 {
                  time_check=TimeLocal()-PeriodSeconds(PERIOD_H1)+5;
                 }
              }
           }
         else
           {
            web_error=ERR_NOT_CONNECTED;
            time_check=0;
           }
        }

      //--- show error
      if(web_error!=0)
        {
         comments.Clear();
         comments.SetText(0,StringFormat("%s v.%s",EXPERT_NAME,5.1),CAPTION_COLOR);
         comments.SetText(1,GetErrorDescription(web_error,InpLanguage),LOSS_COLOR);

         comments.SetText(1,StringFormat("%s: %s",(InpLanguage==LANGUAGE_EN)?"BOT":"Имя Бота",smartBot.Name()),CAPTION_COLOR);
         comments.SetText(2,StringFormat("%s: %d",(InpLanguage==LANGUAGE_EN)?"CHART":"Чаты",ChartID()),CAPTION_COLOR);
         comments.Show();
       
        }


     }
//-- EnableEventMouseMove
   string status2="Copyright ©2021-2022,www.tradeexperts.org "+(string)TimeCurrent();
   ObjectCreate("M5", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("M5",status2,20,"Arial",clrOrange);
   ObjectSet("M5", OBJPROP_CORNER, 2);
   ObjectSet("M5", OBJPROP_XDISTANCE, 500);
   ObjectSet("M5", OBJPROP_YDISTANCE, 0);
  }

//+------------------------------------------------------------------+
//| Create the buttons panel                                         |
//+------------------------------------------------------------------+
bool CreateButtons(const int shift_x=30,const int shift_y=0, int h=18,int w=84)
  {
 
   int cx=offset+shift_x,cy=offset+shift_y+(h+1)*(TOTAL_BUTT/2)+3*h+1;
   int x=cx,y=cy;
   int shift=0;
   for(int i=0;i<TOTAL_BUTT;i++)
     {
      x=x+(i==7 ? w+2 : 0);
      if(i==TOTAL_BUTT-6) x=cx;
      y=(cy-(i-(i>6 ? 7 : 0))*(h+1));
      if(!ButtonCreate(butt_data[i].name,x,y,(i<TOTAL_BUTT-6 ? w : w*2+2),h,butt_data[i].text,(i<4 ? clrGreen : i>6 && i<11 ? clrRed : clrBlue)))
        {
         Alert(TextByLanguage("Не удалось создать кнопку \"","Could not create button \""),butt_data[i].text);
         return false;
        }
     }
   ChartRedraw(0);
   return true;
  }
//+------------------------------------------------------------------+
