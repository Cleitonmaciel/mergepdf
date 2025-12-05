object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Merge'
  ClientHeight = 673
  ClientWidth = 1241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 20
  object lstPDFs: TListBox
    AlignWithMargins = True
    Left = 4
    Top = 60
    Width = 1233
    Height = 295
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    ItemHeight = 20
    TabOrder = 0
    ExplicitTop = 56
  end
  object memoLog: TMemo
    AlignWithMargins = True
    Left = 4
    Top = 363
    Width = 1233
    Height = 396
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 1
    ExplicitTop = 359
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 1241
    Height = 56
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = -4
    ExplicitTop = -4
    object pnlBotoes: TPanel
      Left = 645
      Top = 0
      Width = 618
      Height = 56
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      TabOrder = 0
      ExplicitLeft = 624
      object btnAddPDF: TButton
        Left = 1
        Top = 1
        Width = 97
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Add PDF'
        TabOrder = 0
        OnClick = btnAddPDFClick
        ExplicitHeight = 50
      end
      object btnRemove: TButton
        Left = 98
        Top = 1
        Width = 97
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Remove'
        TabOrder = 1
        OnClick = btnRemoveClick
        ExplicitHeight = 50
      end
      object btnMoveDown: TButton
        Left = 195
        Top = 1
        Width = 97
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Move Down'
        TabOrder = 2
        OnClick = btnMoveDownClick
        ExplicitHeight = 50
      end
      object btnMoveUp: TButton
        Left = 292
        Top = 1
        Width = 97
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Move Up'
        TabOrder = 3
        OnClick = btnMoveUpClick
        ExplicitHeight = 50
      end
      object btnClear: TButton
        Left = 389
        Top = 1
        Width = 97
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Clear'
        TabOrder = 4
        OnClick = btnClearClick
        ExplicitHeight = 50
      end
      object btnMerge: TButton
        Left = 486
        Top = 1
        Width = 97
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Merge'
        TabOrder = 5
        OnClick = btnMergeClick
        ExplicitLeft = 392
        ExplicitHeight = 50
      end
    end
    object pnlPath: TPanel
      Left = 0
      Top = 0
      Width = 645
      Height = 56
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 645
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alTop
        Caption = 'Path PDF tk'
        ExplicitLeft = 25
        ExplicitWidth = 74
      end
      object edtPDFtkPath: TEdit
        Left = 160
        Top = 21
        Width = 479
        Height = 28
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 0
      end
      object btnBrowsePDFtk: TButton
        Left = 3
        Top = 19
        Width = 150
        Height = 33
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'BrowsePDFtk'
        TabOrder = 1
        OnClick = btnBrowsePDFtkClick
      end
    end
  end
  object dlgOpen: TOpenDialog
    Left = 155
    Top = 195
  end
  object dlgSave: TSaveDialog
    Left = 147
    Top = 275
  end
  object dlgOpenPDFtk: TOpenDialog
    Left = 22
    Top = 379
  end
end
