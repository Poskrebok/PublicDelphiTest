object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Test1'
  ClientHeight = 442
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  DesignSize = (
    629
    442)
  TextHeight = 15
  object nmbOfMignon: TEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 0
    TextHint = 'Enter number of Mignons'
  end
  object onStart: TButton
    Left = 264
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = onStartClick
  end
  object capacityWeight: TEdit
    Left = 16
    Top = 64
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 2
    TextHint = 'Enter the capacity'
  end
  object cartProgressBar: TProgressBar
    Left = 16
    Top = 336
    Width = 577
    Height = 26
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    ExplicitWidth = 573
  end
  object Memo1: TDBMemo
    Left = 368
    Top = 24
    Width = 225
    Height = 297
    Enabled = False
    TabOrder = 4
  end
end
