object FormEqualiseur: TFormEqualiseur
  Left = 406
  Top = 219
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Equaliser'
  ClientHeight = 247
  ClientWidth = 257
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
    Width = 257
    Height = 247
    Caption = ' Equaliser '
    TabOrder = 0
    object Label1: TLabel
      Left = 209
      Top = 30
      Width = 44
      Height = 16
      Caption = '+ 12 dB'
    end
    object Label2: TLabel
      Left = 209
      Top = 197
      Width = 41
      Height = 16
      Caption = '- 12 dB'
    end
    object Label3: TLabel
      Left = 20
      Top = 217
      Width = 14
      Height = 16
      Caption = '80'
    end
    object Label4: TLabel
      Left = 59
      Top = 217
      Width = 21
      Height = 16
      Caption = '250'
    end
    object Label5: TLabel
      Left = 98
      Top = 217
      Width = 14
      Height = 16
      Caption = '1k'
    end
    object Label6: TLabel
      Left = 133
      Top = 217
      Width = 24
      Height = 16
      Caption = '3,5k'
    end
    object Label7: TLabel
      Left = 177
      Top = 217
      Width = 24
      Height = 16
      Caption = '10 k'
    end
    object speedFlat: TSpeedButton
      Left = 207
      Top = 108
      Width = 31
      Height = 31
      Glyph.Data = {
        A2070000424DA207000000000000360000002800000019000000190000000100
        1800000000006C070000C40E0000C40E000000000000000000000000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF1D1818040B020310
        02001200151B170000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF000000FF0000FF0000FF0000FF0000FF0000FF5E4B51000000023F
        0529992932AB4538AA3F41AC283EA22D3B9A28227606002B000000000000FF00
        00FF0000FF0000FF0000FF0000FF0000FF000000FF0000FF0000FF0000FF0000
        FF000000056C283AC3673CBA512FAD3724A7262BA31E2BA00E279E0A229B0C2A
        96113F921F48911E0B3C000000000000FF0000FF0000FF0000FF0000FF000000
        FF0000FF0000FF0000FF00000037C3761ACF5F21BE3D2EAA1D2DA10837A80B2D
        8F00387A0943880A44A0073AA5112F9D072D940238910C3C83110000000000FF
        0000FF0000FF0000FF000000FF0000FF0000FF0000002FDD8A1ACC6324B94429
        A0132FA51632AC191082005F964DFFFFFFFFFFFF42982E28A60832AD1835AB1B
        2A940D2F8E00468C130000000000FF0000FF0000FF000000FF0000FF00000031
        E09119D66E2EBA4720A02039AC2430B01B1A810DB4D5B2FFFFFFFFFFFFEDF2EE
        288F231DAC162BB02232AD2538B4242A99162D8D0045890E0000000000FF0000
        FF000000FF220F1315A4661CE68A29C56124A62A2BB62826B02E2C9D2AE7FEEB
        FFFFFFFEFDFFFDFFFEECF2E787B2882992331D9F1C2DB1302DB33036BC2F2194
        0C38900922530025282A0000FF000000FF00000032F9B70DDA7D1EB34028B434
        25B9391EB03327A537F2FFFBFFFFFFFDFDF5FDFEFCFFFFFFFFFFFFFFFFFF7AB6
        850B9E2527B63928B53B35B63A228A0050971B0000000000FF000000FF008C4B
        1FEAA11CD27018B13C27B9461FB94028BF421DB23437AB59FFFFFFFFFEFDFDFE
        FDB1D3BCFFFFFFFFFFFFFFFFFF79C58E0BAB2D1EBA4933BA51249D1C3A901305
        45000000FF0036152226F9AC0DE59816C65F1BBA4B28BD501CC04E0FBD4B21C0
        4F09AD405CC47CFFFFFFFFFFFF95C9A0169037D5FFE7FFFFFFFFFFFF33AF5117
        BB4728BF591FB03A278F0F3F8D130000FF0000130C2FFFBE01EA9F10C25E1AC2
        521FC3581FAB5625A15C19B1551CC5540DA64286DBA9FFFFFF65CE7E00B54019
        A750FCFFFFFFFFFF9CE0B10CB3481FC3561FBE51249010429F20011500000012
        0226FFC700EDA51FC3671CC55801B64D9EE7BEFFFFFF71DEA40EB9501AC56017
        B45F09A74D0EBD5811CD5C04AC4CAFF2CFFFFFFFCDF6DD03B14C1EC76227C561
        2890153AA422000C000004150624FFCF03F3B014C46F18C76300B554DDFCE8FF
        FFFFB7F6DA05B0530CD16C14C2670FC66A05C76A14CE6B0EAF55A3F1CFFFFFFF
        E1F9E004B65518C66E1DC4662697184AAA34010B040000000025FFD801F3B106
        D4860EC97006BF64A0E4C5FFFFFFFBFFFF15B16700CD661ACE7016C87614CB75
        02C86B1FAE6AF5FFFFFFFFFFA4E6BB03BD6416CC8112BC5B25A01E43AD380003
        00000500002BFFC301FBB709E9A400C3780ACD7835BD83FFFFFFFFFFFFC5F9EC
        11B56600C06505C77009BB6913B26AC8F8EDFFFFFFFFFFFF2CC38400CC751AD2
        8219AC472AA22833B03B050B00003A1D231ABE6E14FFC603F9BA07CF8E0FC979
        05C56B7DE4B8FFFFFFFFFFFFECFFFF87F0C86BD5AA91EEC8EAFFFFFFFFFFFFFF
        FF7CDFB900C27409D57D22D172159D3630B1462F8B20353038000000FF002700
        2DFFE200FCB818EEAE0CC9810CD47C07BF7882E1BEFEFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFBFFFF7EDFB90AC0790FD28424D98514B24B1FAD4435B85904
        2E000000FF000000FF00000027D88D0BFFD103F8BA0FECAC05C9870BD08600C7
        7C32C68CA0F1D1D4F5EFDCFEFAD0F6F09EF0D330C39101C88108D4881ADA8E12
        BA6619B4502ABE5141AA470000000000FF000000FF262426002A002EFFC100FF
        CF05F6BF0CEEB302D58C09D08408D18800C67D00CA7D09CE8400CA7E00C87D05
        D58B0AD88E11D78708BF6E0EBA6116BF5F35C2530D44003127270000FF000000
        FF0000FF00000011771626FFC10AFFD600F7BD0AF3B10CE7A402D79307D49107
        D48F0AD38A10D58D13D78E0FD48A0ED3830DC57115C46D1CC76B2BC95E1A8328
        0000FF0000FF0000FF000000FF0000FF0000FF00000012842726ECA81CFFD301
        F9BF03F6B203F1AE00EBA606E2A00BDC9810DB950ED78E0DD4870FCE7D1AD07C
        1FD0762DC7632391360000000000FF0000FF0000FF000000FF0000FF0000FF00
        00FF0000001E803117C57F18FBBD14FFC208F4B605F2AE07E9A50FE49F0DE196
        09DD930FD99015D98E17D58723C1662A933C0000000000FF0000FF0000FF0000
        FF000000FF0000FF0000FF0000FF0000FF000000004E181CB26F12D69414EAA6
        08F0AE04F1B100E7A700E7A400E4990DDE9116D88E25BE780C561F0000000000
        FF0000FF0000FF0000FF0000FF000000FF0000FF0000FF0000FF0000FF0000FF
        5C505400000000491511B47624F5BA19FFCF2EFFED1DFFD622FABA10C27C004C
        170000005B51560000FF0000FF0000FF0000FF0000FF0000FF000000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF64425014100E000F040818
        10000F05131111633D4F0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF00}
      OnClick = speedFlatClick
    end
    object TrackBar1: TTrackBar
      Tag = 1
      Left = 10
      Top = 30
      Width = 31
      Height = 184
      Max = 12
      Min = -12
      Orientation = trVertical
      TabOrder = 0
      ThumbLength = 8
      TickMarks = tmBoth
      OnChange = SetEq
    end
    object TrackBar2: TTrackBar
      Tag = 2
      Left = 49
      Top = 30
      Width = 31
      Height = 184
      Max = 12
      Min = -12
      Orientation = trVertical
      TabOrder = 1
      ThumbLength = 8
      TickMarks = tmBoth
      OnChange = SetEq
    end
    object TrackBar3: TTrackBar
      Tag = 3
      Left = 89
      Top = 30
      Width = 30
      Height = 184
      Max = 12
      Min = -12
      Orientation = trVertical
      TabOrder = 2
      ThumbLength = 8
      TickMarks = tmBoth
      OnChange = SetEq
    end
    object TrackBar4: TTrackBar
      Tag = 4
      Left = 128
      Top = 30
      Width = 31
      Height = 184
      Max = 12
      Min = -12
      Orientation = trVertical
      TabOrder = 3
      ThumbLength = 8
      TickMarks = tmBoth
      OnChange = SetEq
    end
    object TrackBar5: TTrackBar
      Tag = 5
      Left = 167
      Top = 30
      Width = 31
      Height = 184
      Max = 12
      Min = -12
      Orientation = trVertical
      TabOrder = 4
      ThumbLength = 8
      TickMarks = tmBoth
      OnChange = SetEq
    end
  end
end