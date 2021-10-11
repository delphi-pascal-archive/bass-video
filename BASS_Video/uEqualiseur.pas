unit uEqualiseur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,uCommonType, Buttons;

type
  TFormEqualiseur = class(TForm)
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    speedFlat: TSpeedButton;
    procedure SetEq(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure speedFlatClick(Sender: TObject);
  private
    fEqualiseur : TMyEqualiseur;
  public
    property Equaliseur : TMyEqualiseur read fEqualiseur;
  end;

var
  FormEqualiseur: TFormEqualiseur;

implementation

{$R *.dfm}

procedure TFormEqualiseur.SetEq(Sender: TObject);
begin
  with fEqualiseur do begin
   case TTrackBar(Sender).Tag of
    1 :
     begin
      Bande1.fGain:=-TrackBar1.Position;
     end;
    2 :
     begin
      Bande2.fGain:=-TrackBar2.Position;
     end;
    3 :
     begin
      Bande3.fGain:=-TrackBar3.Position;
     end;
    4 :
     begin
      Bande4.fGain:=-TrackBar4.Position;
     end;
    5 :
     begin
      Bande5.fGain:=-TrackBar5.Position;
     end;
   end;
  end;
end;

procedure TFormEqualiseur.FormCreate(Sender: TObject);
begin
 // init de l'equaliseur
 with fEqualiseur do begin
  Bande1.fCenter:=80;
  Bande2.fCenter:=250;
  Bande3.fCenter:=1000;
  Bande4.fCenter:=3500;
  Bande5.fCenter:=10000;
 end;

end;

procedure TFormEqualiseur.Button1Click(Sender: TObject);
begin
  ModalResult:=12;
end;

procedure TFormEqualiseur.speedFlatClick(Sender: TObject);
begin
  // oui je sais , c'est pas beau ! 
  TrackBar1.Position:=0;
  TrackBar2.Position:=0;
  TrackBar3.Position:=0;
  TrackBar4.Position:=0;
  TrackBar5.Position:=0;
end;

end.
