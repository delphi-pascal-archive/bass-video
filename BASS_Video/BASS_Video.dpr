program BASS_Video;

uses
  Forms,
  uMain in 'uMain.pas' {MainForm},
  uCustomInterval in 'uCustomInterval.pas' {FormInterval},
  uEqualiseur in 'uEqualiseur.pas' {FormEqualiseur},
  uCommonType in 'uCommonType.pas',
  uEffetFX in 'uEffetFX.pas' {FormFX};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormInterval, FormInterval);
  Application.CreateForm(TFormEqualiseur, FormEqualiseur);
  Application.CreateForm(TFormFX, FormFX);
  Application.Run;
end.
