unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Unit2,
  dmIsolytics;

type
  TfrmSignUp = class(TForm)
    lblName: TLabel;
    lblUsername: TLabel;
    lblEmail: TLabel;
    lblPass: TLabel;
    lblConfirm: TLabel;
    lblBirth: TLabel;
    lblSex: TLabel;
    edtName: TEdit;
    edtUsername: TEdit;
    edtEmail: TEdit;
    edtPassword: TEdit;
    edtConfirmPassword: TEdit;
    DtpDOB: TDateTimePicker;
    cmbSex: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure Label2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    sName, sUsername, sPassword, sEmail, sSex: string;
    sDOB: TDateTime;
    formattedDate: string;
    function ValidatePassword(const Password: string): Boolean; // Password validation function
    function IsUsernameExists(const Username: string): Boolean; // Check if username exists
    function IsEmailExists(const Email: string): Boolean; // Check if email exists
  public
    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

// Custom function to validate the password
function TfrmSignUp.ValidatePassword(const Password: string): Boolean;
var
  I: Integer;
  HasUpper: Boolean;
  HasSymbol: Boolean;
  Symbols: string;
begin
  Result := False; // Assume invalid unless validated
  HasUpper := False;
  HasSymbol := False;

  // Check minimum length
  if Length(Password) < 6 then
  begin
    ShowMessage('Password must be at least 6 characters long.');
    Exit;
  end;

  // Define the symbols to check for
  Symbols := '!"#$%&''()*+,-./:;<=>?@[\]^_`{|}~';

  // Check for at least one uppercase letter and one symbol
  for I := 1 to Length(Password) do
  begin
    if Password[I] in ['A'..'Z'] then
      HasUpper := True
    else if Pos(Password[I], Symbols) > 0 then
      HasSymbol := True;

    // Break early if both conditions are met
    if HasUpper and HasSymbol then
    begin
      Result := True;
      Exit;
    end;
  end;

  // If we reach here, the password is invalid
  if not HasUpper then
    ShowMessage('Password must contain at least one uppercase letter.');

  if not HasSymbol then
    ShowMessage('Password must contain at least one symbol.');
end;

function TfrmSignUp.IsUsernameExists(const Username: string): Boolean;
begin
  Result := False; // Assume it does not exist
  // Use a query to check for existing username
  dmIsolytic.tblInformation.Filter := 'UserName = ''' + Username + '''';
  dmIsolytic.tblInformation.Filtered := True;
  if dmIsolytic.tblInformation.RecordCount > 0 then
    Result := True;
  dmIsolytic.tblInformation.Filtered := False; // Reset the filter
end;

function TfrmSignUp.IsEmailExists(const Email: string): Boolean;
begin
  Result := False; // Assume it does not exist
  // Use a query to check for existing email
  dmIsolytic.tblInformation.Filter := 'Email = ''' + Email + '''';
  dmIsolytic.tblInformation.Filtered := True;
  if dmIsolytic.tblInformation.RecordCount > 0 then
    Result := True;
  dmIsolytic.tblInformation.Filtered := False; // Reset the filter
end;

procedure TfrmSignUp.Button1Click(Sender: TObject); // Sign Up clicked
begin
  // Validate the password before proceeding
  if not ValidatePassword(edtPassword.Text) then
    Exit; // If validation fails, exit the procedure

  // Check if Terms of Service is accepted
  if not CheckBox1.Checked then
  begin
    ShowMessage('Please read and accept the Terms of Service.');
    Exit;
  end;

  // Validate required fields
  sName := edtName.Text;
  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;
  sEmail := edtEmail.Text;
  sSex := cmbSex.Text;
  sDOB := DtpDOB.Date;

  if (sName = '') or (sUsername = '') or (sEmail = '') or
     (sPassword = '') or (sSex = '') then
  begin
    ShowMessage('Please fill out all fields.');
    Exit;
  end;

  // Validate email format
  if Pos('@', sEmail) = 0 then
  begin
    ShowMessage('Please enter a valid email address.');
    Exit;
  end;

  // Check if username or email already exists
  if IsUsernameExists(sUsername) then
  begin
    ShowMessage('Username already exists. Please choose a different one.');
    Exit;
  end;

  if IsEmailExists(sEmail) then
  begin
    ShowMessage('Email already exists. Please use a different email.');
    Exit;
  end;

  // Check if passwords match
  if sPassword <> edtConfirmPassword.Text then
  begin
    ShowMessage('Passwords do not match. Please try again.');
    Exit;
  end;

  // Validate date of birth
  if sDOB > Now then
  begin
    ShowMessage('Date of birth cannot be in the future.');
    Exit;
  end;

  // If all validations pass, proceed to insert data
  dmIsolytic.tblInformation.Insert;
  dmIsolytic.tblInformation['FirstName'] := sName;
  dmIsolytic.tblInformation['UserName'] := sUsername;
  dmIsolytic.tblInformation['Email'] := sEmail;
  dmIsolytic.tblInformation['Password'] := sPassword;
  dmIsolytic.tblInformation['Sex'] := sSex;
  dmIsolytic.tblInformation['BirthDate'] := sDOB;
  dmIsolytic.tblInformation.Post;

  ShowMessage('Account Successfully Created');
end;

procedure TfrmSignUp.Label2Click(Sender: TObject);
begin
  form2.Show;
end;

end.

