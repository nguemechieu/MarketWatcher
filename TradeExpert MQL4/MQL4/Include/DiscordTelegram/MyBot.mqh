//+------------------------------------------------------------------+
//|                                                        Order.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|   Include                                                        |
//+------------------------------------------------------------------+

#define TELEGRAM_BASE_URL  "https://api.telegram.org"
#define WEB_TIMEOUT        5000

//+------------------------------------------------------------------+
//|   ENUM_CHAT_ACTION                                               |
//+------------------------------------------------------------------+
enum ENUM_CHAT_ACTION
{
   ACTION_CLOSE_BUY,//CLOSE_BUY...
   ACTION_CLOSE_SELL,//CLOSE_SELL...
   ACTION_NO_TRADE_NOW,// NEUTRAL...
   ACTION_OPEN_SAFE_TRADE,//OPEN_SAFE_TRADE...
   ACTION_OPEN_PENDING_ORDERS,//OPEN_PENDING_ORDERS...
   ACTION_OPEN_ORDERS_CLOSE,//OPEN_ORDERS_CLOSE...
   ACTION_OPEN_LIMIT_ORDER,//OPEN_LIMIT_ORDER...
   ACTION_CLOSE_LIMIT_ORDER,//CLOSE_LIMIT_ORDER...
   ACTION_CLOSE_PENDING_ORDERS,//CLOSE_PENDING_ORDERS...
   ACTION_CLOSE_ALL_OPEN_POSITIONS,//CLOSE_ALL_OPEN_POSITIONS...
   ACTION_REPLY, //response...
   ACTION_UPDATE_CHART,//Update Charts....
   ACTION_FIND_LOCATION,   //picking location...
   ACTION_RECORD_AUDIO,    //recording audio...
   ACTION_RECORD_VIDEO,    //recording video...
   ACTION_TYPING,          //typing...
   ACTION_UPLOAD_AUDIO,    //sending audio...
   ACTION_UPLOAD_DOCUMENT, //sending file...
   ACTION_UPLOAD_PHOTO,    //sending photo...
   ACTION_UPLOAD_VIDEO ,    //sending video...
   ACTION_OPEN_SELL,//opening sell...
   ACTION_OPEN_BUY,//opening buy...
   ACTION_OPEN_BUYLIMIT,//opening buy limit...
   ACTION_OPEN_SELLLIMIT,//opening sell limit...
   ACTION_OPEN_BUYSTOP,//opening buy stop...
   ACTION_OPEN_SELLSTOP,//opening sell stop...
   ACTION_SELL_SIGNAL,//Sell signal...
   ACTION_BUY_SIGNAL//Buy signal...
};
       

string message;

#include <DiscordTelegram/Common.mqh>//start settings all include file orders matters
#include <DiscordTelegram/Object.mqh>
#include <Arrays/List.mqh>

#include <DiscordTelegram/Comment.mqh>

#include <DiscordTelegram/Binance.mqh>
#include <DiscordTelegram/createObjects.mqh>
#include <Coinbase.mqh>

#include <DiscordTelegram/sender_chat.mqh>
#include <DiscordTelegram/entities.mqh>
#include <DiscordTelegram/chat.mqh>
#include <DiscordTelegram/ccustomChat.mqh>

#include <DiscordTelegram/channel_post.mqh>
#include <DiscordTelegram/Message.mqh>

#include <DiscordTelegram/CCUSTOMMESSAGES.mqh>
#include <DiscordTelegram/result.mqh>
#include <DiscordTelegram/News.mqh>
#define  NL "\n"
//https://discord.com/api/v8'
//CLIENT_ID = '332269999912132097'
//CLIENT_SECRET = '937it3ow87i4ery69876wqire'

CCustomMessage msg;
CCustomChat chat;
//+------------------------------------------------------------------+
//|   Defines                                                        |
//+------------------------------------------------------------------+
#define  TWITTER_BASE_URL "https://www.twitter.com/"
#define  FACEBOOK_BASE_URL "https://www.facebook.coom/"

string message_text[2];

//+------------------------------------------------------------------+
//|   CCustomBot                                                     |
//+------------------------------------------------------------------+

class Bot :public CObject
{

  private: ENUM_TIMEFRAMES   m_period;
   string            m_template;
   CArrayString      m_templates;
   ENUM_TIMEFRAMES   _periods[];
   string m_token;
         string            m_name;
   long              m_update_id;
      CArrayString      m_users_filter;
      bool              m_first_remove;

 
 string m_symbol;
 


ENUM_LANGUAGES m_lang,InpLanguage;
 protected :CList             m_chats;


   //+------------------------------------------------------------------+
 public:  int               SaveToFile(const string filename,
                                const char &text[])
   {
      ResetLastError();

      int handle=FileOpen(filename,FILE_BIN|FILE_ANSI|FILE_WRITE);
      if(handle==INVALID_HANDLE)
      {
         return(GetLastError());
      }

      FileWriteArray(handle,text);
      FileClose(handle);

      return(0);
   }


         

   //+------------------------------------------------------------------+
   string            StringTrim(string text)
   {
#ifdef __MQL4__
      text = StringTrimLeft(text);
      text = StringTrimRight(text);
#endif
#ifdef __MQL5__
      StringTrimLeft(text);
      StringTrimRight(text);
#endif
      return(text);
   }
  public:
    




   //+------------------------------------------------------------------+
   void              ArrayAdd(uchar &dest[],const uchar &src[])
   {
      int src_size=ArraySize(src);
      if(src_size==0)
         return;

      int dest_size=ArraySize(dest);
      ArrayResize(dest,dest_size+src_size,500);
      ArrayCopy(dest,src,dest_size,0,src_size);
   }

   //+------------------------------------------------------------------+
   void              ArrayAdd(char &dest[],const string text)
   {
      int len=StringLen(text);
      if(len>0)
      {
         uchar src[];
         for(int i=0; i<len; i++)
         {
            ushort ch=StringGetCharacter(text,i);

            uchar array[];
            int total=ShortToUtf8(ch,array);

            int size=ArraySize(src);
            ArrayResize(src,size+total);
            ArrayCopy(src,array,size,0,total);
         }
         ArrayAdd(dest,src);
      }
   }

  

   //+------------------------------------------------------------------+
   string            UrlEncode(const string text)
   {
      string result=NULL;
      int length=StringLen(text);
      for(int i=0; i<length; i++)
      {
         ushort ch=StringGetCharacter(text,i);

         if((ch>=48 && ch<=57) || // 0-9
               (ch>=65 && ch<=90) || // A-Z
               (ch>=97 && ch<=122) || // a-z
               (ch=='!') || (ch=='\'') || (ch=='(') ||
               (ch==')') || (ch=='*') || (ch=='-') ||
               (ch=='.') || (ch=='_') || (ch=='~')
           )
         {
            result+=ShortToString(ch);
         }
         else
         {
            if(ch==' ')
               result+=ShortToString('+');
            else
            {
               uchar array[];
               int total=ShortToUtf8(ch,array);
               for(int k=0; k<total; k++)
                  result+=StringFormat("%%%02X",array[k]);
            }
         }
      }
      return result;
   }



