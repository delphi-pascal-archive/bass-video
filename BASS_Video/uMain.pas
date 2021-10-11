unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Bass, BassVideo, Menus, ExtCtrls, XPMan, ImgList,
  StdCtrls, ComCtrls, ToolWin, Buttons;

type
  TTemps = record
    Heure : integer;
    Minute : integer;
    Seconde : integer;
  end;

type
  TVideoUtils = record
    Name : widestring;
    ExtractName : widestring; // nom sans le PATHNAME
    TempoEnable : boolean;
    TempoValue : integer;
    PitchEnable : boolean;
    PitchValue : integer;
    Length : Double;
    Temps : TTemps;
  end;

  TMainForm = class(TForm)
    ImageListButton: TImageList;
    panLecture: TPanel;
    ToolBar1: TToolBar;
    toolBtStop: TToolButton;
    toolBtDecTempo: TToolButton;
    toolBtPrevious: TToolButton;
    toolBtPlay: TToolButton;
    toolBtPause: TToolButton;
    toolBtIncTempo: TToolButton;
    toolBtNext: TToolButton;
    toolBtCapture: TToolButton;
    Label1: TLabel;
    progressVolume: TProgressBar;
    XPManifest1: TXPManifest;
    panPlaylist: TPanel;
    listPlayList: TListBox;
    OpenDialogVideo: TOpenDialog;
    Label2: TLabel;
    progressDuree: TProgressBar;
    Timer1: TTimer;
    PopupVideo: TPopupMenu;
    CapturerTouteslesFrames1: TMenuItem;
    CapturerlaFrame1: TMenuItem;
    ConfigurerInterval: TMenuItem;
    itSec: TMenuItem;
    it10sec: TMenuItem;
    it60: TMenuItem;
    itCustom: TMenuItem;
    labTemps: TLabel;
    popupFile: TPopupMenu;
    itOuvrirFile: TMenuItem;
    itOpenDvD: TMenuItem;
    toolBtAdd: TToolButton;
    LabTempsPasse: TLabel;
    tooBtSound: TToolButton;
    PopupSound: TPopupMenu;
    itExtractSound: TMenuItem;
    itEqualiseur: TMenuItem;
    itFx: TMenuItem;
    itOnOff: TMenuItem;
    itConfigEQ: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure progressVolumeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure toolBtPlayClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure progressDureeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure toolBtStopClick(Sender: TObject);
    procedure toolBtDecTempoClick(Sender: TObject);
    procedure toolBtIncTempoClick(Sender: TObject);
    procedure listPlayListDblClick(Sender: TObject);
    procedure CapturerTouteslesFrames1Click(Sender: TObject);
    procedure toolBtPauseClick(Sender: TObject);
    procedure toolBtPreviousClick(Sender: TObject);
    procedure toolBtNextClick(Sender: TObject);
    procedure CapturerlaFrame1Click(Sender: TObject);
    procedure CheckConfigInterval(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure itOuvrirFileClick(Sender: TObject);
    procedure itOnOffClick(Sender: TObject);
    procedure itConfigEQClick(Sender: TObject);
    procedure itFxClick(Sender: TObject);
    procedure itExtractSoundClick(Sender: TObject);
    procedure itOpenDvDClick(Sender: TObject);
  private
    UtilsInfo : TVideoUtils;
    cptCapture : integer;
    IntervalCapture : double;
    SaveRect : TRect;
    TempsText : integer;
    hText : integer;
    isTexte : boolean;
    SaveChange : byte;

    isEQ : boolean;
    // Equaliseur à 5 bandes
    EQ : array [0..4] of HFX;
    pEQ : BASS_DX8_PARAMEQ;

    GA : HFX;
    FL : HFX;
    EH : HFX;
    CH : HFX;

  public
    procedure Init;
    procedure Quit;
    procedure ResizeWindowVideo;
    procedure SetTempoVideo(Tempo : integer);
    function GetTempoVideo : integer;
    procedure PlayVideo(num : integer);
    procedure SaveFrame(FileName : widestring);
    procedure AddText(fText : widestring);

    procedure SetEQ_FX;
  end;

const
  MAX_VOLUME = 100;
  MIN_VOLUME = 0;
  NUM_CAPTURE_INI = 1;
  TEMPO_VALUE_MIN = 80;
  TEMPO_VALUE_MAX = 8000;
  TEMPO_VALUE_INI = 1000;
  TEMPO_VALUE_INC = 50;
  TEMPS_MAX_TEXT = 5; // en sec % au Timer (Interval = 1000);

  EQ_BANDWIDTH = 20;
var
  MainForm: TMainForm;
  PATH : String;
  Chan : DWORD;
  isFullScreen : boolean;
  OldStyle : Longint;

implementation

uses
  uCustomInterval,uEqualiseur,uEffetFX;

{$R *.dfm}

function MyVideoStream(Handle : DWORD; Action, param1, param2 : DWORD; user : Pointer): BOOL; stdcall;
var
  ClientRect : TRect;
begin
 result := TRUE;
 case Action of
  BassVideo_FoundVideo :
    begin
      // on chope la zone d'affichage
      ClientRect:=MainForm.ClientRect;
      with ClientRect do begin
        Left := 0;
        Top := 0;
        Right := Right - MainForm.panPlaylist.Width;
        Bottom := Bottom - MainForm.PanLecture.Height;
      end;
      BASSVideo_SetVideoWindow(Handle, MainForm.Handle,ClientRect, 0);
    end;

  BassVideo_EndStream :
   begin
      BassVideo_StreamFree(chan);
      // a la fin de la video, voir la progression n'a plus grande importance, on stope le Timer
      MainForm.Timer1.Enabled:=False;
   end;

  BassVideo_OpenDone :
    begin
    //Ouverture Réussie
    end;

  BassVideo_DShow_Event :
   begin
   end;

 end;
end;

(*
  Gestion des erreurs sous bass avec Message perso ;)
  A venir parce que c'est vachement long !
*)
(* A l'air d'être inexistant sous BASSVideo  :(, ou pas renseigné dans l'aide ! *)

function MsgError(NumError : integer):PChar;
var
  msg : String;
begin
  msg:='';
  case  NumError of
    BASS_OK : msg:='Initialisation de Bass réussie ! ';
    (*BASS_ERROR_MEM
    BASS_ERROR_FILEOPEN
    BASS_ERROR_DRIVER
    BASS_ERROR_BUFLOST
    BASS_ERROR_HANDLE
    BASS_ERROR_FORMAT
    BASS_ERROR_POSITION
    BASS_ERROR_INIT
    BASS_ERROR_START
    BASS_ERROR_ALREADY
    BASS_ERROR_NOCHAN
    BASS_ERROR_ILLTYPE
    BASS_ERROR_ILLPARAM
    BASS_ERROR_NO3D
    BASS_ERROR_NOEAX
    BASS_ERROR_DEVICE
    BASS_ERROR_NOPLAY
    BASS_ERROR_FREQ
    BASS_ERROR_NOTFILE
    BASS_ERROR_NOHW
    BASS_ERROR_EMPTY
    BASS_ERROR_NONET
    BASS_ERROR_CREATE
    BASS_ERROR_NOFX
    BASS_ERROR_NOTAVAIL
    BASS_ERROR_DECODE
    BASS_ERROR_DX
    BASS_ERROR_TIMEOUT
    BASS_ERROR_FILEFORM
    BASS_ERROR_SPEAKER
    BASS_ERROR_VERSION
    BASS_ERROR_CODEC
    BASS_ERROR_ENDED  *)
    BASS_ERROR_UNKNOWN : msg:='Erreur Inconue ! ';
  end;
  result :=PChar(msg);
end;

procedure TMainForm.ResizeWindowVideo;
var
  fClientRect : TRect;
begin
  fClientRect := ClientRect;
  with fClientRect do begin
    Left := 0;
    Top := 0;
    // si pas plein ecran, on doit compter la largeur / hauteur des differents panels
    if not (IsFullScreen) then begin
      Right := Right - panPlaylist.Width;
      Bottom := Bottom - PanLecture.Height;
    end;
  end;
  BassVideo_WindowResize(Chan,fClientRect,0);
end;

procedure TMainForm.SetEQ_FX;
begin
  // on applique les changements
  BASS_FXGetParameters(Eq[0],@pEq);
    pEq.fCenter:=FormEqualiseur.Equaliseur.Bande1.fCenter;
    pEq.fBandwidth := EQ_BANDWIDTH;
    pEq.fGain := FormEqualiseur.Equaliseur.Bande1.fGain;
  BASS_FXSetParameters(Eq[0],@pEq);

  // on applique les changements
  BASS_FXGetParameters(Eq[1],@pEq);
    pEq.fCenter:=FormEqualiseur.Equaliseur.Bande2.fCenter;
    pEq.fBandwidth := EQ_BANDWIDTH;
    pEq.fGain := FormEqualiseur.Equaliseur.Bande2.fGain;
  BASS_FXSetParameters(Eq[1],@pEq);

  // on applique les changements
  BASS_FXGetParameters(Eq[2],@pEq);
    pEq.fCenter:=FormEqualiseur.Equaliseur.Bande3.fCenter;
    pEq.fBandwidth := EQ_BANDWIDTH;
    pEq.fGain := FormEqualiseur.Equaliseur.Bande3.fGain;
  BASS_FXSetParameters(Eq[2],@pEq);

  // on applique les changements
  BASS_FXGetParameters(Eq[3],@pEq);
    pEq.fCenter:=FormEqualiseur.Equaliseur.Bande4.fCenter;
    pEq.fBandwidth := EQ_BANDWIDTH;
    pEq.fGain := FormEqualiseur.Equaliseur.Bande4.fGain;
  BASS_FXSetParameters(Eq[3],@pEq);

  // on applique les changements
  BASS_FXGetParameters(Eq[4],@pEq);
    pEq.fCenter:=FormEqualiseur.Equaliseur.Bande5.fCenter;
    pEq.fBandwidth := EQ_BANDWIDTH;
    pEq.fGain := FormEqualiseur.Equaliseur.Bande5.fGain;
  BASS_FXSetParameters(Eq[4],@pEq);
end;
procedure TMainForm.Init;
begin
  // Ordre à respecter BASS , BASSVideo ...
  if not Bass_Init(-1, 44100, 0, 0, nil) then
  begin
    MessageBox(handle,MsgError(BASS_ErrorGetCode),'Error',MB_OK);
    halt;
  end;

  if not BASSVideo_Init then halt;
  BassVideo_SetConfig(BassVideo_Default, 1);


  with progressVolume do begin
    Max := MAX_VOLUME;
    Min := MIN_VOLUME;
    Position := MAX_VOLUME;
    Smooth := True;
  end;
  // compter de nombre de frame capturé
  // pr les noms attribuers aux fichiers BMP capturés
  cptCapture := NUM_CAPTURE_INI;
  isFullScreen := false;
  isEQ:=false;
end;

procedure TMainForm.Quit;
begin
  BassVideo_StreamFree(Chan);
  // d'abord on libère BASSVideo puis Bass (normal vu que BASSVideo utilise Bass ... )
  BASSVideo_Free;
  BASS_Free;
end;

procedure TMainForm.PlayVideo(num : integer);
begin
  // si il y a deja quelque chose de chargé, on le libère
  if(Chan<>0) then BassVideo_StreamFree(Chan);
  // on le charge
  //BASSVIDEO_VIDEOEFFECT = possibilité de mettre du texte sur l'image...
  Chan := BassVideo_StreamCreateFile(PChar(listPlayList.Items.Strings[num]), BASSVIDEO_VIDEOEFFECT , 0, @MyVideoStream, nil);
  BassVideo_Play(Chan);

  // On active le Tempo et le Pitch
  BassVideo_SetTempoEnable(Chan,True);
  BASSVideo_SetPitchEnable(Chan,True);

  // on remplit notre record Utils
  with UtilsInfo do begin
    Name :=listPlayList.Items.Strings[num];
    ExtractName :=ExtractFileName(listPlayList.Items.Strings[num]);
    TempoEnable :=BASSVideo_GetTempoEnable(Chan);
    TempoValue:=1000;//BASSVideo_GetTempoValue(Chan);
    PitchEnable := BASSVideo_GetPitchEnable(Chan);
    PitchValue := BASSVideo_GetPitchValue(Chan);
    Length := BASSVideo_GetLength(Chan);
    // on calcule le nb H,M,S % à Round(Length) qi donne le temps en seconde...
    Temps.Heure:=Round(Length)div 3600;
    Temps.Minute := Round(Length - (Temps.Heure*3600)) div 60;
    Temps.Seconde := Round(Length - (Temps.Heure*3600) - (Temps.Minute*60));
    labTemps.Caption := Format('%d Hour %d minutes %d seconds',[Temps.Heure,Temps.Minute,Temps.Seconde]);
  end;

  progressDuree.Min := 0;
  progressDuree.Max := Round(UtilsInfo.Length);
  progressDuree.Position:=0;
  IntervalCapture := 1; // par defaut, captures ts les secondes
  // on active le Timer pr voir la progrssion de la video
  Timer1.Enabled:=True;
  // on met le nom de la vidéo qu'on joue sur la vidéo

  AddText(UtilsInfo.ExtractName);
end;

procedure TMainForm.AddText(fText : widestring);
begin
  // si il y a du texte, on l'efface
  if(isTexte) then BASSVideo_RemoveText(Chan,hText);

  hText:=BassVideo_AddText(Chan,PWideChar(fText), 10, 10, 'Arial', 24, 0, RGB(255, 255, 255), 0100); // Gras
  TempsText:=0;
  isTexte:=True;
end;

procedure TMainForm.SaveFrame(FileName : widestring);
var
  pos : double;
begin
  pos := BassVideo_GetPosition(Chan);//+ precis que progressDuree.Position
  BassVideo.BassVideo_CaptureBitmap(PWideChar(UtilsInfo.Name), pos, PWideChar(PATH+FileName), BASS_UNICODE);
end;

procedure TMainForm.SetTempoVideo(Tempo : integer);
begin
  // il y a un truc débiles, GetTempoValue renvoie un Integer
  // Mais SetTempoValue Veut Recevoir un Cardinal !
  BASSVideo_SetTempoValue(Chan,Tempo);
end;

function TMainForm.GetTempoVideo : integer;
begin
  result := BASSVideo_GetTempoValue(Chan);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PATH := ExtractFilePath(Application.ExeName);
  ShowHint := True;
  Init;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Quit;
end;

procedure TMainForm.progressVolumeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pos : double;
begin
  with progressVolume do begin
    pos :=(Max/Width)*X;
    Position := Round(pos);
    BASS_ChannelSetAttribute(Chan, BASS_ATTRIB_VOL, pos/100);
    AddText('Volume : '+IntToStr(Position)+' %');
  end;
end;

procedure TMainForm.progressDureeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pos:double;
begin
  with progressDuree do begin
    Pos:=(Max/Width)*X;
    BASSVideo_SetPosition(Chan,Pos);
    Position := Round(Pos);
  end;
end;

procedure TMainForm.toolBtPlayClick(Sender: TObject);
begin
  if(listPlayList.ItemIndex=-1) then exit;
  PlayVideo(listPlayList.ItemIndex);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  pos : double;
  t : TTemps;
begin
  pos := BASSVideo_GetPosition(Chan);
  progressDuree.Position := Round(pos);

  if(isTexte) then begin
    TempsText:=TempsText+1;
    if(TempsText>TEMPS_MAX_TEXT) then begin
      BASSVideo_RemoveText(Chan,hText);
      isTexte:=False;
    end;
  end;

  with t do begin
    Heure:=Round(pos)div 3600;
    Minute := Round(pos - (Heure*3600)) div 60;
    Seconde := Round(pos - (Heure*3600) - (Minute*60));
    LabTempsPasse.Caption:= Format('%d Hour %d minutes %d seconds',[Heure,Minute,Seconde]);
  end;

  if(isEq) then SetEQ_Fx;
  // on a touché une checkbox d'effet ...
  if(SaveChange <> FormFx.Change) then begin
    if(FormFx.checkGargle.Checked) then GA:=BASS_ChannelSetFX(Chan,BASS_FX_DX8_GARGLE,0)
      else BASS_ChannelRemoveFX(Chan,GA);

    if(FormFx.checkEcho.Checked) then EH:=BASS_ChannelSetFX(Chan,BASS_FX_DX8_ECHO,0)
      else BASS_ChannelRemoveFX(Chan,EH);

    if(FormFx.checkFlanger.Checked) then FL:=BASS_ChannelSetFX(Chan,BASS_FX_DX8_FLANGER,0)
      else BASS_ChannelRemoveFX(Chan,FL);

    if(FormFx.checkChorus.Checked) then CH:=BASS_ChannelSetFX(Chan,BASS_FX_DX8_CHORUS,0)
      else BASS_ChannelRemoveFX(Chan,CH);

    SaveChange:=FormFx.Change;
  end;
end;

procedure TMainForm.toolBtStopClick(Sender: TObject);
begin
  BASSVideo_Stop(Chan);
end;

procedure TMainForm.toolBtDecTempoClick(Sender: TObject);
begin
  if chan = 0 then exit;
  with UtilsInfo do begin
    TempoValue := TempoValue - TEMPO_VALUE_INC;
    if(TempoValue<TEMPO_VALUE_MIN)then TempoValue:=TEMPO_VALUE_MIN;
    SetTempoVideo(TempoValue);
    AddText('Tempo : '+IntToStr(TempoValue));
  end;
end;

procedure TMainForm.toolBtIncTempoClick(Sender: TObject);
begin
 if chan = 0 then exit;
 with UtilsInfo do begin
    TempoValue := TempoValue + TEMPO_VALUE_INC;               
    if(TempoValue>TEMPO_VALUE_MAX)then TempoValue:=TEMPO_VALUE_MAX;
    SetTempoVideo(TempoValue);
    AddText('Tempo : '+IntToStr(TempoValue));
  end;
end;

procedure TMainForm.listPlayListDblClick(Sender: TObject);
begin
  if(listPlayList.ItemIndex=-1) then exit;
  PlayVideo(listPlayList.ItemIndex);
end;

procedure TMainForm.CapturerTouteslesFrames1Click(Sender: TObject);
var
  s : widestring;
  pos : double;
  TempPos : double;
begin
 (* j'utilise la technique suivante := On se place au début de la vidéo, on increment sa position
  avec IntervalCapture(config avant, par defaut = 1) et on fait ca jusque la fin ...

  Pr prendre absolument ts les frames (du moins le possible en théorique voir l'aide de
  BASSVideo pr comprendre ca (A telecharger sur www.un4seen.com section forum)
  on peut faire comme ceci
  chan := BassVideo_StreamCreateFile(...)
  BassVideo_Pause(chan);
  BassVideo_FrameStep(chan);
  puis on capture la Frame , jusque la dernière ...
  *)
  
  if chan = 0 then exit;
  // on sauvegarde la position
  TempPos :=BASSVideo_GetPosition(Chan);
  // on la stoppe
  BASSVideo_Stop(Chan);
  // on l'a remet au debut
  BASSVideo_SetPosition(Chan,0);
  pos := BASSVideo_GetPosition(Chan);

  while(pos <= UtilsInfo.Length) do begin
    s := 'Capture'+IntToStr(cptCapture)+'.bmp';
    SaveFrame(s);
    cptCapture:=cptCapture+1;
    pos := BASSVideo_GetPosition(Chan);
    pos := pos + IntervalCapture;
    BASSVideo_SetPosition(Chan,pos);
    // On met à jour la barre de progression toutes les 25 secondes de vidéo
    // capturée ... 
    if(Round(pos) mod 25 = 0) then Application.ProcessMessages;
  end;
  // l'opération effectuée on replace la vidéo a son ancienne position
  // et on la joue :)
  BASSVideo_SetPosition(Chan,TempPos);
  BASSVideo_Play(Chan);
end;

procedure TMainForm.CapturerlaFrame1Click(Sender: TObject);
var
  s : widestring;
begin
 if chan = 0 then exit;
 s := 'Capture'+IntToStr(cptCapture)+'.bmp';
 SaveFrame(s);
 cptCapture:=cptCapture+1;
end;

procedure TMainForm.toolBtPauseClick(Sender: TObject);
begin
  BASSVideo_Pause(Chan);
end;

procedure TMainForm.toolBtPreviousClick(Sender: TObject);
begin
  listPlayList.ItemIndex:=listPlayList.ItemIndex-1;
  if(listPlayList.ItemIndex = -1) then exit;
  PlayVideo(listPlayList.ItemIndex);
end;

procedure TMainForm.toolBtNextClick(Sender: TObject);
begin
  listPlayList.ItemIndex:=listPlayList.ItemIndex+1;
  PlayVideo(listPlayList.ItemIndex);
end;

procedure TMainForm.CheckConfigInterval(Sender: TObject);
begin
  case TMenuItem(Sender).Tag of
    1 :IntervalCapture:=1;
    2 :IntervalCapture:=10;
    3 :IntervalCapture:=60;
    4 :
     begin
      FormInterval.ShowModal;
      IntervalCapture := FormInterval.CustomInterval;
      TMenuItem(Sender).Caption:=Format('Custom(%f)sec',[IntervalCapture]);
     end;
  end;
end;

procedure TMainForm.FormDblClick(Sender: TObject);
begin
  // inverseur logique
  isFullScreen := not isFullScreen;
  if(isFullScreen)then begin
    PanPlayList.Hide;
    PanLecture.Hide;
    // Avant de Changer la fenetre , on enregistre ces informations, dans le but de les remettre
    // apres le FullScreen...
    with SaveRect do begin
      Left := Left;
      Top := Top;
      Right := Width;
      Bottom := Height;
    end;
    OldStyle := GetWindowLong(Handle ,GWL_STYLE);
    // on peut maintenant la modifié, puisque on pourra la restaurer ;) 
    SetWindowLong(Handle, GWL_STYLE, integer(WS_POPUPWINDOW or WS_VISIBLE));

    Top:=0;
    Left:=0;
    // La merveille du FullScreen :)
    Width:=Screen.Width;
    Height:=Screen.Height;

  end
  else begin
    PanPlayList.Show;
    PanLecture.Show;
    // on replace l'ancien style et les anciennes coord + taille
    SetWindowLong(Handle,GWL_STYLE, OldStyle);
    SetWindowPos(Handle, 0, SaveRect.Left , SaveRect.Top, SaveRect.Right, SaveRect.Bottom , 0);
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  ResizeWindowVideo;
end;

procedure TMainForm.itOuvrirFileClick(Sender: TObject);
begin
  if(OpenDialogVideo.Execute) then begin
    listPlayList.Items.Add(OpenDialogVideo.FileName);
    PlayVideo(listPlayList.Count-1);
  end;
end;

procedure TMainForm.itOnOffClick(Sender: TObject);
begin
  isEQ := not isEq;
  if(isEQ) then begin
    itOnOff.Caption := 'Inactive';
    EQ[0]:=BASS_ChannelSetFx(Chan,BASS_FX_DX8_PARAMEQ,0);
    EQ[1]:=BASS_ChannelSetFx(Chan,BASS_FX_DX8_PARAMEQ,0);
    EQ[2]:=BASS_ChannelSetFx(Chan,BASS_FX_DX8_PARAMEQ,0);
    EQ[3]:=BASS_ChannelSetFx(Chan,BASS_FX_DX8_PARAMEQ,0);
    EQ[4]:=BASS_ChannelSetFx(Chan,BASS_FX_DX8_PARAMEQ,0);
    SetEQ_FX;
  end
  else begin
    itOnOff.Caption := 'Active';
    BASS_ChannelRemoveFX(Chan,EQ[0]);
    BASS_ChannelRemoveFX(Chan,EQ[1]);
    BASS_ChannelRemoveFX(Chan,EQ[2]);
    BASS_ChannelRemoveFX(Chan,EQ[3]);
    BASS_ChannelRemoveFX(Chan,EQ[4]);
  end;
end;

procedure TMainForm.itConfigEQClick(Sender: TObject);
begin
  FormEqualiseur.Show;
end;

procedure TMainForm.itFxClick(Sender: TObject);
begin
  FormFX.Show;
  SaveChange := FormFX.Change;
end;

procedure TMainForm.itExtractSoundClick(Sender: TObject);
begin
  ShowMessage('A Venir!');
end;

procedure TMainForm.itOpenDvDClick(Sender: TObject);
begin
  ShowMessage('A Venir!');
end;

end.    
