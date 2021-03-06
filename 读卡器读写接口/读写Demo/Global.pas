unit Global;

interface

uses
  Windows, Forms, Buttons, ComCtrls, SysUtils, Controls, StrUtils, StdCtrls, DateUtils, CardDll, DBClient,
  Messages;

Const
    FEnable: Boolean = true;
    FDisEnable: boolean = false;
    FNull = '';
    FZero = '0';

    //-----------------------------数据库表名-----------------------------------
    HHInfo                       = 'HHInfo';  //

    //-----------------------------表字段名--------------------------------------
    //HHInfo
    SHBZH                        = 'SHBZH';    //社会保障号
    GName                         = 'Name';    //姓名
    Sex                          = 'Sex';    //性别
    BirthDate                    = 'BirthDate';    //出生日期
    FirstEmployedTime            = 'FirstEmployedTime'; //首次参加工作日期
    UnitName                     = 'UnitName';//单位名称
    IDCardNum                    = 'IDCardNum';//卡号  

    //-----------------------------存储过程-----------------------------------
    SP_Get_HHInfo                = 'SP_Get_HHInfo'; //查找HCInfo表所有信息


    //  状态码
    State_None                     =0;    //当前无操作
    State_Read                     =1;    //当前操作为读卡
    State_Write                    =2;    //当前操作为写卡
    State_Browse                   =3;    //浏览状态

    //端口号
    //USBPort = 0;
    USBPort = 0;
    Com1Port = 1;
    Com2Port = 2;
    Com3Port = 3;
    Com4Port = 4;

    //卡类型
    MWCard = 5;  //明华读卡器
    YNDCard = 8; //毅能达读卡器

    //错误码
    res_READER_TYPE_WRONG = -4;  //读卡器类型无效
    ErrCNoCard = $6200; //(25088) 无卡
    res_NO_veifyPin = -14;     //未校验PIN
    res_ERR_OPEN_DEVICE =-17; //设备打开失败
    res_DeviceClose_ERROR = -11;     //读写器关闭错误
    ErrCRecordNotF = $6A83; //(27267) 记录未找到
    ErrCInvData = $6F00; //数据无效
    CheckPINFirst = $63C2;//第一次输入PIN值错误
    CheckPINSec = $63C1;//第二次输入PIN值错误
    CheckPINThird = $63C0;//第三次输入PIN值错误,PIN码被锁死
    ErrCNoPSAMCard =     -134;             //无PSAM卡
    ErrCKeyLock    =  	$6983; //(27011) 密钥被锁死
Var
  PortHandle: integer;   //串口句柄
  CurComPort: integer;   //串口号
  CurReaderType: integer;//读卡机类型
