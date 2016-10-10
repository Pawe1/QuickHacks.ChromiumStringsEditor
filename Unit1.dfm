object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Primitive translation tool'
  ClientHeight = 798
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 97
    Width = 751
    Height = 701
    Align = alClient
    ColCount = 3
    Ctl3D = False
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    ParentCtl3D = False
    TabOrder = 0
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 751
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    Ctl3D = True
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      751
      97)
    object LabeledEdit1: TLabeledEdit
      Left = 8
      Top = 19
      Width = 441
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'Source dir'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 8
      Top = 60
      Width = 441
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 47
      EditLabel.Height = 13
      EditLabel.Caption = 'Target dir'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 455
      Top = 18
      Width = 33
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 455
      Top = 59
      Width = 33
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 518
      Top = 18
      Width = 73
      Height = 64
      Anchors = [akTop, akRight]
      Caption = 'Load'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 607
      Top = 18
      Width = 75
      Height = 64
      Anchors = [akTop, akRight]
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = Button4Click
    end
  end
end
