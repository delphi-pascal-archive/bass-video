unit uEffetFX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormFX = class(TForm)
    GroupBox1: TGroupBox;
    checkGargle: TCheckBox;
    checkEcho: TCheckBox;
    checkFlanger: TCheckBox;
    checkChorus: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure checkGargleClick(Sender: TObject);
    procedure checkEchoClick(Sender: TObject);
    procedure checkFlangerClick(Sender: TObject);
    procedure checkChorusClick(Sender: TObject);
  private
    fChange : byte;
  public
    property Change : byte read fChange;
  end;

var
  FormFX: TFormFX;

implementation

{$R *.dfm}

procedure TFormFX.FormCreate(Sender: TObject);
begin
  fChange:=0;
end;

procedure TFormFX.checkGargleClick(Sender: TObject);
begin
  fChange:=fChange+1;
end;

procedure TFormFX.checkEchoClick(Sender: TObject);
begin
  fChange:=fChange+1;
end;

procedure TFormFX.checkFlangerClick(Sender: TObject);
begin
  fChange:=fChange+1;
end;

procedure TFormFX.checkChorusClick(Sender: TObject);
begin
  fChange:=fChange+1;
end;

end.