Function Error(Const Msg : Pchar;Const ErrorType: UINT = MB_OK+MB_ICONERROR):integer;Overload;
{
        功能    ：显示一个错误窗口
        入口参数：
                  Msg       : Pchar 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：可显示出一个自己定制的出错处理窗口
}
Function Error(Const ErrorID : integer;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;Overload;
{
        功能    ：显示一个错误窗口
        入口参数：
                  Msg       : String 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：同上
}
Function Error(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;Overload;
{
        功能    ：显示一个错误窗口
        入口参数：
                  Msg       : String 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：可显示出一个自己定制的出错处理窗口
}


Function Success(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONINFORMATION):integer;
{
        功能    ：显示一个成功窗口
        入口参数：
                  Msg       : String 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：可显示出一个自己定制的出错处理窗口
}

Procedure EnableAll(F: TForm);
//Enable ALL visual Edit or Combox in a Form
{
    功能    ： 设置全部的可见的Edit和Combobox中的可编辑性
    入口参数：
               F : 窗体变量，指示被清除的窗体
    返回值  ： 无
    备注    ： 无
}

Procedure DisEnableAll(F: TForm);
//Enable ALL visual Edit or Combox in a Form
{
    功能    ： 设置全部的可见的Edit和Combobox中的可编辑性
    入口参数：
               F : 窗体变量，指示被清除的窗体
    返回值  ： 无
    备注    ： 无
}

Procedure NumLimit(var Key: Char);
{功能 ：               //数字输入限制
   入口参数：   Key        :           接收的键值

   返回值：     无
   备注：                 无
}

Procedure NumDecimalLimit(var Key: Char);
{功能 ：               //数字小数点输入限制
   入口参数：   Key        :           接收的键值

   返回值：     无
   备注：                 无
}

Procedure IDCardNoLimit(var Key: Char);
{功能 ：               身份证号码输入限制
   入口参数：   Key   :      接收的键值

   返回值：     无

   备注：                 无
}
Procedure SimulateTab(var Key: Char);
{功能 ：               回车键模拟TAB键，下一对象获得焦点
   入口参数：   Key   :      接收的键值

   返回值：     无

   备注：                 无
}

Procedure ReadOnlySimulateTab(var Key: Char);
{功能 ：               回车键模拟TAB键，下一对象获得焦点,否则返回Key值为#0
   入口参数：   Key   :      接收的键值

   返回值：     无

   备注：                 无
}

function custrtoDate(strDate: String): TDateTime;
{功能 ：               自定义字符串转为日期函数
   入口参数：   strDate: 转换的字符串

   返回值：     转换后的日期

   备注：                 无


}
function cuDateToStr(dtDate: TDateTime): String;
function cuTimeToStr(dtTime: TDateTime): String;

function FillStrToLeftNull(str: String; FillStr: Char; sLength: Integer): String;
{功能 ：               左补齐字符串
   入口参数：   str: 要被被齐的字符串
                FillStr: 填充的字符
                sLength: 字符串的要求长度
   返回值：     无

   备注：                 无


}

function FillLeftStrToSender(Sender: TOBject): integer;

function GetMSecOfTimeLen(StartTime: TDateTime): Integer;

function ErrorType(ErrorValue: integer): String;




function ConverCharToStr(SChar: Array of Char): String;
implementation

Function Error(Const Msg : Pchar;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;
begin
    {$IFDEF APPLICATION_MAIN_RUN}
    Result:=Messagebox(Application.MainForm.Handle,MSG,'错误',ErrorType);
    {$ELSE}
    Result:=Application.MessageBox(MSG,'错误',ErrorType);
    {$ENDIF}
end;
//-----------------------------------------------------------------------
Function Error(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;Overload;
begin
    {$IFDEF APPLICATION_MAIN_RUN}
    Result:=Messagebox(Application.MainForm.Handle,Pchar(MSG),'错误',ErrorType);
    {$ELSE}
    Result:=Application.MessageBox(Pchar(MSG),'错误',ErrorType);
    {$ENDIF}
end;
//---------------------------------------------------------------------
Function Error(Const ErrorID : integer;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;
begin
   {case of}
   {$IFDEF APPLICATION_MAIN_RUN}
   Result:=Messagebox(application.MainForm.Handle,Pchar(inttostr(ErrorID)),'错误',ErrorType);
   {$ELSE}
   Result:=Messagebox(0,Pchar(inttostr(ErrorID)),'错误',ErrorType);
   {$ENDIF}
end;

Function Success(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONINFORMATION):integer;
begin
    Result:=Application.MessageBox(pchar(Msg),'消息',ErrorType);
end;

function DeleteWarning: Boolean;
begin
  Result := False;
  if application.MessageBox('该记录删除后将无法恢复，确定要删除吗？','警告',Mb_iconexclamation+mb_okCancel)=IDok then
  begin
    Result := True;
  end;
end;

Procedure DisEnableAll(F: TForm);
var
  i   : integer;
  str : String;
begin
  i:=F.ComponentCount-1 ;  //i: F中的控件总数
  while(i>0) do
  begin
    str:=F.Components[i].ClassName;   //各个控件的类名

    if (Uppercase(Rightstr(str,4))='EDIT') then            //如果类名为TEDIT
    begin
      if ((TCustomedit(F.Components[i]).Visible) and ((F.Components[i].Tag=999) or (F.Components[i].Tag=998))) then
      begin
        TCustomEdit(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,8))='COMBOBOX') then
    begin
      if ((TCustomCombobox(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomcombobox(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,4))='MEMO') then
    begin
      if ((TCustomMemo(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomMemo(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,6))='BUTTON') then
    begin
      if ((TSpeedButton(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,14))='DATETIMEPICKER') then
    begin
      if ((TDateTimePicker(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=False;
      end;
    end;

    dec(i);
  end;
end;
//-------------------------------------------------------
Procedure EnableAll(F : TForm);
var
  i: integer;
  str: String;
begin
  i := F.ComponentCount - 1 ;
  while(i>0) do
  begin
    str:=F.Components[i].ClassName;
    if (Uppercase(Rightstr(str,4))='EDIT') then
    begin
      if ((TCustomedit(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomEdit(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,8))='COMBOBOX') then
    begin
      if ((TCustomCombobox(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomcombobox(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,4))='MEMO') then
    begin
      if ((TCustomMemo(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomMemo(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,6))='BUTTON') then
    begin
      if ((TSpeedButton(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,14))='DATETIMEPICKER') then
    begin
      if ((TDateTimePicker(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=True;
      end;
    end;
    dec(i);
  end;
end;

Procedure NumLimit(var Key: Char);
Var
  Sender: TObject;
begin
  if (key <#48) or (key > #57) then
  begin
    if Key = #13 then
    begin
      key := #13;
      SimulateTab(Key);
    end
    else
    if Key = #8 then
    begin
      key := #8;
    end
    else
    key := #0;
  end;
end;

Procedure NumDecimalLimit(var Key: Char);
Var
  Sender: TObject;
begin
  if (key <#48) or (key > #57) then
  begin
    if key = '.' then
    begin
      key:='.';
    end
    else
    if Key = #8 then
    begin
      key := #8;
    end
    else
    if Key = #13 then
    begin
      key := #13;
      SimulateTab(Key);
    end
    else
    begin
      key := #0;
    end;
  end;
end;

Procedure IDCardNoLimit(var Key: Char);
Var
  Sender: TObject;
begin
  if (key <#48) or (key > #57) then
  begin
    if key = 'x' then
    begin
      key:='X';
    end
    else
    if Key = 'X' then
    begin
      key:='X';
    end
    else
    if Key = #8 then
    begin
      key := #8;
    end
    else
    if Key = #13 then
    begin
      key := #13;
      SimulateTab(Key);
    end
    else
    begin
      key := #0;
    end;
  end;
end;

Procedure SimulateTab(var Key: Char);
Var
  Sender: TObject;
begin
  if Key = #13 then
  begin
    PostMessage(TWinControl(Sender).Handle ,WM_KeyDown,VK_Tab,0);
  end;
end;

Procedure ReadOnlySimulateTab(var Key: Char);
Var
  Sender: TObject;
begin
  if Key = #13 then
  begin
    PostMessage(TWinControl(Sender).Handle ,WM_KeyDown,VK_Tab,0);
  end
  else
  begin
    Key := #0;
  end;
end;

function custrtoDate(strDate: String): TDateTime;
var
  sYear, sMonth, sDate: string;
begin
  if StrDate = '' then
  begin
    Result := Date();
    Exit;
  end;
  Try
    sYear := Leftstr(strDate, 4);
    sMonth := MidStr(strDate, 5, 2);
    sDate := RightStr(strDate, 2);
    Result := EncodeDate(strtoint(sYear), strtoint(sMonth), strtoint(sDate));
  Except
    Result := Date();
  end;
end;

function cuDateToStr(dtDate: TDateTime): String;
var
  iYear, iMonth: integer;
  sYear, sMonth: string;
  sDate: string;
begin
  iYear := Yearof(dtDate);
  iMonth := Monthof(dtDate);
  sYear := inttostr(iYear);
  sMonth := inttostr(iMonth);
  if length(inttostr(iMonth)) = 1 then
  begin
    sMonth := '0' + sMonth;
  end;
  sDate := RightStr(DateToStr(Dateof(dtDate)), 2);
  if LeftStr(sDate, 1) = '-' then
  begin
    sDate := RightStr(sDate, 1);
    sDate := '0' + sDate;
  end;
  Result := sYear + sMonth + sDate;
end;

function cuTimeToStr(dtTime: TDateTime): String;
var
  sHour,sMin, sSec: string;
  sTime: string;
begin
  sTime := TimeToStr(dtTime);
  sHour := LeftStr(sTime, 2);
  sMin := MidStr(sTime, 4, 2);
  sSec := RightStr(sTime, 2);
  Result := sHour + sMin + sSec;

end;

function FillStrToLeftNull(str: String; FillStr: Char; sLength: Integer): String;
var
  i: integer;
  sFillStr: String;
begin
  if sLength > Length(str) then
  begin
    for i := 1 to sLength - Length(str) do
    begin
      sFillStr := FillStr + sFillStr;
    end;
    Result := sFillStr + str;
  end
  else
  begin
    Result := str;
  end;
end;

function FillLeftStrToSender(Sender: TObject): integer;
var
  i: integer;
begin
  {if TEdit(Sender).MaxLength > Length(TCustomEdit(Sender).Text)) then
  begin
    for i := 1 to (TCustomer(Sender).MaxLength - Length(TCustomer(Sender).Text)) do
    begin
      sFillStr := FillStr + sFillStr;
    end;
    Result := sFillStr + str;
  end
  else
  begin
    Result := str;
  end;}

end;

function GetMSecOfTimeLen(StartTime: TDateTime): Integer;
//计算从开始到现在经过的毫秒时间数
var
  Hour,Minute,Second,MSec:Word;
begin
  DecodeTime(Date+Time-StartTime,Hour,Minute,Second,MSec);
  Result := MSec+(Second+(Minute+Hour*60)*60)*1000;
end;





Function mid_iRPenCollectDetail(iReaderHandle, iRecordId: integer;
    szNy,	            //缴费年月
		szGrjfe: String)				//当月个人缴费
    : integer;
var
  conver1,
  conver2
  : Array[0..255] of char;
begin

end;


Function mid_iWPenCollectDetail(iReaderHandle, iRecordId: integer;
    szNy,	            //缴费年月
		szGrjfe: String)				//当月个人缴费
    : integer;
begin

end;

function ErrorType(ErrorValue: integer): String;
begin
  Result := '';

  Case ErrorValue of
    res_READER_TYPE_WRONG: Result := ' 错误类型：读卡器类型无效!';
    res_NO_veifyPin: Result := ' 错误类型：未校验PIN!';
    res_DeviceClose_ERROR: Result := '错误类型： 设备关闭失败!';
    res_ERR_OPEN_DEVICE: Result := ' 错误类型： 设备打开失败!';
    ErrCNoCard: Result := ' 错误类型：无卡!';
    ErrCRecordNotF: Result := ' 错误类型：没有找到记录文件!';
    ErrCInvData: Result := ' 错误类型：数据无效!';
    CheckPINFirst: Result := ' 错误类型：第一次输入PIN值错误!';
    CheckPINSec: Result := ' 错误类型：第二次输入PIN值错误!';
    CheckPINThird: Result := ' 错误类型：第三次输入PIN值错误!';
    ErrCNoPSAMCard: Result := '错误类型：无PSAM卡';
    ErrCKeyLock: Result := '密钥被锁死';
  else
    Result := ' 错误类型：未知错误!'+ inttostr(ErrorValue);
  end;

end;    

function ConverCharToStr(SChar: Array of Char): String;
begin
  Result := String(Schar);
end;

end.