   //+------------------------------------------------------------------+
 int               PostRequest(string &out3,
                                 const string url,
                                 const string params,
                                 const int timeout=5000)
   { int   start_index=0;
      char data[];
      int data_size=StringLen(params);
      StringToCharArray(params,data,0,data_size);

      uchar result[];
      string result_headers;

      //--- application/x-www-form-urlencoded
      int res=WebRequest("POST",url,NULL,NULL,timeout,data,data_size,result,result_headers);
      if(res==200)//OK
      {
         //--- delete BOM
       
         int size=ArraySize(result);
         for(int i=0; i<fmin(size,8); i++)
         {
            if(result[i]==0xef || result[i]==0xbb || result[i]==0xbf)
               start_index=i+1;
            else
               break;
         }
         //---
         out3=CharArrayToString(result,start_index,WHOLE_ARRAY,CP_UTF8);
         return(0);
      }
      else
      {
         if(res==-1)
         {
            return(_LastError);
         }
         else
         {
            //--- HTTP errors
            if(res>=100 && res<=511)
            {
               out3=CharArrayToString(result,0,WHOLE_ARRAY,CP_UTF8);
               Print(out);
               return(ERR_HTTP_ERROR_FIRST+res);
            }
            return(res);
         }
      }

      return(0);
   }

   //+------------------------------------------------------------------+
   int               ShortToUtf8(const ushort _ch,uchar &out2[])
   {
      //---
      if(_ch<0x80)
      {
         ArrayResize(out2,1);
         out2[0]=(uchar)_ch;
         return(1);
      }
      //---
      if(_ch<0x800)
      {
         ArrayResize(out2,2);
         out2[0] = (uchar)((_ch >> 6)|0xC0);
         out2[1] = (uchar)((_ch & 0x3F)|0x80);
         return(2);
      }
      //---
      if(_ch<0xFFFF)
      {
         if(_ch>=0xD800 && _ch<=0xDFFF)//Ill-formed
         {
            ArrayResize(out2,1);
            out2[0]=' ';
            return(1);
         }
         else if(_ch>=0xE000 && _ch<=0xF8FF)//Emoji
         {
            int ch=0x10000|_ch;
            ArrayResize(out2,4);
            out2[0] = (uchar)(0xF0 | (ch >> 18));
            out2[1] = (uchar)(0x80 | ((ch >> 12) & 0x3F));
            out2[2] = (uchar)(0x80 | ((ch >> 6) & 0x3F));
            out2[3] = (uchar)(0x80 | ((ch & 0x3F)));
            return(4);
         }
         else
         {
            ArrayResize(out2,3);
            out2[0] = (uchar)((_ch>>12)|0xE0);
            out2[1] = (uchar)(((_ch>>6)&0x3F)|0x80);
            out2[2] = (uchar)((_ch&0x3F)|0x80);
            return(3);
         }
      }
      ArrayResize(out2,3);
      out2[0] = 0xEF;
      out2[1] = 0xBF;
      out2[2] = 0xBD;
      return(3);
   }

   //+------------------------------------------------------------------+
   int               StringReplaceEx(string &string_var,
                                     const int start_pos,
                                     const int length,
                                     const string replacement)
   {
      string temp=(start_pos==0)?"":StringSubstr(string_var,0,start_pos);
      temp+=replacement;
      temp+=StringSubstr(string_var,start_pos+length);
      string_var=temp;
      return(StringLen(replacement));
   }

   //+------------------------------------------------------------------+
   string            BoolToString(const bool _value)
   {
      if(_value)return("true");
      return("false");
   }


   //+------------------------------------------------------------------+
   int               SendPhoto(const long   _chat_id,
                               const string _photo_id,
                               const string _caption=NULL)
   {
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

     
      string url=StringFormat("%s/bot%s/sendPhoto",TELEGRAM_BASE_URL,m_token);
      string params=StringFormat("chat_id=%lld&photo=%s",_chat_id,_photo_id);
      if(_caption!=NULL)
         params+="&caption="+UrlEncode(_caption);

      int res=PostRequest(out,url,params,WEB_TIMEOUT);
      if(res!=0)
      { CJAVal   item,js(NULL,out);
         //--- parse result
        
         bool done=js.Deserialize(out);
         if(!done)
            return(ERR_JSON_PARSING);

         //--- get error description
         bool ok=js["ok"].ToBool();
         long err_code=js["error_code"].ToInt();
         string err_desc=js["description"].ToStr();
      }
       Sleep(5000);
      //--- done
      return(res);
   }

