unit CardDll;

interface

//const  InterfaceDll = '.\DLL\BY_interface.Dll'; //调用的动态链接库
const  InterfaceDll = '.\BY_interface.Dll'; //调用的动态链接库

Function iDOpenPort(iReaderPort: integer): Integer;	stdcall;
{ 功能    ：打开端口
  入口参数：
            iReaderPort:  端口号    0 Usb端口　1－4　Com1-Com4端口
            iReaderType : 卡类别　0　以CPU卡
  返回值  ：端口句柄值;
            < 0 失败
  备注    ：
}

Function iDClosePort(hReaderHandle: Integer	): Integer	; stdcall;
{ 功能    ：关闭端口
  入口参数：
            hReaderHandle:  端口句柄；
  返回值  ：0　成功;　＜0　失败
  备注    ：
}

Function CheckCardType(hReaderHandle: Integer; CardType : PInteger; CardSN : PChar): Integer	; stdcall;

Function ReadBaseInfo (hReaderHandle: Integer; Lenth: integer; BaseInfo: PChar): Integer	; stdcall;


Function WriteBaseInfo (hReaderHandle: Integer; Lenth: integer; BaseInfo: String): Integer	; stdcall;


Function WriteBaseInfoVar(hReaderHandle: Integer;
												   Parient_id,
												   Patient_name,
												   Gender,
												   Birthday,
												   Charge_type,
												   Response_type,
												   BMI_NO: String): Integer	; stdcall;


Function ReadBaseInfoVar(hReaderHandle: Integer;
												   Parient_id,
												   Patient_name,
												   Gender,
												   Birthday,
												   Charge_type,
												   Response_type,
												   BMI_NO: Pchar): Integer	; stdcall;


function ReadEmployeeInfoVar(hReaderHandle: Integer;
													  CardType,
													  ID_Type,
													  ID_NO,
													  Name,
													  Sex,
													  InvalidDate,
													  SchoolCode,
													  PID,
													  AppVer,
													  EmployeeNO
                            : PChar
													  ): integer; stdcall;

function IDBeep(hReaderHandle: Integer; MSec: Smallint): Integer	; stdcall;
{功 能：蜂鸣

参 数：hReaderHandle：通讯设备标识符

       unsigned int _Msec：蜂鸣时间，单位是10毫秒

返 回：成功则返回 0
}

function ReadEmployeeNO(hReaderHandle: Integer; EmployeeNO: PChar): integer; stdcall;


Function ReadEmployeeInfo (hReaderHandle: Integer; Lenth: integer; BaseInfo: PChar): Integer	; stdcall;

implementation

Function iDOpenPort; external InterfaceDll name 'iDOpenPort';
Function iDClosePort; external InterfaceDll name 'iDClosePort';
Function CheckCardType; external InterfaceDll name 'CheckCardType';
Function ReadBaseInfo; external InterfaceDll name 'ReadBaseInfo';
Function WriteBaseInfo; external InterfaceDll name 'WriteBaseInfo';
Function WriteBaseInfoVar; external InterfaceDll name 'WriteBaseInfoVar';
Function ReadBaseInfoVar; external InterfaceDll name 'ReadBaseInfoVar';
Function IDBeep; external InterfaceDll name 'IDBeep';
function ReadEmployeeNO; external InterfaceDll name 'ReadEmployeeNO';

Function ReadEmployeeInfo; external InterfaceDll name 'ReadEmployeeInfo';
function ReadEmployeeInfoVar; external InterfaceDll name 'ReadEmployeeInfoVar';

end.
