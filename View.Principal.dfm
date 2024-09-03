object Principal: TPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 201
  ClientWidth = 193
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Teste: TButton
    Left = 56
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Teste'
    TabOrder = 0
    OnClick = TesteClick
  end
  object Button1: TButton
    Left = 42
    Top = 128
    Width = 103
    Height = 25
    Caption = 'Form Dinamico'
    TabOrder = 1
    OnClick = Button1Click
  end
end