   //+------------------------------------------------------------------+
   int               SendPhotoToChannel(string &_photo_id,
                               const string _channel_name,
                               const string _local_path,
                               const string _caption=NULL,
                               const bool _common_flag=false,
                               const int _timeout=10000)
   {
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

      string name=StringTrim(_channel_name);
      if(StringGetCharacter(name,0)!='@')
         name="@"+name;

      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

      ResetLastError();
      //--- copy file to memory buffer
      if(!FileIsExist(_local_path,_common_flag))
         return(ERR_FILE_NOT_EXIST);

      //---
      int flags=FILE_READ|FILE_BIN|FILE_SHARE_WRITE|FILE_SHARE_READ;
      if(_common_flag)
         flags|=FILE_COMMON;

      //---
      int file=FileOpen(_local_path,flags);
      if(file<0)
         return(_LastError);

      //---
      int file_size=(int)FileSize(file);
      uchar photo[];
      ArrayResize(photo,file_size);
      FileReadArray(file,photo,0,file_size);
      FileClose(file);

      //--- create boundary: (data -> base64 -> 1024 bytes -> md5)
      uchar base64[];
      uchar key[];
      CryptEncode(CRYPT_BASE64,photo,key,base64);
      //---
      uchar temp[1024]= {0};
      ArrayCopy(temp,base64,0,0,1024);
      //---
      uchar md5[];
      CryptEncode(CRYPT_HASH_MD5,temp,key,md5);
      //---
      string hash=NULL;
      int total=ArraySize(md5);
      for(int i=0; i<total; i++)
         hash+=StringFormat("%02X",md5[i]);
      hash=StringSubstr(hash,0,16);

      //--- WebRequest
      uchar result[];
      string result_headers;

      string url=StringFormat("%s/bot%s/sendPhoto",TELEGRAM_BASE_URL,m_token);

      //--- 1
      uchar data[];

      //--- add chart_id
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,"--"+hash+"\r\n");
      ArrayAdd(data,"Content-Disposition: form-data; name=\"chat_id\"\r\n");
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,name);
      ArrayAdd(data,"\r\n");

      if(StringLen(_caption)>0)
      {
         ArrayAdd(data,"--"+hash+"\r\n");
         ArrayAdd(data,"Content-Disposition: form-data; name=\"caption\"\r\n");
         ArrayAdd(data,"\r\n");
         ArrayAdd(data,_caption);
         ArrayAdd(data,"\r\n");
      }

      ArrayAdd(data,"--"+hash+"\r\n");
      ArrayAdd(data,"Content-Disposition: form-data; name=\"photo\"; filename=\"lampash.gif\"\r\n");
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,photo);
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,"--"+hash+"--\r\n");

      // SaveToFile("debug.txt",data);

      //---
      int   start_index=0;
      string headers="Content-Type: multipart/form-data; boundary="+hash+"\r\n";
      int res=WebRequest("POST",url,headers,_timeout,data,result,result_headers);
      if(res==200)//OK
      {
         //--- delete BOM
         
         int size=ArraySize(result);
         for(int i=0; i<fmin(size,8); i++)
         {
            if(result[i]==0xef || result[i]==0xbb || result[i]==0xbf)
               start_index=i+1;
            else
               break;
         }
         //---
      out=CharArrayToString(result,start_index,WHOLE_ARRAY,CP_UTF8);

         //--- parse result
       CJAVal   item,js(NULL,out);
         bool done=js.Deserialize(out);
         if(!done)
            return(ERR_JSON_PARSING);

         //--- get error description
         bool ok=js["ok"].ToBool();
         if(!ok)
            return(ERR_JSON_NOT_OK);

         total=ArraySize(js["result"]["photo"].m_e);
         for(int i=0; i<total; i++)
         {
            CJAVal image=js["result"]["photo"].m_e[i];

            long image_size=image["file_size"].ToInt();
            if(image_size<=file_size)
               _photo_id=image["file_id"].ToStr();
         }

         return(0);
      }
      else
      {
         if(res==-1)
         {
            out=CharArrayToString(result,0,WHOLE_ARRAY,CP_UTF8);
            //Print(out);
            return(_LastError);
         }
         else
         {
            if(res>=100 && res<=511)
            {
             out=CharArrayToString(result,0,WHOLE_ARRAY,CP_UTF8);
               //Print(out);
               return(ERR_HTTP_ERROR_FIRST+res);
            }
            return(res);
         }
      }
       Sleep(5000);
      //---
      return(0);
   }

   //+------------------------------------------------------------------+
   int               SendPhoto(string &_photo_id,
                               const long _chat_id,
                               const string _local_path,
                               const string _caption=NULL,
                               const bool _common_flag=false,
                               const int _timeout=10000)
   { int start_index=0;
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

      ResetLastError();
      //--- copy file to memory buffer
      if(!FileIsExist(_local_path,_common_flag))
         return(ERR_FILE_NOT_EXIST);

      //---
      int flags=FILE_READ|FILE_BIN|FILE_SHARE_WRITE|FILE_SHARE_READ;
      if(_common_flag)
         flags|=FILE_COMMON;

      //---
      int file=FileOpen(_local_path,flags);
      if(file<0)
         return(_LastError);

      //---
      int file_size=(int)FileSize(file);
      uchar photo[];
      ArrayResize(photo,file_size);
      FileReadArray(file,photo,0,file_size);
      FileClose(file);

      //--- create boundary: (data -> base64 -> 1024 bytes -> md5)
      uchar base64[];
      uchar key[];
      CryptEncode(CRYPT_BASE64,photo,key,base64);
      //---
      uchar temp[1024]= {0};
      ArrayCopy(temp,base64,0,0,1024);
      //---
      uchar md5[];
      CryptEncode(CRYPT_HASH_MD5,temp,key,md5);
      //---
      string hash=NULL;
      int total=ArraySize(md5);
      for(int i=0; i<total; i++)
         hash+=StringFormat("%02X",md5[i]);
      hash=StringSubstr(hash,0,16);

      //--- WebRequest
      uchar result[];
      string result_headers;

      string url=StringFormat("%s/bot%s/sendPhoto",TELEGRAM_BASE_URL,m_token);

      //--- 1
      uchar data[];

      //--- add chart_id
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,"--"+hash+"\r\n");
      ArrayAdd(data,"Content-Disposition: form-data; name=\"chat_id\"\r\n");
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,IntegerToString(_chat_id));
      ArrayAdd(data,"\r\n");

      if(StringLen(_caption)>0)
      {
         ArrayAdd(data,"--"+hash+"\r\n");
         ArrayAdd(data,"Content-Disposition: form-data; name=\"caption\"\r\n");
         ArrayAdd(data,"\r\n");
         ArrayAdd(data,_caption);
         ArrayAdd(data,"\r\n");
      }

      ArrayAdd(data,"--"+hash+"\r\n");
      ArrayAdd(data,"Content-Disposition: form-data; name=\"photo\"; filename=\"lampash.gif\"\r\n");
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,photo);
      ArrayAdd(data,"\r\n");
      ArrayAdd(data,"--"+hash+"--\r\n");

      // SaveToFile("debug.txt",data);

      //---
      string headers="Content-Type: multipart/form-data; boundary="+hash+"\r\n";
      int res=WebRequest("POST",url,headers,_timeout,data,result,result_headers);
      if(res==200)//OK
      {
         //--- delete BOM
         
         int size=ArraySize(result);
         for(int i=0; i<fmin(size,8); i++)
         {
            if(result[i]==0xef || result[i]==0xbb || result[i]==0xbf)
               start_index=i+1;
            else
               break;
         }

         //---
      out=CharArrayToString(result,start_index,WHOLE_ARRAY,CP_UTF8);

         //--- parse result
          CJAVal   item,js(NULL,out);
         bool done=js.Deserialize(out);
         if(!done)
            return(ERR_JSON_PARSING);

         //--- get error description
         bool ok=js["ok"].ToBool();
         if(!ok)
            return(ERR_JSON_NOT_OK);

         total=ArraySize(js["result"]["photo"].m_e);
         for(int i=0; i<total; i++)
         {
            CJAVal image=js["result"]["photo"].m_e[i];

            long image_size=image["file_size"].ToInt();
            if(image_size<=file_size)
               _photo_id=image["file_id"].ToStr();
         }

         return(0);
      }
      else
      {
         if(res==-1)
         {
    out=CharArrayToString(result,0,WHOLE_ARRAY,CP_UTF8);
            Print("out error"+out);
            return(_LastError);
         }
         else
         {
            if(res>=100 && res<=511)
            {
              out=CharArrayToString(result,0,WHOLE_ARRAY,CP_UTF8);
                Print("out chat receive "+out);
               return(ERR_HTTP_ERROR_FIRST+res);
            }
            return(res);
         }
      }
       Sleep(5000);
      //---
      return(0);
   }
   //+------------------------------------------------------------------+


   //+------------------------------------------------------------------+
   int               SendMessage(const long    _chat_id,
                                 const string  _text,
                                 const string  _reply_markup=NULL,
                                 const bool    _as_HTML=false,
                                 const bool    _silently=false)
   {
   
int min=Minute();
   if(min==15
   ||min==30
     ||min==45
      ||min==59){
   
      //--- check token
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

   
      string url=StringFormat("%s/bot%s/sendMessage",TELEGRAM_BASE_URL,m_token);

      string params=StringFormat("chat_id=%lld&text=%s",_chat_id,UrlEncode(_text));
      if(_reply_markup!=NULL)
         params+="&reply_markup="+_reply_markup;
      if(_as_HTML)
         params+="&parse_mode=HTML";
      if(_silently)
         params+="&disable_notification=true";

      int res=PostRequest(out,url,params,WEB_TIMEOUT);
      }
       Sleep(5000);//to prevent sending  multiple messages per second
      return 0;
   }

   //+------------------------------------------------------------------+
   int               SendMessage(const string _channel_name,
                                 const string _text,
                                 const bool   _as_HTML=false,
                                 const bool   _silently=false)
   {
    
 int min=Minute();
   if(min==15
   ||min==30
     ||min==45
      ||min==59){
      //--- check token
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

      string name=StringTrim(_channel_name);
      if(StringGetCharacter(name,0)!='@')
         name="@"+name;

   
      string url=StringFormat("%s/bot%s/sendMessage",TELEGRAM_BASE_URL,m_token);
      string params=StringFormat("chat_id=%s&text=%s",name,UrlEncode(_text));
      if(_as_HTML)
         params+="&parse_mode=HTML";
      if(_silently)
         params+="&disable_notification=true";
      //      Print(params);
      int res=PostRequest(out,url,params,WEB_TIMEOUT);
      }
       Sleep(5000);
      return 0;
   }

   //+------------------------------------------------------------------+
   string            ReplyKeyboardMarkup(const string keyboard,
                                         const bool resize,
                                         const bool one_time)
   {
      string result=StringFormat("{\"keyboard\": %s, \"one_time_keyboard\": %s, \"resize_keyboard\": %s, \"selective\": false}",UrlEncode(keyboard),BoolToString(resize),BoolToString(one_time));
      return(result);
   }

   //+------------------------------------------------------------------+
   string            ReplyKeyboardHide()
   {
      return("{\"hide_keyboard\": true}");
   }

   //+------------------------------------------------------------------+
   string            ForceReply()
   {
      return("{\"force_reply\": true}");
   }
   


 
      //+------------------------------------------------------------------+
   int               ChatsTotal()
   {
      return(m_chats.Total());
   }

   //+------------------------------------------------------------------+
  int               Token(const string _token)
   {
      string token=StringTrim(_token);
      if(token=="")
         return(ERR_TOKEN_ISEMPTY);
      //---
      m_token=token;
      return(0);
   }

   //+------------------------------------------------------------------+
   void              UserNameFilter(const string username_list)
   {
      m_users_filter.Clear();

      //--- parsing
      string text=StringTrim(username_list);
      if(text=="")
         return;

      //---
      while(StringReplace(text,"  "," ")>0);
      StringReplace(text,";"," ");
      StringReplace(text,","," ");

      //---
      string array[];
      int amount=StringSplit(text,' ',array);
      for(int i=0; i<amount; i++)
      {
         string username=StringTrim(array[i]);
         if(username!="")
         {
            //--- remove first @
            if(StringGetCharacter(username,0)=='@')
               username=StringSubstr(username,1);

            m_users_filter.Add(username);
         }
      }

   }
   //+------------------------------------------------------------------+
 string            Name()
   {
      return(m_name);
   }

   
   
   
   
   
   
   
   int               PostRequest(string &out2,
                                 const string &url,
                                 const string &params,
                                 const int timeout=5000)
   {
      char data[];
      int data_size=StringLen(params);
      StringToCharArray(params,data,0,data_size);

      uchar result[];
      string result_headers;

      //--- application/x-www-form-urlencoded
      int res=WebRequest("POST",url,NULL,NULL,timeout,data,data_size,result,result_headers);
      if(res==200)//OK
      {
         //--- delete BOM
         int   start_index=0;
         int size=ArraySize(result);
         for(int i=0; i<fmin(size,8); i++)
         {
            if(result[i]==0xef || result[i]==0xbb || result[i]==0xbf)
               start_index=i+1;
            else
               break;
         }
         //---
         out2=CharArrayToString(result,start_index,WHOLE_ARRAY,CP_UTF8);
         return(0);
      }
      else
      {
         if(res==-1)
         {
            return(_LastError);
         }
         else
         {
            //--- HTTP errors
            if(res>=100 && res<=511)
            {
               out2=CharArrayToString(result,0,WHOLE_ARRAY,CP_UTF8);
               Print(out);
               return(ERR_HTTP_ERROR_FIRST+res);
            }
            return(res);
         }
      }

      return(0);
   }

   //+------------------------------------------------------------------+
   string            StringDecode(string text)
   {
      //--- replace \n
      StringReplace(text,"\n",ShortToString(0x0A));

      //--- replace \u0000
      int haut=0;
      int pos=StringFind(text,"\\u");
      while(pos!=-1)
      {
         string strcode=StringSubstr(text,pos,6);
         string strhex=StringSubstr(text,pos+2,4);

         StringToUpper(strhex);

         int total=StringLen(strhex);
         int result=0;
         for(int i=0,k=total-1; i<total; i++,k--)
         {
            int coef=(int)pow(2,4*k);
            ushort ch=StringGetCharacter(strhex,i);
            if(ch>='0' && ch<='9')
               result+=(ch-'0')*coef;
            if(ch>='A' && ch<='F')
               result+=(ch-'A'+10)*coef;
         }

         if(haut!=0)
         {
            if(result>=0xDC00 && result<=0xDFFF)
            {
               int dec=((haut-0xD800)<<10)+(result-0xDC00);//+0x10000;
               StringReplaceEx(text,pos,6,ShortToString((ushort)dec));
               haut=0;
            }
            else
            {
               //--- error: Second byte out of range
               haut=0;
            }
         }
         else
         {
            if(result>=0xD800 && result<=0xDBFF)
            {
               haut=result;
               StringReplaceEx(text,pos,6,"");
            }
            else
            {
               StringReplaceEx(text,pos,6,ShortToString((ushort)result));
            }
         }

         pos=StringFind(text,"\\u",pos);
      }
      return(text);
   }



