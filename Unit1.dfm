object frmSignUp: TfrmSignUp
  Left = 0
  Top = 0
  Caption = 'Sign Up'
  ClientHeight = 411
  ClientWidth = 387
  Color = 16743854
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lblName: TLabel
    Left = 24
    Top = 32
    Width = 54
    Height = 25
    Caption = 'Name:'
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblUsername: TLabel
    Left = 24
    Top = 63
    Width = 89
    Height = 25
    Caption = 'Username:'
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblEmail: TLabel
    Left = 24
    Top = 94
    Width = 50
    Height = 25
    Caption = 'Email:'
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblPass: TLabel
    Left = 24
    Top = 125
    Width = 83
    Height = 25
    Caption = 'Password:'
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblConfirm: TLabel
    Left = 24
    Top = 156
    Width = 156
    Height = 25
    Caption = 'Confirm Password:'
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblBirth: TLabel
    Left = 24
    Top = 187
    Width = 86
    Height = 25
    Caption = 'Birthdate: '
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblSex: TLabel
    Left = 24
    Top = 218
    Width = 33
    Height = 25
    Caption = 'Sex:'
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label1: TLabel
    Left = 49
    Top = 288
    Width = 199
    Height = 15
    Caption = 'By clicking this button you accept the'
    Color = 16744111
    ParentColor = False
  end
  object Label2: TLabel
    Left = 254
    Top = 288
    Width = 115
    Height = 15
    Caption = 'Terms and Conditions'
    Color = 16744111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label2Click
  end
  object Edit1: TEdit
    Left = 208
    Top = 37
    Width = 129
    Height = 23
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 208
    Top = 68
    Width = 129
    Height = 23
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 208
    Top = 99
    Width = 129
    Height = 23
    TabOrder = 2
  end
  object Edit4: TEdit
    Left = 208
    Top = 130
    Width = 129
    Height = 23
    TabOrder = 3
  end
  object Edit5: TEdit
    Left = 208
    Top = 161
    Width = 129
    Height = 23
    TabOrder = 4
  end
  object DateTimePicker1: TDateTimePicker
    Left = 208
    Top = 190
    Width = 97
    Height = 25
    Date = 45517.000000000000000000
    Time = 0.384148032404482400
    TabOrder = 5
  end
  object cmbSex: TComboBox
    Left = 208
    Top = 221
    Width = 97
    Height = 23
    TabOrder = 6
    Text = 'Pick Sex'
    Items.Strings = (
      'Male'
      'Female')
  end
  object CheckBox1: TCheckBox
    Left = 25
    Top = 288
    Width = 18
    Height = 17
    Color = 16744111
    ParentColor = False
    TabOrder = 7
  end
  object Button1: TButton
    Left = 128
    Top = 328
    Width = 129
    Height = 25
    Caption = 'Sign Up'
    TabOrder = 8
  end
end
