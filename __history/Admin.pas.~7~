unit Admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, dmIsolytics, System.IOUtils, Vcl.ExtCtrls;

type
  TfrmAdmin = class(TForm)
    DBGrid1: TDBGrid; // Changed name for consistency
    btnDelete: TButton;
    btnEdit: TButton;
    btnView: TButton; // Changed name for consistency
    memLogs: TMemo;
    btnSaveLogs: TButton;
    rgpSort: TRadioGroup;
    btnSort: TButton;

    procedure btnImportClick(Sender: TObject); // For adding new records
    procedure btnDeleteClick(Sender: TObject); // For deleting selected record
    procedure btnEditClick(Sender: TObject); // For editing selected record
    procedure btnViewClick(Sender: TObject);
    procedure btnFindUserClick(Sender: TObject);
    procedure btnSaveLogsClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);

  private
    procedure LogAction(const Msg: string); // Helper to log actions
    function ValidateInput(const AInput: string; const AFieldName: string)

      : Boolean; // Validate

         procedure SaveLogsToFile;

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

procedure TfrmAdmin.SaveLogsToFile;
var
  LogFileName: string;
  LogFilePath: string;
begin
  LogFileName := 'AdminLogs_' + FormatDateTime('yyyy-mm-dd', Now) + '.txt'; // Format filename with date
  LogFilePath := TPath.Combine(TPath.GetDocumentsPath, LogFileName); // Save to Documents folder

  try
    // Save the contents of the memo to the text file
    memLogs.Lines.SaveToFile(LogFilePath);
    LogAction('Logs saved to: ' + LogFilePath);
    ShowMessage('Logs successfully saved to: ' + LogFilePath); // Confirmation message
  except
    on E: Exception do
    begin
      ShowMessage('Error saving logs: ' + E.Message);
      LogAction('Error saving logs: ' + E.Message);
    end;
  end;
end;


// Function to validate input
function TfrmAdmin.ValidateInput(const AInput: string;
  const AFieldName: string): Boolean;
begin
  Result := Trim(AInput) <> '';
  if not Result then
    ShowMessage(AFieldName + ' cannot be empty.');
end;

// Procedure to import a new record with user inputs from InputBox
procedure TfrmAdmin.btnImportClick(Sender: TObject);
var
  FirstName, UserName, Email, Password: string;
begin
  // Collecting input from the user
  FirstName := InputBox('Input', 'Enter First Name:', '');
  UserName := InputBox('Input', 'Enter User Name:', '');
  Email := InputBox('Input', 'Enter Email:', '');
  Password := InputBox('Input', 'Enter Password:', '');

  // Validate inputs
  if not ValidateInput(FirstName, 'First Name') or
    not ValidateInput(UserName, 'User Name') or
    not ValidateInput(Email, 'Email') or not ValidateInput(Password, 'Password')
  then
    Exit;

  try
    dmIsolytic.tblInformation.Insert;
    dmIsolytic.tblInformation.FieldByName('FirstName').AsString := FirstName;
    dmIsolytic.tblInformation.FieldByName('UserName').AsString := UserName;
    dmIsolytic.tblInformation.FieldByName('Email').AsString := Email;
    dmIsolytic.tblInformation.FieldByName('Password').AsString := Password;
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

procedure TfrmAdmin.btnSaveLogsClick(Sender: TObject);
begin
   SaveLogsToFile; // Call the save logs procedure when button is clicked
end;

procedure TfrmAdmin.btnSortClick(Sender: TObject);
begin
  try
    // Check which option is selected in the RadioGroup
    if rgpSort.ItemIndex = 0 then
    begin
      // Sort by 'UserName' (assuming the field is 'UserName' for sorting by Name)
      dmIsolytic.tblInformation.IndexFieldNames := 'UserName';
      LogAction('Sorted by Name');
    end
    else if rgpSort.ItemIndex = 1 then
    begin
      // Sort by 'AccountID' (assuming the field is 'AccountID')
      dmIsolytic.tblInformation.IndexFieldNames := 'AccountID';
      LogAction('Sorted by AccountID');
    end;

    ShowMessage('Records sorted successfully.');

  except
    on E: Exception do
    begin
      ShowMessage('Error sorting records: ' + E.Message);
      LogAction('Error sorting records: ' + E.Message);
    end;
  end;
