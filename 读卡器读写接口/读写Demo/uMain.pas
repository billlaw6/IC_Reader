unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    btnOpenPort: TButton;
    btnClosePort: TButton;
    btnGetSN: TButton;
    Button4: TButton;
    Button5: TButton;
    edtInfo: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtReadInfoLen: TEdit;
    lbCardNO: TLabel;
    btnBeep: TButton;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtCardType: TEdit;
    edtIDType: TEdit;
    edtIDNO: TEdit;
    edtName: TEdit;
    edtSex: TEdit;
    edtInvalidDate: TEdit;
    edtSchoolCode: TEdit;
    Label17: TLabel;
    edtPID: TEdit;
    Label18: TLabel;
    edtAppVer: TEdit;
    lbEmployeeNO: TLabel;
    edtEmployeeNO: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtParient_id: TEdit;
    edtPatient_name: TEdit;
    edtGender: TEdit;
    edtBirthday: TEdit;
    edtCharge_type: TEdit;
    edtResponse_type: TEdit;
    edtBMI_NO: TEdit;
    Button11: TButton;
    Button6: TButton;
    Button7: TButton;
    Button9: TButton;
    Button10: TButton;
    procedure btnOpenPortClick(Sender: TObject);
    procedure btnClosePortClick(Sender: TObject);
    procedure btnGetSNClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure edtReadInfoLenKeyPress(Sender: TObject; var Key: Char);
    procedure btnBeepClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
    PortHandle: integer;      
    function GetSN(Var SN: String; Var CardType: integer): integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses CardDll, Global;

{$R *.dfm}

procedure TForm1.btnOpenPortClick(Sender: TObject);
begin
  PortHandle := iDOpenPort(100);
  if PortHandle > 0 then
  begin
    Success('打开端口成功');
  end
  else
  begin
    Error('错误，返回值: '+ inttostr(PortHandle));
  end;
end;

procedure TForm1.btnClosePortClick(Sender: TObject);
var
  iRet: integer;
begin
  iRet := iDClosePort(PortHandle);
  if iRet = 0 then
  begin
    Success('关闭端口成功');
  end
  else
  begin
    Error('错误，返回值: '+ inttostr(iRet));
  end;
end;

procedure TForm1.btnGetSNClick(Sender: TObject);
var
  iRet: integer;

  iCardType: integer;
  SN: String;
begin
  lbCardNO.Caption := '卡号';
  iRet := GetSN(SN, iCardType);
  if iRet = 0 then
  begin
    lbCardNO.Caption := '卡号 ' + SN + '卡类型:' + inttostr(iCardType);
  end
  else
  begin
    Error('错误，返回值: '+ inttostr(iRet));
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i, iRet: integer;
  cInfo: Array[0..255] of Char;
  sSN: String;
  iCardType: integer;
begin
  edtInfo.Clear;
  if edtReadInfoLen.Text = '' then
  begin
    Error('请输入读信息流的长度');
    edtReadInfoLen.SetFocus;
    exit;
  end;
  for i := 0 to 62 do
  begin
    cInfo[i] := #0;
  end;
  iRet := GetSN(sSN, iCardType);
  if iRet = 0 then
  begin
    if iCardType <> 1  then
    begin
      Error('该卡不是就医卡!');
      exit;
    end;
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
  iRet := ReadBaseInfo(PortHandle, strtoint(edtReadInfoLen.Text), @cInfo);
  if iRet = 0 then
  begin
    for i := 0 to strtoint(edtReadInfoLen.Text) - 1 do
    begin
      edtInfo.Text := edtInfo.Text + cInfo[i];
    end;          
  end
  else
  begin
    Error('错误, 返回值:' + inttostr(iRet));
  end;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i, iRet: integer;
  sSN: String;
  iCardType: integer;
begin
  iRet := GetSN(sSN, iCardType);
  if iRet = 0 then
  begin
    if iCardType <> 1  then
    begin
      Error('该卡不是就医卡!');
      exit;
    end;
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
  iRet := WriteBaseInfo(PortHandle, length(edtInfo.Text), edtInfo.Text);
  if iRet = 0 then
  begin
    Success('写信息成功');
  end
  else
  begin
    Error('错误, 返回值:' + inttostr(iRet));
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  iRet: integer;
  Parient_id,
  Patient_name,
  Gender,
  Birthday,
  Charge_type,
  Response_type,
  BMI_NO: String;
  sSN: String;
  iCardType: integer;
begin
  Parient_id := edtParient_id.Text;
  Patient_name := edtPatient_name.Text;
  Gender := edtGender.Text;
  Birthday := edtBirthday.Text;
  Charge_type := edtCharge_type.Text;
  Response_type := edtResponse_type.Text;
  BMI_NO := edtBMI_NO.Text;
  iRet := GetSN(sSN, iCardType);
  if iRet = 0 then
  begin
    if iCardType <> 1  then
    begin
      Error('该卡不是就医卡!');
      exit;
    end;
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
  iRet := WriteBaseInfoVar(PortHandle,
                            Parient_id,
                            Patient_name,
                            Gender,
                            Birthday,
                            Charge_type,
                            Response_type,
                            BMI_NO);
  if iRet = 0 then
  begin
    Success('写信息成功');
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  iRet: integer;
  Parient_id,
  Patient_name,
  Gender,
  Birthday,
  Charge_type,
  Response_type,
  BMI_NO: Array[0..64] of Char;
  sSN: String;
  iCardType: integer;
