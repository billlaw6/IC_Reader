program BY;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  Global in 'Global.pas',
  CardDll in 'CardDll.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