end;


// Procedure to delete the selected record
procedure TfrmAdmin.btnDeleteClick(Sender: TObject);
begin
  if dmIsolytic.tblInformation.IsEmpty then
  begin
    ShowMessage('No record selected to delete.');
    Exit;
  end;

  if MessageDlg('Are you sure you want to delete this record?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    try
      LogAction('Record deleted: Username - ' +
        dmIsolytic.tblInformation.FieldByName('UserName').AsString);
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
end;

// Procedure to edit the selected record with user inputs from InputBox
procedure TfrmAdmin.btnEditClick(Sender: TObject);
var
  FirstName, Email: string;
begin
  if dmIsolytic.tblInformation.IsEmpty then
  begin
    ShowMessage('No record selected to edit.');
    Exit;
  end;

  // Collecting input from the user
  FirstName := InputBox('Input', 'Edit First Name:',
    dmIsolytic.tblInformation.FieldByName('FirstName').AsString);
  Email := InputBox('Input', 'Edit Email:',
    dmIsolytic.tblInformation.FieldByName('Email').AsString);

  // Validate inputs
  if not ValidateInput(FirstName, 'First Name') or
    not ValidateInput(Email, 'Email') then
    Exit;

  try
    dmIsolytic.tblInformation.Edit;
    dmIsolytic.tblInformation.FieldByName('FirstName').AsString := FirstName;
    dmIsolytic.tblInformation.FieldByName('Email').AsString := Email;
    dmIsolytic.tblInformation.Post;

    LogAction('Record edited: Username - ' +
      dmIsolytic.tblInformation.FieldByName('UserName').AsString);
    ShowMessage('Record successfully edited.');
  except
    on E: Exception do
    begin
      ShowMessage('Error editing record: ' + E.Message);
      LogAction('Error editing record: ' + E.Message);
    end;
  end;
end;

procedure TfrmAdmin.btnFindUserClick(Sender: TObject);
var
  UserName: string;
  Found: Boolean;
begin
  // Prompt the user to enter a username
  UserName := InputBox('Find User', 'Enter the username to find:', '');

  // Exit if no username is entered
  if UserName = '' then
  begin
    ShowMessage('No username entered. Please try again.');
    Exit;
  end;

  Found := False;

  try
    dmIsolytic.tblInformation.First; // Go to the first record in the table

    // Loop through records until EOF to find the user
    while not dmIsolytic.tblInformation.Eof do
    begin
      if SameText(dmIsolytic.tblInformation.FieldByName('UserName').AsString, UserName) then
      begin
        // Display user stats
        ShowMessage('User: ' + dmIsolytic.tblInformation.FieldByName('UserName').AsString + sLineBreak +
                    'First Name: ' + dmIsolytic.tblInformation.FieldByName('FirstName').AsString + sLineBreak +
                    'Email: ' + dmIsolytic.tblInformation.FieldByName('Email').AsString + sLineBreak +
                    'Diet Streak: ' + dmIsolytic.tblInformation.FieldByName('DietStreak').AsString + sLineBreak +
                    'Workout Streak: ' + dmIsolytic.tblInformation.FieldByName('WorkoutStreak').AsString + sLineBreak +
                    'Workouts Completed: ' + dmIsolytic.tblInformation.FieldByName('WorkoutsCompleted').AsString + sLineBreak +
                    'Biceps: ' + dmIsolytic.tblInformation.FieldByName('Biceps').AsString + sLineBreak +
                    'Back: ' + dmIsolytic.tblInformation.FieldByName('Back').AsString + sLineBreak +
                    'Glutes: ' + dmIsolytic.tblInformation.FieldByName('Glutes').AsString + sLineBreak +
                    'Quads: ' + dmIsolytic.tblInformation.FieldByName('Quads').AsString + sLineBreak +
                    'Shoulders: ' + dmIsolytic.tblInformation.FieldByName('Shoulders').AsString + sLineBreak +
                    'Abs: ' + dmIsolytic.tblInformation.FieldByName('Abs').AsString + sLineBreak +
                    'Calves: ' + dmIsolytic.tblInformation.FieldByName('Calves').AsString);

        // Log the action
        LogAction('Viewed stats for user: ' + UserName);

        Found := True;
        Break; // Exit loop since the user is found
      end;

      dmIsolytic.tblInformation.Next; // Move to the next record
    end;

    if not Found then
      ShowMessage('User "' + UserName + '" not found.');

  except
    on E: Exception do
    begin
      ShowMessage('Error finding user: ' + E.Message);
      LogAction('Error finding user: ' + E.Message);
    end;
  end;
end;



// Procedure to view all records
// Procedure to view all user information except password
// Procedure to view all user information except password
procedure TfrmAdmin.btnViewClick(Sender: TObject);
var
  UserName, FirstName, Email: string;
  Abs, Calves, DietStreak, WorkoutStreak, WorkoutsCompleted: Integer;
  // Assuming these fields are of type Integer
  Biceps, Back, Glutes, Quads, Shoulders: Integer; // Additional stats
  AdditionalInfo: string;
begin
  if not dmIsolytic.tblInformation.IsEmpty then
  begin
    // Get the selected user's information
    UserName := dmIsolytic.tblInformation.FieldByName('UserName').AsString;
    FirstName := dmIsolytic.tblInformation.FieldByName('FirstName').AsString;
    Email := dmIsolytic.tblInformation.FieldByName('Email').AsString;
    Abs := dmIsolytic.tblInformation.FieldByName('Abs').AsInteger;
    // Fetching Abs stat
    Calves := dmIsolytic.tblInformation.FieldByName('Calves').AsInteger;
    // Fetching Calves stat
    DietStreak := dmIsolytic.tblInformation.FieldByName('DietStreak').AsInteger;
    // Fetching DietStreak
    WorkoutStreak := dmIsolytic.tblInformation.FieldByName('WorkoutStreak')
      .AsInteger; // Fetching WorkoutStreak
    WorkoutsCompleted := dmIsolytic.tblInformation.FieldByName
      ('WorkoutsCompleted').AsInteger; // Fetching WorkoutsCompleted
    Biceps := dmIsolytic.tblInformation.FieldByName('Biceps').AsInteger;
    // Fetching Biceps stat
    Back := dmIsolytic.tblInformation.FieldByName('Back').AsInteger;
    // Fetching Back stat
    Glutes := dmIsolytic.tblInformation.FieldByName('Glutes').AsInteger;
    // Fetching Glutes stat
    Quads := dmIsolytic.tblInformation.FieldByName('Quads').AsInteger;
    // Fetching Quads stat
    Shoulders := dmIsolytic.tblInformation.FieldByName('Shoulders').AsInteger;
    // Fetching Shoulders stat

    // Prepare additional information string
    AdditionalInfo :=
      Format('User Information:%sUserName: %s%sFirst Name: %s%sEmail: %s%s' +
      'Abs: %d%sCalves: %d%sDiet Streak: %d%sWorkout Streak: %d%sWorkouts Completed: %d%s'
      + 'Biceps: %d%sBack: %d%sGlutes: %d%sQuads: %d%sShoulders: %d',
      [sLineBreak, UserName, sLineBreak, FirstName, sLineBreak, Email,
      sLineBreak, Abs, sLineBreak, Calves, sLineBreak, DietStreak, sLineBreak,
      WorkoutStreak, sLineBreak, WorkoutsCompleted, sLineBreak, Biceps,
      sLineBreak, Back, sLineBreak, Glutes, sLineBreak, Quads, sLineBreak,
      Shoulders]);

    // Display the user's information in a message box
    ShowMessage(AdditionalInfo);

    // Log the action
    LogAction('Viewed information for User: ' + UserName);
  end
  else
    ShowMessage('No record selected to view.');
end;

end.