begin
  edtParient_id.Clear;
  edtPatient_name.Clear;
  edtGender.Clear;
  edtBirthday.Clear;
  edtCharge_type.Clear;
  edtResponse_type.Clear;
  edtBMI_NO.Clear;
  edtParient_id.Refresh;
  edtPatient_name.Refresh;
  edtGender.Refresh;
  edtBirthday.Refresh;
  edtCharge_type.Refresh;
  edtResponse_type.Refresh;
  edtBMI_NO.Refresh;
  iRet := GetSN(sSN, iCardType);
  if iRet = 0 then
  begin
    if iCardType <> 1  then
    begin
      Error('该卡不是就医卡!');
      exit;
    end;
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
    exit;
  end;
  iRet := ReadBaseInfoVar(PortHandle,
                            Parient_id,
                            Patient_name,
                            Gender,
                            Birthday,
                            Charge_type,
                            Response_type,
                            BMI_NO);

  if iRet = 0 then
  begin
    edtParient_id.Text := String(Parient_id);
    edtPatient_name.Text := String(Patient_name);
    edtGender.Text := String(Gender);
    edtBirthday.Text := String(Birthday);
    edtCharge_type.Text := String(Charge_type);
    edtResponse_type.Text := String(Response_type);
    edtBMI_NO.Text := String(BMI_NO);
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
end;

procedure TForm1.edtReadInfoLenKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key > '9') or (Key < '0') then
  begin
    Key := #0;
  end;
end;

procedure TForm1.btnBeepClick(Sender: TObject);
begin
  IDBeep(PortHandle,100);
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  i, iRet: integer;
  cEmployeeNO: Array[0..30] of Char;
  sSN: String;
  iCardType: integer;
begin
  edtEmployeeNO.Clear;
  edtEmployeeNO.Refresh;
  for i := 0 to 30 do
  begin
    cEmployeeNo[i] := #0;
  end;
  iRet := GetSN(sSN, iCardType);
  if iRet = 0 then
  begin
    if iCardType <> 2  then
    begin
      Error('该卡不是交通卡!');
      exit;
    end;
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
  iRet := ReadEmployeeNO(PortHandle, @cEmployeeNO);
  if iRet = 0 then
  begin
    edtEmployeeNO.Text := String(cEmployeeNO);
  end
  else
  begin
    Error('错误，返回值: '+ inttostr(iRet));
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  iRet: integer;
  CardType,
  ID_Type,
  ID_NO,
  Name,
  Sex,
  InvalidDate,
  SchoolCode,
  PID,
  AppVer,
  EmployeeNO: Array[0..64] of Char;
  sSN: String;
  iCardType: integer;
begin
  edtCardType.Clear;
  edtIDType.Clear;
  edtIDNO.Clear;
  edtName.Clear;
  edtSex.Clear;
  edtInvalidDate.Clear;
  edtSchoolCode.Clear;
  edtPID.Clear;
  edtAppVer.Clear;
  edtEmployeeNO.Clear;
  edtCardType.Refresh;
  edtIDType.Refresh;
  edtIDNO.Refresh;
  edtName.Refresh;
  edtSex.Refresh;
  edtInvalidDate.Refresh;
  edtSchoolCode.Refresh;
  edtPID.Refresh;
  edtAppVer.Refresh;
  edtEmployeeNO.Refresh;
  iRet := GetSN(sSN, iCardType);
  if iRet = 0 then
  begin
    if iCardType <> 2  then
    begin
      Error('该卡不是交通卡!');
      exit;
    end;
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
  iRet := ReadEmployeeInfoVar(PortHandle,
                              CardType,
                              ID_Type,
                              ID_NO,
                              Name,
                              Sex,
                              InvalidDate,
                              SchoolCode,
                              PID,
                              AppVer,
                              EmployeeNO);

  if iRet = 0 then
  begin
    edtCardType.Text := String(CardType);
    edtIDType.Text := String(ID_Type);
    edtIDNO.Text := String(ID_NO);
    edtName.Text := String(Name);
    edtSex.Text := String(Sex);
    edtInvalidDate.Text := String(InvalidDate);
    edtSchoolCode.Text := String(SchoolCode);
    edtPID.Text := String(PID);
    edtAppVer.Text := String(AppVer);
    edtEmployeeNO.Text := String(EmployeeNO);
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  i, iRet: integer;   
  cInfo: Array[0..255] of Char;
  sSN: String;
  iCardType: integer;
begin
  edtInfo.Clear;
  if edtReadInfoLen.Text = '' then
  begin
    Error('请输入读信息流的长度');
    edtReadInfoLen.SetFocus;
    exit;
  end;
  for i := 0 to 62 do
  begin
    cInfo[i] := #0;
  end;
  iRet := GetSN(sSN, iCardType);
  if iRet = 0 then
  begin
    if iCardType <> 2  then
    begin
      Error('该卡不是交通卡!');
      exit;
    end;
  end
  else
  begin
    Error('错误，错误返回值：' + inttostr(iRet));
  end;
  iRet := ReadEmployeeInfo(PortHandle, strtoint(edtReadInfoLen.Text), @cInfo);
  if iRet = 0 then
  begin
    for i := 0 to strtoint(edtReadInfoLen.Text) - 1 do
    begin
      edtInfo.Text := edtInfo.Text + cInfo[i];
    end;          
  end
  else
  begin
    Error('错误, 返回值:' + inttostr(iRet));
  end;

end;

function TForm1.GetSN(Var SN: String; Var CardType: integer): integer;
var
  iRet: integer;
  cSN: array[0..20] of char;
  iCardType: integer;
begin
  fillchar(cSN,sizeof(cSN), #0);
  lbCardNO.Caption := '卡号';
  iRet := CheckCardType(PortHandle, @iCardType, @cSN);
  if iRet = 0 then
  begin
    SN := String(cSN);
    CardType := iCardType;
  end;
  result := iRet;
end;

end.
