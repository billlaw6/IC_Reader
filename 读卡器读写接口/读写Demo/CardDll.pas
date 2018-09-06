unit CardDll;

interface

//const  InterfaceDll = '.\DLL\BY_interface.Dll'; //���õĶ�̬���ӿ�
const  InterfaceDll = '.\BY_interface.Dll'; //���õĶ�̬���ӿ�

Function iDOpenPort(iReaderPort: integer): Integer;	stdcall;
{ ����    ���򿪶˿�
  ��ڲ�����
            iReaderPort:  �˿ں�    0 Usb�˿ڡ�1��4��Com1-Com4�˿�
            iReaderType : �����0����CPU��
  ����ֵ  ���˿ھ��ֵ;
            < 0 ʧ��
  ��ע    ��
}

Function iDClosePort(hReaderHandle: Integer	): Integer	; stdcall;
{ ����    ���رն˿�
  ��ڲ�����
            hReaderHandle:  �˿ھ����
  ����ֵ  ��0���ɹ�;����0��ʧ��
  ��ע    ��
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
{�� �ܣ�����

�� ����hReaderHandle��ͨѶ�豸��ʶ��

       unsigned int _Msec������ʱ�䣬��λ��10����

�� �أ��ɹ��򷵻� 0
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
