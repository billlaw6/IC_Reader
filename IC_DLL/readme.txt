dll�ļ���:
Win32��:RFCard.dll ; Java ��:javaRFCard.dll;


2009-08-06 lzy
����������Ϣ�ĺ���RFCard_ReadCardInfoEx�� �ú��������ض˿ںż�����ID,NAME���й���Ϣ��
Function RFCard_ReadCardInfoEx(var PortNo:integer;Patient_id,Patient_name,Gender,Birthday,Charge_type,Response_type,ABMI_NO,ErrorMsg:PChar):boolean;    StdCall;
  

2009-07-28  lzy
  �޸ģ����Ӷ��USB�˿���ѭ�����Ĺ��ܡ�USB�˿�������RTTOKBD.INI�С�
        RFTOKBD.INI�ļ� [RFTOKBD] ����PortFrom��ProtTo����ѡ��
  �����򿪶˿ڵĺ�����BY_RFCard_OpenPort����ǰ��������dll��ʱ���ڲ��򿪶˿ڡ����ڽ��˺�������������ֻҪ��һ���˿ڴ򿪳ɹ��ͷ���True�����еĶ˿ڶ���ʧ�ܣ��򷵻�False�������Ĵ�����Ϣ�а����������˿ڳ������Ϣ��ʾ��

����ԭ�����£�
Function BY_RFCard_OpenPort(ErrorMsg:PChar) :boolean;



========================================================================================
�õ��������ļ�:
RFTOKBD.INI

[RFTOKBD]
//CHIS AppServer ���ƻ��ַ.Ĭ��Ϊ��(����)
AppServer=
//��ѭ����ʼ�˿ں�
PortFrom = 100
//��ѭ�Ľ����˿ں�
PortTo = 103


�õ���Ӳ�����������ļ�
BY_Interface.dll
dcrf32.dll
DesAlgo.dll



----win32 API����˵��
//dll���뺯��. ErrorMsg[0..1023]�ַ���.����������ErrorMsg�а���������Ϣ.
Function BY_RFCard_LoadLib(ErrorMsg:PChar): boolean; StdCall;
//�ͷ�
procedure BY_RFCard_ReleaseLib;   StdCall;

//���ؿ���,12λ .  ErrorMsg[0..1023]�ַ���.����������ErrorMsg�а���������Ϣ.
Function RFCard_GetCardNo(CardNo,ErrorMsg: PChar;):boolean;  StdCall;

//���ؿ�����Ϣ, ����65���ֽڡ�  :APatient_id,Patient_name,Gender,Birthday...
Birthday�ĸ�ʽ����:2007-01-01

 ErrorMsg[0..1023]�ַ���.����������ErrorMsg�а���������Ϣ.
Function RFCard_ReadCardInfo(Patient_id,Patient_name,Gender,Birthday,Charge_type,Response_type,ABMI_NO,ErrorMsg:PChar):boolean;    StdCall;


----java�溯��˵��
//dll���뺯��
Function Java_Tris_Pku_RFCardLoadLib(PEnv: PJNIEnv; Obj: JObject): boolean; StdCall;
//�ͷ�
procedure Java_Tris_Pku_RFCardReleaseLib(PEnv: PJNIEnv; Obj: JObject);   StdCall;

//���ؿ���,12λ 
Function Java_Tris_Pku_RFCardGetCardNo(PEnv: PJNIEnv; Obj: JObject;CardNo: PChar):boolean;  StdCall;

//���ؿ�����Ϣ, ����65���ֽڡ�  :APatient_id:
Function Java_Tris_Pku_RFCardReadCardInfo(PEnv: PJNIEnv; Obj: JObject;):Jstring;    StdCall;

sP_ID+'|'+sPName+'|'+sSex+'|'+sBirthday+'|'+sChgType+'|'+sResType+'|'+sYBNo+'|'





 