//+------------------------------------------------------------------+
//|   ChatActionToString                                             |
//+------------------------------------------------------------------+
string ChatActionToString(const ENUM_CHAT_ACTION _action)
{
   string result=EnumToString(_action);
   result=StringSubstr(result,7);
   StringToLower(result);
   return(result);
}
   //+------------------------------------------------------------------+
   int               SendChatAction(const long _chat_id,
                                    const ENUM_CHAT_ACTION _action)
   {
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);
//      string out;
      string url=StringFormat("%s/bot%s/sendChatAction",TELEGRAM_BASE_URL,m_token);
      string params=StringFormat("chat_id=%lld&action=%s",_chat_id,ChatActionToString(_action));
      int res=PostRequest(out,url,params,WEB_TIMEOUT);
      return(res);
   }
     int               GetMe()
   {
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);
      //---
     
      string url=StringFormat("%s/bot%s/getMe",TELEGRAM_BASE_URL,m_token);
      string params="";
      int res=PostRequest(out,url,params,WEB_TIMEOUT);
      if(res==0)
      {
          CJAVal   item,js(NULL,out);
         //---
         bool done=js.Deserialize(out);
         if(!done)
            return(ERR_JSON_PARSING);

         //---
         bool ok=js["ok"].ToBool();
         if(!ok)
            return(ERR_JSON_NOT_OK);

         //---
         if(m_name==NULL)
            m_name=js["result"]["username"].ToStr();
      }
      //---
      return(res);
   }
   int  totalchat[9];
   //+------------------------------------------------------------------+
 void               ProcessMessages ()
   {
    
   
   
    if(m_token==NULL)MessageBox("API TOKEN CAN'T BE EMPTY ","API ERROR",1);
         return;
         char response[],post[],result1[];
         string response_header;
   
      string url=StringFormat("%s/bot%s/getUpdates%s",TELEGRAM_BASE_URL,m_token);
      string params=StringFormat("offset=%d",m_update_id);
      //---
      int res=PostRequest(out,url,params,5000);
      if(res==0)
      {
    
       out= CharArrayToString(result1,0,WHOLE_ARRAY,CP_UTF8);
          totalchat[0]=ArraySize(result1);
         Cresult result;
      
         CJAVal   item,js(NULL,out);
         
         bool done=js.Deserialize(out);
 
     
           if(!done)Alert("JASON ERROR ON CHAT");
           printf("json chat error");
            return;

         bool ok=js["ok"].ToBool();
         if(!ok) printf("chat jason file is not correct!"); return;
         
             msg.setOk(item["ok"].ToBool());  
            printf("out 1"+out);
         for( int index=0; index<ArraySize(result1);index++)
         {Print("Arraysize"+(string)ArraySize(result1));
         //--- parse result
    
 
            item=js.m_e[index];
            
          
                msg.setText(item["message"]["text"].ToStr());
              printf("text 1"+item["message"]["text"].ToStr());
       
            msg.setMessage_id((int)item["message"]["message_id"].ToInt());
            msg.setMessage_date((datetime)item["message"]["date"].ToInt());
            //---
                  msg.text=(item["message"]["text"].ToStr());
       
            msg.setMessage_text(item["message"]["message_text"].ToStr());
            printf("text 1"+item["message"]["message_text"].ToStr());
            //---
            msg.from.setIs_bot(item["message"]["from"]["is_bot"].ToBool());
            msg.setForward_date((datetime)item["message"]["forward_date"].ToInt());
              msg.forward_from_message_id=(long)item["message"]["forward_from_message_id"].ToInt();
                msg.setForward_signature(item["message"]["forward_signature"].ToStr());
            
            msg.from.setId((int)item["message"]["from"]["id"].ToInt());
            msg.from.setFirst_name(item["message"]["from"]["first_name"].ToStr());
        
            msg.from.setLast_name(item["message"]["from"]["last_name"].ToStr());
            msg.from.setUsername(
           item["message"]["chat"]["username"].ToStr());
         
            //---
      msg.chat.setM_id((int) item["message"]["chat"]["id"].ToInt());
            
              
            msg.chat.m_new_one.setFrom_first_name(item["message"]["chat"]["first_name"].ToStr());
          
            msg.chat.m_new_one.setFrom_last_name(item["message"]["chat"]["last_name"].ToStr());
         

            msg.chat_type=item["message"]["chat"]["type"].ToStr();
            

            msg.chat.setM_id((int)item["message"]["chat"]["id"].ToInt());
            msg.chat.getM_id();
            
            msg.setOk(ok);
            msg.sender_chat.setId(  (int)item["message"]["sender_chat"]["id"].ToInt()) ;
            msg.sender_chat.setTitle(item["message"]["sender_chat"]["title"].ToStr());
            msg.sender_chat.setType(item["message"]["sender_chat"]["type"].ToStr());
            msg.sender_chat.setUsername(item["message"]["sender_chat"]["username"].ToStr());
            msg.entities.offset=item["message"]["entities"]["offset"].ToInt();
            msg.entities.type=item["message"]["entities"]["type"].ToStr();
            msg.entities.length=  item["message"]["entities"]["length"].ToInt();
            msg.author_signature  =item["message"]["author_signature"].ToStr();
              msg.setUpdate_id((int)item["update_id"].ToInt());
            (item["message"]["chat"]["username"].ToStr());
            result.update_id=(int)msg.update_id;
            result.channel_post.message_id=item["message"]["channel_post"]["id"].ToInt();
     
          
         int filehandle=FileOpen(InpDirectoryName+"\\"+"Telegram.txt",FILE_READ|FILE_WRITE|FILE_TXT|InpEncodingType);
         FileSeek(filehandle,0,SEEK_END);
         FileWrite(filehandle,(string)msg.date+"  "+msg.getMessage_text());
         
         FileClose(filehandle);
        totalchat[0]=  ArraySize(result1);
           for( index=0; index<ArraySize(result1);index++){
            if(m_first_remove)
               continue;

            //--- filter
            if(m_users_filter.Total()==0 || (m_users_filter.Total()>0 && m_users_filter.SearchLinear(msg.from_username)>=0))
            {

               //--- find the chat
              index=-1;
               for(int j=0; j<ArraySize(result1); j++)
               {
              msg. chat=m_chats.GetNodeAtIndex(j);
                  if(InpChatID==msg.chat.m_new_one.getFrom_id())
                  {
                     index=j;
                     break;
                  }
               }
               //--- add new one to the chat list
               if(index==0)
               {
                  m_chats.Add(new CCustomChat);
                msg. chat=m_chats.GetLastNode();
            
                  msg.chat.m_time=TimeCurrent();
                  msg.chat.m_state=0;
                  msg.chat.m_new_one.message_text= msg.getText();
                  msg.chat.m_new_one.setDone(true);
               }
               //--- update chat message
               else
               {
            msg. chat=m_chats.GetNodeAtIndex(index);
                 msg. chat.m_time=TimeCurrent();
                 msg. chat.m_new_one.message_text=msg.getText();
                 msg. chat.m_new_one.setDone(true);
               }
            }
         }
         m_first_remove=false;
      }
      
      
      }
      
   #define EMOJI_TOP    "\xF51D"
#define EMOJI_BACK   "\xF519"
#define KEYB_MAIN    (m_lang==LANGUAGE_EN)?"[[\"/account\"],[\"/quote\"],[\"/chart\"],[\"/ordertrade\"],[\"/ordertotal\"],[\"/ticket\"],[\"/historyTotal\"],[\"/tradereport\"],[\"/analysis\"],[\"/trade\"],[\"/news\"]]":"[[\"Информация\"],[\"Котировки\"],[\"Графики\"]]"
#define KEYB_TRADE    (m_lang==LANGUAGE_EN)?"[[\"/BUY\"],[\"/SELL\"],[\"/BUYLIMIT\"],[\"/SELLIMIT\"],[\"/BUYSTOP\"],[\"/SELLSTOP\"]":"[[\"Информация\"],[\"Котировки\"],[\"Графики\"]]"

#define KEYB_SYMBOLS "[[\""+EMOJI_TOP+"\",\"/GBPUSD\",\"/EURUSD\"],[\"/AUDUSD\",\"/USDJPY\",\"/EURJPY\"],[\"/USDCAD\",\"/USDCHF\",\"/EURCHF\"]]"

#define KEYB_PERIODS "[[\""+EMOJI_TOP+"\",\"M1\",\"M5\",\"M15\"],[\""+EMOJI_BACK+"\",\"M30\",\"H1\",\"H4\"],[\" \",\"D1\",\"W1\",\"MN1\"]]"

 
string mask,text;
  int i=0; 
  
  Alert ("chat total"+(string)ArraySize(result1));
      for (i=0;i<ArraySize(result1);i++)
      { 
      
       
      msg.chat=msg.chat.m_new_one.m_chats.GetNodeAtIndex(i);
        
       
         msg.chat.m_new_one.setDone(false);
          
            text=msg.getText();
            printf("chat text"+msg.getText());
            if(text!=NULL){   
               msg.chat.m_new_one.setDone(true);};
        
            //--- start
            if(text=="/start" || text=="/help")
            {
               msg. chat.setM_state(0);
             msgs="The bot works with your trading account:\n";
               msgs+="/account- get account information\n";
               msgs+="/quote - get quotes\n";
               msgs+="/chart - get chart images\n";
               
               msgs+="/news - get news\n";
               
               msgs+="/help - get help \n";
               

               if(m_lang==LANGUAGE_RU)
               {
                  msgs="Бот работает с вашим торговым счетом:\n";
                  msgs+="/account - запросить информацию по счету\n";
                  msgs+="/quote - запросить котировки\n";
                  msgs+="/chart - запросить график\n";
               }

              SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_MAIN,false,false),false,false);
               continue;
            }

            //---
            if(text==EMOJI_TOP)
            {
         msg. chat.setM_state(0);
            msgs=(m_lang==ENGLISH)?"Choose a menu item":"Выберите пункт меню";
            SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_MAIN,false,false));
               continue;
            }

            //---
            if(text==EMOJI_BACK)
            {
               if( msg.chat.getM_state()==31)
               
               msg. chat.setM_state(3);
                msgs=(m_lang==ENGLISH)?"Enter a symbol name like 'EURUSD'":"Введите название инструмента, например 'EURUSD'";
         SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_SYMBOLS,false,false));
               }
               else if(msg.chat.getM_state()==32)
               {
                msg.chat.setM_state(31);
                msgs=(m_lang==ENGLISH)?"Select a timeframe like 'H1'":"Введите период графика, например 'H1'";
             SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_PERIODS,false,false));
               }
               else
               {
              msg. chat.setM_state(0);
              msgs=(m_lang==ENGLISH)?"Choose a menu item":"Выберите пункт меню";
               SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_MAIN,false,false));
               }
               continue;
            

            //---
            if( text=="/account" || text=="Информация")
            {
             msg.chat.setM_state(1);
               string currency=AccountInfoString(ACCOUNT_CURRENCY);
               msgs=StringFormat("%d: %s\n",AccountInfoInteger(ACCOUNT_LOGIN),AccountInfoString(ACCOUNT_SERVER));
               msgs+=StringFormat("%s: %.2f %s\n",(m_lang==ENGLISH)?"Balance":"Баланс",AccountInfoDouble(ACCOUNT_BALANCE),currency);
               msgs+=StringFormat("%s: %.2f %s\n",(m_lang==ENGLISH)?"Profit":"Прибыль",AccountInfoDouble(ACCOUNT_PROFIT),currency);
               SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_MAIN,false,false));
            }
            
            
            
            
            if(text =="/trade"){
              msgs= StringFormat("%s","Enter your pair to trade");
         SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_SYMBOLS,false,false));
           }
            
            
               
            if(text =="/"+_Symbol){
     
           
    
             msgs= StringFormat("%s","click BUY OR SELL TO TRADE");
                    SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_TRADE,false,false));
          
            
            }else {
             msgs= StringFormat("%s","WRONG KEYBOARD SELECTED PLEASE TRY AGAIN!");
                 SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_SYMBOLS,false,false));
          
            }
            
            /*              
           if(text=="/BUY"){
          trades.;
           
           }else if (text=="/SELL"){
           
              Os=trades.Sell();           
           }else if(text=="/BUYSTOP"){
           trades.BuyStop();         
           }else if (text=="/SELLSTOP"){
           
             Os=trades.SellStop();
             
           
            }else if(text=="/BUYLIMT"){
                      trades.BuyLimit();
           
           }else if (text=="/SELLLIMT"){
           
                    Os=trades.SellLimit();            }
           
           
     */
           
          

            //---
            if(text=="/quote" || text=="/Quote" || text=="Котировки")
            {
            chat.setM_state(2);
             msgs=(m_lang==ENGLISH)?"Enter a symbol name like 'EURUSD'":"Введите название инструмента, например 'EURUSD'";
            SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_SYMBOLS,false,false));
               continue;
            }

            //---
            if(text=="/chart" ||  text=="Графики")
            {
            msg. chat.setM_state(3);
               msgs=(m_lang==ENGLISH)?"Enter a symbol name like 'EURUSD'":"Введите название инструмента, например 'EURUSD'";
               SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_SYMBOLS,false,false));
               continue;
            }

            //--- Quotes
            if(msg.chat.getM_state()==2)
            {
              mask=(m_lang==ENGLISH)?"Invalid symbol name '%s'":"Инструмент '%s' не найден";
              msgs=StringFormat(mask,text);
               StringToUpper(text);
             string symbol=text;
               if(SymbolSelect(symbol,true))
               {
                  double open[1]= {0};

                  m_symbol=symbol;
                  //--- upload history
                  for(int k=0; k<3; k++)
                  {
#ifdef __MQL4__
                     double array[][6];
                     ArrayCopyRates(array,symbol,PERIOD_D1);
#endif

                     Sleep(2000);
                     CopyOpen(symbol,PERIOD_D1,0,1,open);
                     if(open[0]>0.0)
                        break;
                  }
                 

                  CopyOpen(symbol,PERIOD_D1,0,1,open);
                  if(open[0]>0.0)
                  {
                     double percent=100*(         SymbolInfoDouble(symbol,SYMBOL_BID)-open[0])/open[0];
                     //--- sign
                     string sign=ShortToString(0x25B2);
                     if(percent<0.0)
                        sign=ShortToString(0x25BC);

                     msgs=StringFormat("%s: %s %s (%s%%)",symbol,DoubleToString(

                 (int)DoubleToString( SymbolInfoDouble(symbol,SYMBOL_BID)),

                  (int)SymbolInfoInteger(symbol,SYMBOL_DIGITS)),sign,DoubleToString(percent,2));
                  }
                  else
                  {
                     msgs=m_lang==ENGLISH?"No history for ":"Нет истории для "+symbol;
                  };
               }

               SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_SYMBOLS,false,false));
               continue;
            }

            //--- Charts
            if(msg.chat.getM_state()==3)
            {

               StringToUpper(text);
       string symbol=text;
               if(SymbolSelect(symbol,true))
               {
                  m_symbol=symbol;

                  chat.setM_state(31);
          msgs=(m_lang==ENGLISH)?"Select a timeframe like 'H1'":"Введите период графика, например 'H1'";
                  SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_PERIODS,false,false));
               }
               else
               {
                 mask=(m_lang==LANGUAGE_EN)?"Invalid symbol name '%s'":"Инструмент '%s' не найден";
            msgs=StringFormat(mask,text);
                  SendMessage(InpChatID,msgs,ReplyKeyboardMarkup(KEYB_SYMBOLS,false,false));
               }
               continue;
            }

            //Charts->Periods
            if(msg.chat.getM_state()==31)
            {
               bool found=false;
               int total=ArraySize(_periods);
               for(int k=0; k<total; k++)
               {
                  string str_tf=StringSubstr(EnumToString(_periods[k]),7);
                  if(StringCompare(str_tf,text,false)==0)
                  {
                     m_period=_periods[k];
                     found=true;
                     break;
                  }
               }

               if(found)
               {
                  //--- template
               msg. chat.setM_state(32);
                  string str="[[\""+EMOJI_BACK+"\",\""+EMOJI_TOP+"\"]";
                  str+=",[\"None\"]";
                  for(int k=0; k<m_templates.Total(); k++)
                     str+=",[\""+m_templates.At(k)+"\"]";
                  str+="]";

                  SendMessage(InpChatID,(m_lang==LANGUAGE_EN)?"Select a template":"Выберите шаблон",ReplyKeyboardMarkup(str,false,false));
               }
               else
               {
                  SendMessage(InpChatID,(m_lang==LANGUAGE_RU)?"Invalid timeframe":"Неправильно задан период графика",ReplyKeyboardMarkup(KEYB_PERIODS,false,false));
               }
               continue;
            }
            //---
            if(msg.chat.getM_state()==32)
            {
               m_template=text;
               if(m_template=="None")
                  m_template=NULL;
               int result=(int)SendScreenShot(m_symbol ,m_period,m_template, SendScreenshot);
               if(result!=0)
                  Print(GetErrorDescription(result,InpLanguage));
            }
      }
      
      //---
      return ;
   }

   //+------------------------------------------------------------------+
   int               SendPhotoToChat( long   _chat_id,
                               const string _photo_id,
                               const string _caption=NULL)
   {
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

      
      string url=StringFormat("%s/bot%s/sendPhoto",TELEGRAM_BASE_URL,m_token);
      string params=StringFormat("chat_id=%lld&photo=%s",_chat_id,_photo_id);
      if(_caption!=NULL)
         params+="&caption="+UrlEncode(_caption);

      int res=PostRequest(out,url,params,WEB_TIMEOUT);
      if(res!=0)
      { CJAVal   item,js(NULL,out);
         //--- parse result
        
         bool done=js.Deserialize(out);
         if(!done)
            return(ERR_JSON_PARSING);

         //--- get error description
         bool ok=js["ok"].ToBool();
         long err_code=js["error_code"].ToInt();
         string err_desc=js["description"].ToStr();
      }
      //--- done
      return(res);
   }


   //+------------------------------------------------------------------+
   int               SendMessageToChannel(const string _channel_name,
                                 const string _text,
                                 const bool   _as_HTML=false,
                                 const bool   _silently=false)
   {
      //--- check token
      if(m_token==NULL)
         return(ERR_TOKEN_ISEMPTY);

      string name=StringTrim(_channel_name);
      if(StringGetCharacter(name,0)!='@')
         name="@"+name;
      string url=StringFormat("%s/bot%s/sendMessage",TELEGRAM_BASE_URL,m_token);
      string params=StringFormat("chat_id=%s&text=%s",name,UrlEncode(_text));
      if(_as_HTML)
         params+="&parse_mode=HTML";
      if(_silently)
         params+="&disable_notification=true";
      //      Print(params);
      int res=PostRequest(out,url,params,WEB_TIMEOUT);
      return(res);
   }


 
 
 
