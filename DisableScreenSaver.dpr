program DisableScreenSaver;

uses
  Vcl.Forms,
  DisableScreenSaver.Main in 'DisableScreenSaver.Main.pas' {Form1},
  Delphiapi.ProcessUtils in '..\Libraries\Delphiapi\Delphiapi.ProcessUtils.pas',
  Winapi.MissingAPIs in '..\Libraries\WinAPI\Winapi.MissingAPIs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.ShowMainForm := False;
  Application.Title := 'Disable Screen Saver';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
