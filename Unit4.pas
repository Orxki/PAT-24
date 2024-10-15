unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin, Data.DB, Vcl.Grids, Vcl.DBGrids,
  dmIsolytics;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Image1: TImage;
    lblDietStreak: TLabel;
    lblWorkoutStreak: TLabel;
    lblWorkoutsCompleted: TLabel;
    lblShoulders: TLabel;
    lblBiceps: TLabel;
    lblAbs: TLabel;
    lblCalves: TLabel;
    lblBack: TLabel;
    lblGlutes: TLabel;
    lblQuads: TLabel;
    lblWeight: TLabel;
    lblHeight: TLabel;
    lblGender: TLabel;
    lblAge: TLabel;
    spnWeight: TSpinEdit;
    spnHeight: TSpinEdit;
    spnAge: TSpinEdit;
    cmbGender: TComboBox;
    Button1: TButton;
    Image2: TImage;
    Image3: TImage;
    Button2: TButton;
    RgbPull: TRadioButton;
    RgpPush: TRadioButton;
    RgpLegs: TRadioButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Image4: TImage;
    DBGrid1: TDBGrid;
    btnAddFood: TButton;
    btnLogFood: TButton;
    memFoods: TMemo;
    btnRemoveFood: TButton;
    btnEditFood: TButton;
    Timer1: TTimer;
    TimerCountdown: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAddFoodClick(Sender: TObject);
    procedure btnEditFoodClick(Sender: TObject);
    procedure btnRemoveFoodClick(Sender: TObject);
    procedure btnLogFoodClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TimerCountdownTimer(Sender: TObject);
  private
    iWorkoutStreak, iDietStreak, iWorkoutsCompleted, iShoulders, iAbs, iBiceps,
      iCalves, iBack, iQuads, iGlutes: integer;
    CountdownTime: integer;
    FoodLogArray: array of string; // Declare a dynamic array of strings

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

// Add new food item
// Add new food item
procedure TfrmMain.btnAddFoodClick(Sender: TObject);
var
  sFood: string;
  rCalories, rFat, rProtein: real;
begin
  sFood := InputBox('Food', 'Food Name:', '');
  rCalories := StrToFloat(InputBox('Calories', 'Calorie Count:', ''));
  rFat := StrToFloat(InputBox('Fat', 'Fat Count:', ''));
  rProtein := StrToFloat(InputBox('Protein', 'Protein Count:', ''));

  dmIsolytic.tblFoods.Insert;
  dmIsolytic.tblFoods['Food'] := sFood;
  dmIsolytic.tblFoods['Calories'] := rCalories;
  dmIsolytic.tblFoods['Proteins'] := rProtein;
  dmIsolytic.tblFoods['Fats'] := rFat;
  dmIsolytic.tblFoods.Post;
  ShowMessage('Food item added successfully.');
end;

// Edit food item
// Edit food item
procedure TfrmMain.btnEditFoodClick(Sender: TObject);
var
  sFood: string;
  rCalories, rFat, rProtein: real;
begin
  if dmIsolytic.tblFoods.IsEmpty or (dmIsolytic.tblFoods.RecNo = 0) then
  begin
    ShowMessage('No food items to edit. Please select a food item.');
    Exit;
  end;

  // Edit the selected record
  dmIsolytic.tblFoods.Edit;

  // Get user input for the food details
  sFood := InputBox('Food', 'Food Name:',
    dmIsolytic.tblFoods.FieldByName('Food').AsString);
  rCalories := StrToFloat(InputBox('Calories', 'Calorie Count:',
    FloatToStr(dmIsolytic.tblFoods.FieldByName('Calories').AsFloat)));
  rFat := StrToFloat(InputBox('Fat', 'Fat Count:',
    FloatToStr(dmIsolytic.tblFoods.FieldByName('Fats').AsFloat)));
  rProtein := StrToFloat(InputBox('Protein', 'Protein Count:',
    FloatToStr(dmIsolytic.tblFoods.FieldByName('Proteins').AsFloat)));

  // Update the fields with new values
  dmIsolytic.tblFoods['Food'] := sFood;
  dmIsolytic.tblFoods['Calories'] := rCalories;
  dmIsolytic.tblFoods['Proteins'] := rProtein;
  dmIsolytic.tblFoods['Fats'] := rFat;

  // Post the changes
  dmIsolytic.tblFoods.Post;
  ShowMessage('Food item edited successfully.');