public:
   //+------------------------------------------------------------------+
   void             Bot()
   {
      m_token=NULL;
      m_name=NULL;
      m_update_id=0;
      m_first_remove=true;
      m_chats.Clear();
      m_users_filter.Clear();
   }

   //+------------------------------------------------------------------+
   int               SendScreenShot(
                                    const string _symbol,
                                    const ENUM_TIMEFRAMES _period,
                                    const string _template=NULL,bool SendScreenShots=false)
   {
             
      long chart_id=ChartOpen(_symbol,_period);
      if(chart_id==0)
         return(ERR_CHART_NOT_FOUND);

      ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,true);

      //--- updates chart
      int wait=30;
      while(--wait>0)
      {
         if(SeriesInfoInteger(_symbol,_period,SERIES_SYNCHRONIZED))
            break;
         Sleep(30);
      }

      if(_template!=NULL)
         if(!ChartApplyTemplate(chart_id,_template))
            PrintError(_LastError,InpLanguage);

      ChartRedraw(chart_id);
      Sleep(500);

      ChartSetInteger(chart_id,CHART_SHOW_GRID,false);

      ChartSetInteger(chart_id,CHART_SHOW_PERIOD_SEP,false);

      string filename=StringFormat("%s%d.gif",_symbol,_period);

      if(FileIsExist(filename))
         FileDelete(filename);
      ChartRedraw(chart_id);

      Sleep(100);
