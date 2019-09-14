unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uWSQuery,
  FMX.StdCtrls, FMX.Controls.Presentation;

type
  TFrmLogin = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function  CekKomponen(AName:String):Boolean;
    function  SetKoneksi : Boolean;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;
  WSConn1:  TWSConnection;

implementation

{$R *.fmx}
function  TFrmLogin.CekKomponen(AName:String):Boolean;
var I : Integer;
begin
  Result := false;
  for I := 0 to ComponentCount-1 do
   if Components[I].ClassName=AName then
   begin
     Result := true;
     Exit;
   end;
end;

function  TFrmLogin.SetKoneksi : Boolean;
begin
  if CekKomponen('TWSConection')=false
  then WSConn1 := TWSConnection.Create(self);

  Result := WSConn1.Connected;

  if Result=false then
  begin
    WSConn1.Encrypted := False;
    WSConn1.Host      := 'localhost';
    WSconn1.Port      := 3306;
    WSconn1.User      := 'root';
    WSconn1.Password  := '*******';
    WSconn1.Database  := 'dbsekolah';
    WSconn1.WSURL     := 'http://192.168.1.2/ws.php';
    WSconn1.Token     := 77;

    try
      WSconn1.Connect;
      Result := True;
    except
      ShowMessage('Connection Fail');
      Result := false;
      WSConn1.Free;
    end;
  end;
end;

procedure TFrmLogin.Button1Click(Sender: TObject);
begin
  if SetKoneksi = true
  then Label1.Text := 'Terhubung'
  else Label1.Text := 'Gagal Koneksi'
end;

end.
