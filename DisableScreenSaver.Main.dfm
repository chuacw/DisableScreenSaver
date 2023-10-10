object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 7
  Margins.Top = 7
  Margins.Right = 7
  Margins.Bottom = 7
  Caption = 'Form1'
  ClientHeight = 1001
  ClientWidth = 1412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 216
  TextHeight = 37
  object TrayIcon1: TTrayIcon
    BalloonHint = 'Disabling screen saver'
    BalloonTimeout = 2000
    BalloonFlags = bfInfo
    PopupMenu = PopupMenu1
    Left = 576
    Top = 270
  end
  object PopupMenu1: TPopupMenu
    Left = 576
    Top = 432
    object miQuit: TMenuItem
      Caption = 'Quit'
      OnClick = miQuitClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 774
    Top = 378
  end
end
