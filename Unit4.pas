unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin, Data.DB, Vcl.Grids, Vcl.DBGrids,
  dmIsolytics;

type
  TForm4 = class(TForm)
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
    btnRemoveFood: TButton;
    btnEditFood: TButton;
    btnLogFood: TButton;
    memFoods: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAddFoodClick(Sender: TObject);
    procedure btnEditFoodClick(Sender: TObject);
    procedure btnRemoveFoodClick(Sender: TObject);
    procedure btnLogFoodClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    iWorkoutStreak, iDietStreak, iWorkoutsCompleted, iShoulders, iAbs, iBiceps,
      iCalves, iBack, iQuads, iGlutes: integer;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.btnAddFoodClick(Sender: TObject);
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
  dmIsolytic.tblFoods.Post; // Don't forget to post the new record
  ShowMessage('Food item added successfully.');
end;

procedure TForm4.btnEditFoodClick(Sender: TObject);
var
  sFood: string;
  rCalories, rFat, rProtein: real;
begin
  if dmIsolytic.tblFoods.IsEmpty then
  begin
    ShowMessage('No food items to edit.');
    Exit;
  end;

  // Assuming the selected food item in the DBGrid is the one to edit
  dmIsolytic.tblFoods.Edit;

  sFood := InputBox('Food', 'Food Name:',
    dmIsolytic.tblFoods.FieldByName('Food').AsString);
  rCalories := StrToFloat(InputBox('Calories', 'Calorie Count:',
    FloatToStr(dmIsolytic.tblFoods.FieldByName('Calories').AsFloat)));
  rFat := StrToFloat(InputBox('Fat', 'Fat Count:',
    FloatToStr(dmIsolytic.tblFoods.FieldByName('Fats').AsFloat)));
  rProtein := StrToFloat(InputBox('Protein', 'Protein Count:',
    FloatToStr(dmIsolytic.tblFoods.FieldByName('Proteins').AsFloat)));

  dmIsolytic.tblFoods['Food'] := sFood;
  dmIsolytic.tblFoods['Calories'] := rCalories;
  dmIsolytic.tblFoods['Proteins'] := rProtein;
  dmIsolytic.tblFoods['Fats'] := rFat;

  dmIsolytic.tblFoods.Post; // Post the changes to the database
  ShowMessage('Food item edited successfully.');
end;

procedure TForm4.btnLogFoodClick(Sender: TObject);
var
  sFood: string;
  rCalories, rFat, rProtein: real;
begin
  // Check if there are food items in the database
  if dmIsolytic.tblFoods.IsEmpty then
  begin
    ShowMessage('No food items available to log.');
    Exit;
  end;

  // Assuming the selected food item in the DBGrid is the one to log
  sFood := dmIsolytic.tblFoods.FieldByName('Food').AsString;
  rCalories := dmIsolytic.tblFoods.FieldByName('Calories').AsFloat;
  rFat := dmIsolytic.tblFoods.FieldByName('Fats').AsFloat;
  rProtein := dmIsolytic.tblFoods.FieldByName('Proteins').AsFloat;

  // Log the food item in the memo box
  memFoods.Lines.Add
    (Format('Food: %s, Calories: %.2f, Fats: %.2f, Proteins: %.2f',
    [sFood, rCalories, rFat, rProtein]));

  ShowMessage('Food item logged successfully.');
end;

