#ifndef __BY_INTERFACE_H__
#define __BY_INTERFACE_H__

__declspec( dllexport) int __stdcall iDOpenPort(int port);
__declspec( dllexport) int __stdcall iDClosePort(int Handle);
__declspec( dllexport) int __stdcall CheckCardType(int Handle,int* CardType,char * CardSN);
__declspec( dllexport) int __stdcall WriteBaseInfo(int Handle, int Lenth,char * BaseInfo);
__declspec( dllexport) int __stdcall ReadBaseInfo (int Handle, int Lenth,char * BaseInfo);
__declspec( dllexport) int __stdcall WriteBaseInfoVar(int Handle, char* Parient_id,char* Patient_name,char* Gender,char* Birthday,char* Charge_type,char* Response_type,char* BMI_NO  );
__declspec( dllexport) int __stdcall ReadBaseInfoVar (int Handle,char* Parient_id,char* Patient_name,char* Gender,char* Birthday,char* Charge_type,char* Response_type,char* BMI_NO  );
__declspec( dllexport) int __stdcall ReadEmployeeNO(int Handle, char * EmployeeNO);
__declspec( dllexport) int __stdcall ReadEmployeeInfoVar(int Handle,char* CardType,char* ID_Type,char* ID_NO,char* Name,char* Sex,char* InvalidDate,char* SchoolCode,char* PID,char* AppVer,char* EmployeeNO);
__declspec( dllexport) int __stdcall ReadEmployeeInfo (int Handle, int Lenth,char * BaseInfo);
__declspec( dllexport) int __stdcall IDBeep(int Handle, unsigned short Msec );
#endif