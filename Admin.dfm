object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  Caption = 'Admin Form'
  ClientHeight = 447
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 8
    Top = 16
    Width = 739
    Height = 241
    DataSource = dmIsolytic.DsInformation
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'AccountID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FirstName'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UserName'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Email'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Password'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Sex'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BirthDate'
        Width = 60
        Visible = True
      end>
  end
  object btnFindUser: TButton
    Left = 8
    Top = 280
    Width = 121
    Height = 25
    Caption = 'Find User'
    TabOrder = 1
    OnClick = btnFindUserClick
  end
  object btnDelete: TButton
    Left = 8
    Top = 320
    Width = 121
    Height = 25
    Caption = 'Delete User'
    TabOrder = 2
    OnClick = btnDeleteClick
  end
  object btnEdit: TButton
    Left = 8
    Top = 360
    Width = 121
    Height = 25
    Caption = 'Edit User'
    TabOrder = 3
    OnClick = btnEditClick
  end
  object btnView: TButton
    Left = 8
    Top = 400
    Width = 121
    Height = 25
    Caption = 'View Stats'
    TabOrder = 4
    OnClick = btnViewClick
  end
  object memLogs: TMemo
    Left = 170
    Top = 281
    Width = 383
    Height = 144
    TabOrder = 5
  end
  object btnSaveLogs: TButton
    Left = 592
    Top = 408
    Width = 129
    Height = 31
    Caption = 'Save Logs'
    TabOrder = 6
    OnClick = btnSaveLogsClick
  end
  object rgpSort: TRadioGroup
    Left = 578
    Top = 280
    Width = 159
    Height = 80
    Caption = 'Sort'
    Items.Strings = (
      'Name'
      'AccountID')
    TabOrder = 7
  end
  object btnSort: TButton
    Left = 616
    Top = 366
    Width = 75
    Height = 25
    Caption = 'Sort'
    TabOrder = 8
    OnClick = btnSortClick
  end
end
