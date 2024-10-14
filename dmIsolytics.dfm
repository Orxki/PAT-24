object dmIsolytic: TdmIsolytic
  Height = 464
  Width = 629
  object conIsoDataBase: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=dbInfo.mdb;Mode=Rea' +
      'dWrite;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 48
    Top = 160
  end
  object tblInformation: TADOTable
    Active = True
    Connection = conIsoDataBase
    CursorType = ctStatic
    TableName = 'tblnformation'
    Left = 56
    Top = 240
  end
  object tblStats: TADOTable
    Active = True
    Connection = conIsoDataBase
    CursorType = ctStatic
    TableName = 'tblStats'
    Left = 456
    Top = 200
  end
  object tblFoods: TADOTable
    Active = True
    Connection = conIsoDataBase
    CursorType = ctStatic
    TableName = 'tblFoods'
    Left = 456
    Top = 248
  end
  object DsFoods: TDataSource
    DataSet = tblFoods
    Left = 456
    Top = 304
  end
  object DsInformation: TDataSource
    DataSet = tblInformation
    Left = 56
    Top = 304
  end
end
