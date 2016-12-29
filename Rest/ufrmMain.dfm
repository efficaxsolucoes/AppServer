object Form1: TForm1
  Left = 271
  Top = 114
  Caption = 'Form1'
  ClientHeight = 221
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 126
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 145
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '9999'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 190
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 395
    Height = 80
    Align = alTop
    BorderWidth = 4
    BorderStyle = bsSingle
    Caption = 'Servidor de Aplica'#231#245'es'
    Color = clRed
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -27
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    ExplicitWidth = 594
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 248
    Top = 126
  end
end
