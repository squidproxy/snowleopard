object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #38634#35961'HASH'#21152#23494' Delphi XE10.1 '#26575#26519#29256
  ClientHeight = 475
  ClientWidth = 987
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    987
    475)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 971
    Height = 459
    ActivePage = TabSheet2
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'FILE'
      DesignSize = (
        963
        431)
      object MemoFile: TMemo
        Left = 3
        Top = 39
        Width = 957
        Height = 387
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
      end
      object Button1: TButton
        Left = 3
        Top = 8
        Width = 238
        Height = 25
        Caption = 'Add File'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'STRING'
      ImageIndex = 1
      DesignSize = (
        963
        431)
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 67
        Height = 13
        Caption = 'Text / String :'
      end
      object MemoStr: TMemo
        Left = 1
        Top = 39
        Width = 957
        Height = 387
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
      end
      object EditStr: TEdit
        Left = 81
        Top = 12
        Width = 877
        Height = 21
        TabOrder = 1
        OnChange = EditStrChange
      end
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoFileMustExist]
    Left = 920
    Top = 32
  end
end
