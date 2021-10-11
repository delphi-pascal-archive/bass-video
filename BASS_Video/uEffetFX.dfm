object FormFX: TFormFX
  Left = 409
  Top = 187
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FX Effects (Sound)'
  ClientHeight = 105
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 233
    Height = 105
    Caption = ' Effects FX '
    TabOrder = 0
    object checkGargle: TCheckBox
      Left = 10
      Top = 30
      Width = 119
      Height = 20
      Caption = 'Gargle'
      TabOrder = 0
      OnClick = checkGargleClick
    end
    object checkEcho: TCheckBox
      Left = 10
      Top = 69
      Width = 119
      Height = 21
      Caption = 'Echo'
      TabOrder = 1
      OnClick = checkEchoClick
    end
    object checkFlanger: TCheckBox
      Left = 121
      Top = 30
      Width = 80
      Height = 20
      Caption = 'Flanger'
      TabOrder = 2
      OnClick = checkFlangerClick
    end
    object checkChorus: TCheckBox
      Left = 121
      Top = 69
      Width = 80
      Height = 21
      Caption = 'Chorus'
      TabOrder = 3
      OnClick = checkChorusClick
    end
  end
end