int result=0;
      if(ChartScreenShot(chart_id,filename,ChartWidth,ChartHigth,ALIGN_RIGHT))
      {
         
         Sleep(200);
         
         //--- Need for MT4 on weekends !!!
         ChartRedraw(chart_id);
         
      SendChatAction(InpChatID,ACTION_UPLOAD_PHOTO);

         //--- waitng 30 sec for save screenshot
         wait=30;
         while(!FileIsExist(filename) && --wait>0)
            Sleep(30);

         //---
         if(FileIsExist(filename)){
          string screen_id;
              if(InpToChannel==true)result=SendPhotoToChannel(screen_id,InpChannel,filename,_symbol+"_@SIGNAL \n"+"\nTimeFrame " +(string)_period);
              if( InpTochat==true) result= SendPhotoToChat(InpChatID2,filename,_symbol+"_@ SIGNAL  \n"+"\nTimeFrame "+(string)_period);

         }
         else
         {
            string mask=m_lang==ENGLISH?"Screenshot file '%s' not created.":"Файл скриншота '%s' не создан.";
            PrintFormat(mask,filename);
         }
      }

      ChartClose(chart_id);
      
      
      return(result);
   }

               
                    
                    
    
        
   

  
 
    //+------------------------------------------------------------------+
  public: int Templates(const string _list)
   {
      m_templates.Clear();
      //--- parsing
      string text=StringTrim(_list);
      if(text=="")
         return(0);

      //---
      while(StringReplace(text,"  "," ")>0);
      StringReplace(text,";"," ");
      StringReplace(text,","," ");

      //---
      string array[];
      int amount=StringSplit(text,' ',array);
      amount=fmin(amount,5);

      for(int i=0; i<amount; i++)
      {
         array[i]=StringTrim(array[i]);
         if(array[i]!="")
            m_templates.Add(array[i]);
      }

      return(amount);
      
   }

        
 ;

