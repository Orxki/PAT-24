unit PAT24;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Unit1, Unit4;

type
  TfrmLogin = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    btnLogin: TButton;
    procedure Label1Click(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation
                                              //Finish your pat bbg
{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
Form4.show;
end;

procedure TfrmLogin.Label1Click(Sender: TObject);
begin
  frmSignup.show;
end;

end.
