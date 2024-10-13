object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  Caption = 'Admin Form'
  ClientHeight = 530
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
    DataSource = dmIsolytic.DsFoods
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object edtImport: TButton
    Left = 16
    Top = 280
    Width = 121
    Height = 25
    Caption = 'Import Users'
    TabOrder = 1
  end
end