//|-----------------------------------------------------------------------------------------|
//|                                O R D E R S   S T A T U S                                |
//|-----------------------------------------------------------------------------------------|

string BotOrdersTotal(bool noPending=true)
{
   int count=0;
   int total=OrdersTotal();
//--- Assert optimize function by checking total > 0
   if( total<=0 ) return( strBotInt("Total", count) );   
//--- Assert optimize function by checking noPending = false
   if( noPending==false ) return( strBotInt("Total", total) );
   
//--- Assert determine count of all trades that are opened
   for(int i=0;i<total;i++) {
      int go=OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
   //--- Assert OrderType is either BUY or SELL
      if( OrderType() <= 1 ) count ++;
   }
   return( strBotInt( "Total", count ) );
}

string BotOrdersTrade(bool noPending=true)
{
   int ticket = -1;
   int count=0;

   const string strPartial="from #";
   int total=OrdersTotal();
//--- Assert optimize function by checking total > 0
   if( total<=0 ) return( message );   

//--- Assert determine count of all trades that are opened
   for(int i=total-1;i>--total;i--) {
      ticket=OrderSelect( i, SELECT_BY_POS, MODE_HISTORY );

   //--- Assert OrderType is either BUY or SELL if noPending=true
      if( noPending==true && OrderType() > 1 ) continue ;
      else count++;

      message = StringConcatenate(message, strBotInt( "Ticket",OrderTicket() ));
      message = StringConcatenate(message, strBotStr( "Symbol",OrderSymbol() ));
      message = StringConcatenate(message, strBotInt( "Type",OrderType() ));
      message = StringConcatenate(message, strBotDbl( "Lots",OrderLots(),2 ));
      message = StringConcatenate(message, strBotDbl( "OpenPrice",OrderOpenPrice(),5 ));
      message = StringConcatenate(message, strBotDbl( "CurPrice",OrderClosePrice(),5 ));
      message= StringConcatenate(message, strBotDbl( "StopLoss",OrderStopLoss(),5 ));
      message = StringConcatenate(message, strBotDbl( "TakeProfit",OrderTakeProfit(),5 ));
      message= StringConcatenate(message, strBotTme( "OpenTime",OrderOpenTime() ));
      message = StringConcatenate(message, strBotTme( "CloseTime",OrderCloseTime() ));
      
   //--- Assert Partial Trade has comment="from #<historyTicket>"
      if( StringFind( OrderComment(), strPartial )>=0 )
         message = StringConcatenate(message, strBotStr( "PrevTicket", StringSubstr(OrderComment(),StringLen(strPartial)) ));
      else
         message= StringConcatenate(message, strBotStr( "PrevTicket", "0" ));
   }
//--- Assert msg isnt empty
   if( message=="" ) return( message );   
   
//--- Assert append count of trades
   message = StringConcatenate(strBotInt( "Count",count ), message);
   return( message);
}

