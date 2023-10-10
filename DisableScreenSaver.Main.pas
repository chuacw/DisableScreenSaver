unit DisableScreenSaver.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus,
  Delphiapi.ProcessUtils, System.SyncObjs, System.Notification;

type
  TForm1 = class(TForm)
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    miQuit: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure miQuitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FBalloonShown: Boolean;
    FProcessHandle: THandle;
    FProcessObj: THandleObject;
    FStartTime: TDateTime;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Winapi.ShellAPI;

{$R *.dfm}

type
  TProcessObject = class(THandleObject)
  public
    constructor Create(AHandle: THandle); reintroduce;
  end;

{ TProcessObject }

constructor TProcessObject.Create(AHandle: THandle);
begin
  inherited Create(False);
  FHandle := AHandle;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  LAppName: string;
  LAppID: DWORD;
begin
  if ParamCount >= 1 then
    LAppName := ParamStr(1) else
    LAppName := 'C:\Program Files\VideoLAN\VLC\vlc.exe';
  LAppID := ProcessIDFromAppName32(LAppName);
  if LAppID <> 0 then
    FProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_ALL_ACCESS, False, LAppID);
  if FProcessHandle <> 0 then
    begin
      FProcessObj := TProcessObject.Create(FProcessHandle);
      TrayIcon1.Visible := True;
      Timer1.Enabled := True;
    end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  FProcessObj.Free;
end;

procedure TForm1.miQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  LWaitResult: TWaitResult;
begin
  if not Assigned(FProcessObj) then
    Exit;

  if not FBalloonShown then
    begin
      // The balloon title is based on the Application Version Info File Description resource
      FBalloonShown := True;
      TrayIcon1.ShowBalloonHint;
    end;

  LWaitResult := FProcessObj.WaitFor(0);
  case LWaitResult of
    wrTimeout: begin
      SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED or ES_DISPLAY_REQUIRED (* ES_AWAYMODE_REQUIRED *) );
    end;
    wrSignaled: begin
      SetThreadExecutionState(ES_CONTINUOUS);
      Close;
    end;
    wrError: begin
      OutputDebugString(PChar(SysErrorMessage(FProcessObj.LastError)));
    end;
  end;
end;

end.