end;

// Log food item
// Log food item
procedure TfrmMain.btnLogFoodClick(Sender: TObject);
var
  sFood: string;
  rCalories, rFat, rProtein: real;
  i: Integer;
begin
  if dmIsolytic.tblFoods.IsEmpty then
  begin
    ShowMessage('No food items available to log.');
    Exit;
  end;

  // Log food details into memFoods as before
  sFood := dmIsolytic.tblFoods.FieldByName('Food').AsString;
  rCalories := dmIsolytic.tblFoods.FieldByName('Calories').AsFloat;
  rFat := dmIsolytic.tblFoods.FieldByName('Fats').AsFloat;
  rProtein := dmIsolytic.tblFoods.FieldByName('Proteins').AsFloat;

  memFoods.Lines.Add(Format('Food: %s, Calories: %.2f, Fats: %.2f, Proteins: %.2f',
    [sFood, rCalories, rFat, rProtein]));
  ShowMessage('Food item logged successfully.');

  // Save contents of memFoods to array
  SetLength(FoodLogArray, memFoods.Lines.Count); // Resize array to match the number of lines
  for i := 0 to memFoods.Lines.Count - 1 do
  begin
    FoodLogArray[i] := memFoods.Lines[i]; // Populate array with each line from memFoods
  end;

  // Optionally, confirm the array was populated
  ShowMessage('Food items logged to array.');
end;


// Remove food item
// Remove food item
procedure TfrmMain.btnRemoveFoodClick(Sender: TObject);
begin
  if dmIsolytic.tblFoods.IsEmpty or (dmIsolytic.tblFoods.RecNo = 0) then
  begin
    ShowMessage('No food items to remove. Please select a food item.');
    Exit;
  end;

  // Confirm deletion
  if MessageDlg('Are you sure you want to delete this food item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmIsolytic.tblFoods.Delete; // Delete the selected item
    ShowMessage('Food item deleted successfully.');
  end;
end;

// BMI Calculator
procedure TfrmMain.Button1Click(Sender: TObject);
var
  rWeight, rHeight, rBMI: real;
begin
  rWeight := spnWeight.Value;
  rHeight := spnHeight.Value / 100;

  rBMI := (rWeight) / (rHeight * rHeight);
  ShowMessage('Your BMI is ' + FloatToStr(rBMI));
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  // Disable the button to prevent spamming
  Button2.Enabled := False;

  // Start the timer
  Timer1.Enabled := True;

  // Check if the table is active before editing
  if not dmIsolytic.tblInformation.Active then
    Exit; // or ShowMessage('Database is not active.');

  // Directly edit the table without locating a username
  dmIsolytic.tblInformation.Edit;

  // Increment the WorkoutStreak and WorkoutsCompleted every time the button is pressed
  dmIsolytic.tblInformation.FieldByName('WorkoutStreak').AsInteger :=
    dmIsolytic.tblInformation.FieldByName('WorkoutStreak').AsInteger + 1;

  // Also increment WorkoutsCompleted
  dmIsolytic.tblInformation.FieldByName('WorkoutsCompleted').AsInteger :=
    dmIsolytic.tblInformation.FieldByName('WorkoutsCompleted').AsInteger + 1;

  if RgpPush.Checked then
  begin
    // Increment Shoulders for Push workout
    dmIsolytic.tblInformation.FieldByName('Shoulders').AsInteger :=
      dmIsolytic.tblInformation.FieldByName('Shoulders').AsInteger + 1;
    ShowMessage('Push workout logged successfully.');
  end
  else if RgbPull.Checked then
  begin
    // Increment Biceps, Abs, and Back for Pull workout
    dmIsolytic.tblInformation.FieldByName('Biceps').AsInteger :=
      dmIsolytic.tblInformation.FieldByName('Biceps').AsInteger + 1;
    dmIsolytic.tblInformation.FieldByName('Abs').AsInteger :=
      dmIsolytic.tblInformation.FieldByName('Abs').AsInteger + 1;
    dmIsolytic.tblInformation.FieldByName('Back').AsInteger :=
      dmIsolytic.tblInformation.FieldByName('Back').AsInteger + 1;
    ShowMessage('Pull workout logged successfully.');
  end
  else if RgpLegs.Checked then
  begin
    // Increment Calves, Glutes, and Quads for Leg workout
    dmIsolytic.tblInformation.FieldByName('Calves').AsInteger :=
      dmIsolytic.tblInformation.FieldByName('Calves').AsInteger + 1;
    dmIsolytic.tblInformation.FieldByName('Glutes').AsInteger :=
      dmIsolytic.tblInformation.FieldByName('Glutes').AsInteger + 1;
    dmIsolytic.tblInformation.FieldByName('Quads').AsInteger :=
      dmIsolytic.tblInformation.FieldByName('Quads').AsInteger + 1;
    ShowMessage('Leg workout logged successfully.');
  end
  else
  begin
    ShowMessage('Please select a workout option.');
    Exit;
  end;

  // Post changes after all increments
  dmIsolytic.tblInformation.Post;

  // Refresh the UI immediately after updating
  lblShoulders.Caption :=
    IntToStr(dmIsolytic.tblInformation.FieldByName('Shoulders').AsInteger);
  lblBiceps.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Biceps')
    .AsInteger);
  lblAbs.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Abs')
    .AsInteger);
  lblCalves.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Calves')
    .AsInteger);
  lblBack.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Back')
    .AsInteger);
  lblGlutes.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Glutes')
    .AsInteger);
  lblQuads.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Quads')
    .AsInteger);
  lblWorkoutStreak.Caption :=
    IntToStr(dmIsolytic.tblInformation.FieldByName('WorkoutStreak').AsInteger);

  // Update lblWorkoutsCompleted
  lblWorkoutsCompleted.Caption :=
    IntToStr(dmIsolytic.tblInformation.FieldByName('WorkoutsCompleted')
    .AsInteger);

  // Start countdown timer for the next workout
  CountdownTime := 60 * 60; // Set countdown to 60 minutes
  TimerCountdown.Enabled := True;