string BotOrdersTicket(int tickets, bool noPending=true)
{string gh;

for(int a=OrdersHistoryTotal()-1;a>0;a--){

if(OrderSelect(a,SELECT_BY_POS,MODE_HISTORY)){
 gh=(string)"Ticket: "+(string)OrderTicket()+"  "+ "DATE"+(string) TimeCurrent();
}


};


   return( gh );
}

string BotHistoryTicket(int tickets, bool noPending=true)
{
  
   const string strPartial="from #";
   int total=OrdersHistoryTotal();
//--- Assert optimize function by checking total > 0
   if( total<=0 ) return( message );   

//--- Assert determine history by ticket
   if( OrderSelect( tickets, SELECT_BY_TICKET, MODE_HISTORY )==false ) return( message );
  
//--- Assert OrderType is either BUY or SELL if noPending=true
   if( noPending==true && OrderType() >=0 ) return( message);
      
//--- Assert OrderTicket is found

   message+= (string)StringConcatenate(message, strBotStr( "Date",(string)TimeCurrent() ));
   message +=  (string)StringConcatenate(message, strBotInt( "Ticket",OrderTicket() ));
   message +=  (string)StringConcatenate(message, strBotStr( "Symbol",OrderSymbol() ));
   message+=  (string)StringConcatenate(message, strBotInt( "Type",OrderType() ));
   message+=  (string)StringConcatenate(message, strBotDbl( "Lots",OrderLots(),2 ));
   message+=  (string)StringConcatenate(message, strBotDbl( "OpenPrice",OrderOpenPrice(),5 ));
   message+=  (string)StringConcatenate(message, strBotDbl( "ClosePrice",OrderClosePrice(),5 ));
   message+=  (string)StringConcatenate(message, strBotDbl( "StopLoss",OrderStopLoss(),5 ));
   message+= (string) StringConcatenate(message, strBotDbl( "TakeProfit",OrderTakeProfit(),5 ));
   message+=  (string)StringConcatenate(message, strBotTme( "OpenTime",OrderOpenTime() ));
   message += (string) StringConcatenate(message, strBotTme( "CloseTime",OrderCloseTime() ));
   
//--- Assert Partial Trade has comment="from #<historyTicket>"
   if( StringFind( OrderComment(), strPartial )>=0 )
      message += StringConcatenate(message, strBotStr( "PrevTicket", StringSubstr(OrderComment(),StringLen(strPartial)) ));
   else
      message+= StringConcatenate(message, strBotStr( "PrevTicket", "0" ));
      
   return( message);
}

string BotOrdersHistoryTotal(bool noPending=true)
{
   return( strBotInt( "Total", OrdersHistoryTotal() ) );
}


string tradeReport(bool noPending=true){
string  report="None";
for(int j=OrdersHistoryTotal()-1;j>0;j--){
if(OrderSelect(j,SELECT_BY_TICKET,MODE_HISTORY )==false){
if(OrderProfit()>0){
report+="Total Profit : "+ (string)OrderProfit()+ "  "+(string)TimeCurrent() ;


};
if(OrderProfit()<0){
report+="Total Losses: "+ (string)OrderProfit()+"  "+(string)TimeCurrent();


};

};

}

return report;
}

//|-----------------------------------------------------------------------------------------|
//|                               A C C O U N T   S T A T U S                               |
//|-----------------------------------------------------------------------------------------|
string BotAccount(void) 
{


   message= StringConcatenate(message, strBotInt( "Number",AccountNumber() ));
   message = StringConcatenate(message, strBotStr( "Currency",AccountCurrency() ));
   message = StringConcatenate(message, strBotDbl( "Balance",AccountBalance(),2 ));
   message = StringConcatenate(message, strBotDbl( "Equity",AccountEquity(),2 ));
   message = StringConcatenate(message, strBotDbl( "Margin",AccountMargin(),2 ));
   message = StringConcatenate(message, strBotDbl( "FreeMargin",AccountFreeMargin(),2 ));
   message= StringConcatenate(message, strBotDbl( "Profit",AccountProfit(),2 ));
   
   return( message );
}


//|-----------------------------------------------------------------------------------------|
//|                           I N T E R N A L   F U N C T I O N S                           |
//|-----------------------------------------------------------------------------------------|
string strBotInt(string key, int val)
{
   return( StringConcatenate(NL,key,"=",val) );
}
string strBotDbl(string key, double val, int dgt=5)
{
   return( StringConcatenate(NL,key,"=",NormalizeDouble(val,dgt)) );
}
string strBotTme(string key, datetime val)
{
   return( StringConcatenate(NL,key,"=",TimeToString(val)) );
}
string strBotStr(string key, string val)
{
   return( StringConcatenate(NL,key,"=",val) );
}
string strBotBln(string key, bool val)
{
   string valType;
   if( val )   valType="true";
   else        valType="false";
   return StringConcatenate(NL,key,"=",valType) ;
}  


string out;
     
       
bool ChartColorSet()//set chart colors
  {
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,BearCandle);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,BullCandle);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,Bear_Outline);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,Bull_Outline);
   ChartSetInteger(ChartID(),CHART_SHOW_GRID,0);
   ChartSetInteger(ChartID(),CHART_SHOW_PERIOD_SEP,false);
   ChartSetInteger(ChartID(),CHART_MODE,1);
   ChartSetInteger(ChartID(),CHART_SHIFT,1);
   ChartSetInteger(ChartID(),CHART_SHOW_ASK_LINE,1);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,BackGround);
   ChartSetInteger(ChartID(),CHART_COLOR_FOREGROUND,ForeGround);
   return(true);
   }  
   
   
         void   Language(const ENUM_LANGUAGES _lang)
   {
      m_lang=_lang;
   }
   
  
         
   
   
 
 
    }
    
  
    ;
 

int NomNews=100; 