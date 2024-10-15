program Project1;

uses
  Vcl.Forms,
  PAT24 in 'PAT24.pas' {frmLogin},
  Vcl.Themes,
  Vcl.Styles,
  Unit1 in 'Unit1.pas' {frmSignUp},
  Unit2 in 'Unit2.pas' {Form2},
  Unit4 in 'Unit4.pas' {Form4},
  dmIsolytics in 'dmIsolytics.pas' {dmIsolytic: TDataModule},
  Admin in 'Admin.pas' {frmAdmin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TdmIsolytic, dmIsolytic);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  Application.Run;
end.