end;



// Workout selection and logging
// Handle the button click event for completing a workout

// Handle form show event
// Handle form show event
procedure TfrmMain.FormShow(Sender: TObject);
begin
  // Initialize or load data as needed when the form is shown
  if not dmIsolytic.tblInformation.Active then
    dmIsolytic.tblInformation.Open;

  // Load existing data into labels if applicable
  if not dmIsolytic.tblInformation.IsEmpty then
  begin
    lblShoulders.Caption :=
      IntToStr(dmIsolytic.tblInformation.FieldByName('Shoulders').AsInteger);
    lblBiceps.Caption :=
      IntToStr(dmIsolytic.tblInformation.FieldByName('Biceps').AsInteger);
    lblAbs.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Abs')
      .AsInteger);
    lblCalves.Caption :=
      IntToStr(dmIsolytic.tblInformation.FieldByName('Calves').AsInteger);
    lblBack.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Back')
      .AsInteger);
    lblGlutes.Caption :=
      IntToStr(dmIsolytic.tblInformation.FieldByName('Glutes').AsInteger);
    lblQuads.Caption := IntToStr(dmIsolytic.tblInformation.FieldByName('Quads')
      .AsInteger);
  end
  else
  begin
    // Reset fields or labels to default if no data is present
    lblShoulders.Caption := '0';
    lblBiceps.Caption := '0';
    lblAbs.Caption := '0';
    lblCalves.Caption := '0';
    lblBack.Caption := '0';
    lblGlutes.Caption := '0';
    lblQuads.Caption := '0';
  end;

  // Reset spin edit fields
  spnWeight.Value := 0;
  spnHeight.Value := 0;
  spnAge.Value := 0;

  // Reset gender selection
  cmbGender.ItemIndex := -1; // Reset gender selection
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  // Re-enable the button
  Button2.Enabled := True;

  // Stop the timer after re-enabling the button
  Timer1.Enabled := False;
end;

procedure TfrmMain.TimerCountdownTimer(Sender: TObject);
var
  Minutes, Seconds: integer;
begin
  if CountdownTime > 0 then
  begin
    // Decrement the countdown time
    Dec(CountdownTime);

    // Calculate minutes and seconds
    Minutes := CountdownTime div 60;
    Seconds := CountdownTime mod 60;

    // Update the button caption with the remaining time
    Button2.Caption := Format('Next workout in: %d:%02d', [Minutes, Seconds]);
  end
  else
  begin
    // Stop the timer when countdown reaches 0
    TimerCountdown.Enabled := False;
    Button2.Caption := 'Workout Available!'; // Reset caption
    Button2.Enabled := True; // Re-enable the button
  end;
end;

end.
