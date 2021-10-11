unit uCustomInterval;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TFormInterval = class(TForm)
    Label1: TLabel;
    SpinButton1: TSpinButton;
    edtCustomInterval: TEdit;
    btOk: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    fInterval : double;
  public
    property CustomInterval : double read fInterval;
  end;

Const
  INCREMENT = 0.1;
var
  FormInterval: TFormInterval;

implementation

{$R *.dfm}

procedure TFormInterval.FormCreate(Sender: TObject);
begin
  fInterval := 1;
end;

procedure TFormInterval.SpinButton1DownClick(Sender: TObject);
begin
  fInterval := fInterval - INCREMENT;
  if(fInterval < 0.1) then fInterval :=0.1;
  edtCustomInterval.Text := Format('%f',[fInterval]);
end;

procedure TFormInterval.SpinButton1UpClick(Sender: TObject);
begin
  fInterval := fInterval + INCREMENT;
  //Faut être motivé ;)
  if(fInterval > 3600) then fInterval :=3600;
  edtCustomInterval.Text := Format('%f',[fInterval]);
end;

procedure TFormInterval.btOkClick(Sender: TObject);
begin
  ModalResult:=1;
end;

end.
