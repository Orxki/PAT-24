unit PAT24;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Unit1, Unit4, dmIsolytics, Admin;

type
  TfrmLogin = class(TForm)
    imgLogo: TImage;
    imgPanel: TImage;
    lblSignUp: TLabel;
    edtusername: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    procedure lblSignUpClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);

  private
    sUsername, sPassword: string;
    sAdminUser, sAdminPassword : string;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  sUsername := edtusername.Text;
  sPassword := edtPassword.Text;
  sAdminUser :=  'Admin@1';
  sAdminPassword := 'IsolyticAdmin';


  if (sUsername = '') or (sPassword = '') then
  begin
    ShowMessage('Please enter both Username and Password.');
    Exit;
  end;

  if (sUsername = sAdminUser) AND (sPassword = sAdminPassword ) then
  begin
  frmAdmin.Show;
  frmLogin.Hide;
  exit;
  end;


  // Make sure to locate the first record in the dataset
  dmIsolytic.tblInformation.First;

  // Loop through all records in the table
  while not dmIsolytic.tblInformation.Eof do
  begin
    // Check if both username and password match
    if (dmIsolytic.tblInformation['UserName'] = sUsername) and
      (dmIsolytic.tblInformation['Password'] = sPassword) then
    begin
      ShowMessage('Login successful!');
      Form4.Show; // Show the next form after successful login
      Exit; // Exit the loop after successful login
    end;

    // Move to the next record if no match
    dmIsolytic.tblInformation.Next;
  end;

  // If no match is found after checking all records
  ShowMessage('Incorrect Username or Password.');
end;


procedure TfrmLogin.lblSignUpClick(Sender: TObject);
begin
  frmSignup.Show;
end;

end.
