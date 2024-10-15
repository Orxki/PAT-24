unit Admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, dmIsolytics;

type
  TfrmAdmin = class(TForm)
    DBGrid1: TDBGrid;
    edtImport: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    edtView: TButton;
    memLogs: TMemo;
    procedure edtImportClick(Sender: TObject);  // For adding new records
    procedure btnDeleteClick(Sender: TObject);  // For deleting selected record
    procedure btnEditClick(Sender: TObject);    // For editing selected record
    procedure edtViewClick(Sender: TObject);    // For viewing all records
  private
    procedure LogAction(const Msg: string);     // Helper to log actions
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

{$R *.dfm}

// Helper function to log actions in the memo field
procedure TfrmAdmin.LogAction(const Msg: string);
begin
  memLogs.Lines.Add(DateTimeToStr(Now) + ' - ' + Msg);
end;

// Procedure to import a new record with user inputs from InputBox
procedure TfrmAdmin.edtImportClick(Sender: TObject);
var
  FirstName, UserName, Email, Password: string;
begin
  // Collecting input from the user
  FirstName := InputBox('Input', 'Enter First Name:', '');
  UserName := InputBox('Input', 'Enter User Name:', '');
  Email := InputBox('Input', 'Enter Email:', '');
  Password := InputBox('Input', 'Enter Password:', '');

  // Validation of input can be added here if needed

  try
    dmIsolytic.tblInformation.Insert;
    dmIsolytic.tblInformation['FirstName'] := FirstName;
    dmIsolytic.tblInformation['UserName'] := UserName;
    dmIsolytic.tblInformation['Email'] := Email;
    dmIsolytic.tblInformation['Password'] := Password;
    dmIsolytic.tblInformation.Post;

    LogAction('New record added: Username - ' + UserName);
    ShowMessage('Record successfully added.');
  except
    on E: Exception do
    begin
      ShowMessage('Error adding record: ' + E.Message);
      LogAction('Error adding record: ' + E.Message);
    end;
  end;
end;

// Procedure to delete the selected record
procedure TfrmAdmin.btnDeleteClick(Sender: TObject);
begin
  if not dmIsolytic.tblInformation.IsEmpty then
  begin
    if MessageDlg('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        LogAction('Record deleted: Username - ' + dmIsolytic.tblInformation['UserName']);
        dmIsolytic.tblInformation.Delete;
        ShowMessage('Record successfully deleted.');
      except
        on E: Exception do
        begin
          ShowMessage('Error deleting record: ' + E.Message);
          LogAction('Error deleting record: ' + E.Message);
        end;
      end;
    end;
  end
  else
    ShowMessage('No record selected to delete.');
end;

// Procedure to edit the selected record with user inputs from InputBox
procedure TfrmAdmin.btnEditClick(Sender: TObject);
var
  FirstName, Email: string;
begin
  if not dmIsolytic.tblInformation.IsEmpty then
  begin
    // Collecting input from the user
    FirstName := InputBox('Input', 'Edit First Name:', dmIsolytic.tblInformation['FirstName']);
    Email := InputBox('Input', 'Edit Email:', dmIsolytic.tblInformation['Email']);

    // Validation of input can be added here if needed

    try
      dmIsolytic.tblInformation.Edit;
      dmIsolytic.tblInformation['FirstName'] := FirstName;
      dmIsolytic.tblInformation['Email'] := Email;
      dmIsolytic.tblInformation.Post;

      LogAction('Record edited: Username - ' + dmIsolytic.tblInformation['UserName']);
      ShowMessage('Record successfully edited.');
    except
      on E: Exception do
      begin
        ShowMessage('Error editing record: ' + E.Message);
        LogAction('Error editing record: ' + E.Message);
      end;
    end;
  end
  else
    ShowMessage('No record selected to edit.');
end;

// Procedure to view all records
procedure TfrmAdmin.edtViewClick(Sender: TObject);
begin
  try
    dmIsolytic.tblInformation.First;
    DBGrid1.DataSource := dmIsolytic.dsInformation; // Assuming dsInformation is the DataSource
    LogAction('Viewed all records.');
  except
    on E: Exception do
    begin
      ShowMessage('Error viewing records: ' + E.Message);
      LogAction('Error viewing records: ' + E.Message);
    end;
  end;
end;

end.

