dll文件名:
Win32版:RFCard.dll ; Java 版:javaRFCard.dll;


2009-08-06 lzy
新增读卡信息的函数RFCard_ReadCardInfoEx， 该函数将返回端口号及病人ID,NAME等有关信息。
Function RFCard_ReadCardInfoEx(var PortNo:integer;Patient_id,Patient_name,Gender,Birthday,Charge_type,Response_type,ABMI_NO,ErrorMsg:PChar):boolean;    StdCall;
  

2009-07-28  lzy
  修改：增加多个USB端口轮循读卡的功能。USB端口设置在RTTOKBD.INI中。
        RFTOKBD.INI文件 [RFTOKBD] 增加PortFrom，ProtTo两个选项
  新增打开端口的函数：BY_RFCard_OpenPort。以前是在载入dll的时候内部打开端口。现在将此函数公布出来。只要有一个端口打开成功就返回True，所有的端口都打开失败，则返回False。传出的错误信息中包含有其它端口出错的信息提示。

函数原型如下：
Function BY_RFCard_OpenPort(ErrorMsg:PChar) :boolean;



========================================================================================
用到的配置文件:
RFTOKBD.INI

[RFTOKBD]
//CHIS AppServer 名称或地址.默认为空(本机)
AppServer=
//轮循的起始端口号
PortFrom = 100
//轮循的结束端口号
PortTo = 103


用到的硬件驱动程序文件
BY_Interface.dll
dcrf32.dll
DesAlgo.dll



----win32 API函数说明
//dll载入函数. ErrorMsg[0..1023]字符型.如果出错参数ErrorMsg中包含出错信息.
Function BY_RFCard_LoadLib(ErrorMsg:PChar): boolean; StdCall;
//释放
procedure BY_RFCard_ReleaseLib;   StdCall;

//返回卡号,12位 .  ErrorMsg[0..1023]字符型.如果出错参数ErrorMsg中包含出错信息.
Function RFCard_GetCardNo(CardNo,ErrorMsg: PChar;):boolean;  StdCall;

//返回卡的信息, 长度65个字节。  :APatient_id,Patient_name,Gender,Birthday...
Birthday的格式如下:2007-01-01

 ErrorMsg[0..1023]字符型.如果出错参数ErrorMsg中包含出错信息.
Function RFCard_ReadCardInfo(Patient_id,Patient_name,Gender,Birthday,Charge_type,Response_type,ABMI_NO,ErrorMsg:PChar):boolean;    StdCall;


----java版函数说明
//dll载入函数
Function Java_Tris_Pku_RFCardLoadLib(PEnv: PJNIEnv; Obj: JObject): boolean; StdCall;
//释放
procedure Java_Tris_Pku_RFCardReleaseLib(PEnv: PJNIEnv; Obj: JObject);   StdCall;

//返回卡号,12位 
Function Java_Tris_Pku_RFCardGetCardNo(PEnv: PJNIEnv; Obj: JObject;CardNo: PChar):boolean;  StdCall;

//返回卡的信息, 长度65个字节。  :APatient_id:
Function Java_Tris_Pku_RFCardReadCardInfo(PEnv: PJNIEnv; Obj: JObject;):Jstring;    StdCall;

sP_ID+'|'+sPName+'|'+sSex+'|'+sBirthday+'|'+sChgType+'|'+sResType+'|'+sYBNo+'|'





 