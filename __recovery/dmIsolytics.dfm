object dmIsolytic: TdmIsolytic
  Height = 464
  Width = 629
  object conIsoDataBase: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=dbInfo.mdb;Mode=Rea' +
      'dWrite;Persist Security Info=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 104
    Top = 88
  end
  object tblInformation: TADOTable
    Connection = conIsoDataBase
    CursorType = ctStatic
    TableName = 'tblnformation'
    Left = 296
    Top = 216
  end
  object tblStats: TADOTable
    Connection = conIsoDataBase
    CursorType = ctStatic
    TableName = 'tblStats'
    Left = 352
    Top = 216
  end
  object tblFoods: TADOTable
    Connection = conIsoDataBase
    CursorType = ctStatic
    TableName = 'tblFoods'
    Left = 400
    Top = 216
  end
  object DsFoods: TDataSource
    DataSet = tblFoods
    Left = 288
    Top = 360
  end
  object DataSource1: TDataSource
    DataSet = tblInformation
    Left = 376
    Top = 360
  end
end