procedure TForm4.btnRemoveFoodClick(Sender: TObject);
begin
  if dmIsolytic.tblFoods.IsEmpty then
  begin
    ShowMessage('No food items to remove.');
    Exit;
  end;

  if MessageDlg('Are you sure you want to delete this food item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmIsolytic.tblFoods.Delete; // Delete the currently selected record
    ShowMessage('Food item deleted successfully.');
  end;
end;

procedure TForm4.Button1Click(Sender: TObject); // BMI Calculator

var
  rWeight, rHeight, rBMI, rAge: real;
  sSex: string;

begin
  rWeight := spnWeight.value;

  rHeight := spnHeight.value / 100;
  rAge := spnAge.value;

  rBMI := (rWeight) / (rHeight * rHeight);
  ShowMessage('Your bmi is  ' + FloatToStr(rBMI));

end;

procedure TForm4.Button2Click(Sender: TObject);
var
  UserID: integer; // Assuming UserID is of type Integer
begin
  // Get the UserID from tblInformation (adjust the code to match your logic)
  UserID := dmIsolytic.tblInformation.FieldByName('UserID').AsInteger;

  if RgpPush.Checked then
  begin
    // Start a new insert for Push workout
    dmIsolytic.tblStats.Insert;
    // Set UserID to the new record
    dmIsolytic.tblStats.FieldByName('ID').AsInteger := UserID;

    // Increment Shoulders count
    dmIsolytic.tblStats.FieldByName('Shoulders').AsInteger := 1;
    // Start from 1 for a new workout

    // Post the new record
    dmIsolytic.tblStats.Post;

    ShowMessage('Push workout selected. Congratulations!');
  end
  else if RgbPull.Checked then
  begin
    // Start a new insert for Pull workout
    dmIsolytic.tblStats.Insert;
    // Set UserID to the new record
    dmIsolytic.tblStats.FieldByName('ID').AsInteger := UserID;

    // Increment Pull workout count
    dmIsolytic.tblStats.FieldByName('Pull').AsInteger := 1;
    // Start from 1 for a new workout

    // Post the new record
    dmIsolytic.tblStats.Post;

    ShowMessage('Pull workout selected. Congratulations!');
  end
  else if RgpLegs.Checked then
  begin
    // Start a new insert for Legs workout
    dmIsolytic.tblStats.Insert;
    // Set UserID to the new record
    dmIsolytic.tblStats.FieldByName('ID').AsInteger := UserID;

    // Increment Legs workout count
    dmIsolytic.tblStats.FieldByName('Legs').AsInteger := 1;
    // Start from 1 for a new workout

    // Post the new record
    dmIsolytic.tblStats.Post;

    ShowMessage('Legs workout selected. Congratulations!');
  end
  else
  begin
    ShowMessage('Please select a workout option.');
  end;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  var
    UserID: integer; // Assuming UserID is of type Integer
  begin
    // Get the UserID from tblInformation (adjust the code to match your logic)
    UserID := dmIsolytic.tblInformation.FieldByName('UserID').AsInteger;

    // Locate the stats record for the given UserID
    if dmIsolytic.tblStats.Locate('ID', UserID, []) then
    begin
      // Set label captions based on retrieved data
      lblShoulders.Caption :=
        IntToStr(dmIsolytic.tblStats.FieldByName('Shoulders').AsInteger);
      lblBiceps.Caption := IntToStr(dmIsolytic.tblStats.FieldByName('Biceps')
        .AsInteger);
      lblAbs.Caption := IntToStr(dmIsolytic.tblStats.FieldByName('Abs')
        .AsInteger);
      lblCalves.Caption := IntToStr(dmIsolytic.tblStats.FieldByName('Calves')
        .AsInteger);
      lblBack.Caption := IntToStr(dmIsolytic.tblStats.FieldByName('Back')
        .AsInteger);
      lblGlutes.Caption := IntToStr(dmIsolytic.tblStats.FieldByName('Glutes')
        .AsInteger);
      lblQuads.Caption := IntToStr(dmIsolytic.tblStats.FieldByName('Quads')
        .AsInteger);

      // Optionally, set other stats
      lblWorkoutStreak.Caption := IntToStr(iWorkoutStreak);
      // Update this logic based on how you calculate streaks
      lblDietStreak.Caption := IntToStr(iDietStreak);
      // Update this logic based on how you calculate streaks
      lblWorkoutsCompleted.Caption := IntToStr(iWorkoutsCompleted);
      // Update this logic as necessary
    end
    else
    begin
      // If no record is found, you can initialize the labels to 0 or any default value
      lblShoulders.Caption := '0';
      lblBiceps.Caption := '0';
      lblAbs.Caption := '0';
      lblCalves.Caption := '0';
      lblBack.Caption := '0';
      lblGlutes.Caption := '0';
      lblQuads.Caption := '0';
      lblWorkoutStreak.Caption := '0';
      lblDietStreak.Caption := '0';
      lblWorkoutsCompleted.Caption := '0';
    end;
  end;
end;

end.
