unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    lstPDFs: TListBox;
    btnAddPDF: TButton;
    btnRemove: TButton;
    btnMoveUp: TButton;
    btnMoveDown: TButton;
    btnMerge: TButton;
    btnClear: TButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    memoLog: TMemo;
    edtPDFtkPath: TEdit;
    dlgOpenPDFtk: TOpenDialog;
    pnlTopo: TPanel;
    pnlBotoes: TPanel;
    btnBrowsePDFtk: TButton;
    Label1: TLabel;
    pnlPath: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnAddPDFClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnBrowsePDFtkClick(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
  private
    procedure LogMessage(const Msg: string);
    function ExecutePDFtk(const Params: string): Boolean;
    function FindPDFtk: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.IOUtils;

{$R *.dfm}

{ TForm1 }

procedure TForm1.btnAddPDFClick(Sender: TObject);
var
  i: Integer;
begin
  if dlgOpen.Execute then
  begin
    for i := 0 to dlgOpen.Files.Count - 1 do
    begin
      if not TFile.Exists(dlgOpen.Files[i]) then
      begin
        LogMessage('Erro: Arquivo não encontrado - ' + dlgOpen.Files[i]);
        Continue;
      end;

      lstPDFs.Items.Add(dlgOpen.Files[i]);
      LogMessage('Adicionado: ' + ExtractFileName(dlgOpen.Files[i]));
    end;

    LogMessage('Total de arquivos: ' + IntToStr(lstPDFs.Count));
  end;
end;

procedure TForm1.btnBrowsePDFtkClick(Sender: TObject);
begin
 if edtPDFtkPath.Text <> '' then
    dlgOpenPDFtk.InitialDir := ExtractFileDir(edtPDFtkPath.Text);

  if dlgOpenPDFtk.Execute then
  begin
    edtPDFtkPath.Text := dlgOpenPDFtk.FileName;
    LogMessage('PDFtk configurado: ' + dlgOpenPDFtk.FileName);
  end;
end;

procedure TForm1.btnClearClick(Sender: TObject);
begin
  if MessageDlg('Limpar toda a lista de arquivos?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    lstPDFs.Clear;
    LogMessage('Lista limpa');
  end;
end;

procedure TForm1.btnMergeClick(Sender: TObject);
var
  i: Integer;
  Params: string;
  OutputFile: string;
begin
  if lstPDFs.Count < 2 then
  begin
    ShowMessage('Adicione pelo menos 2 arquivos PDF para fazer o merge.');
    Exit;
  end;

  if Trim(edtPDFtkPath.Text) = '' then
  begin
    ShowMessage('Por favor, configure o caminho do PDFtk.');
    Exit;
  end;

  if dlgSave.Execute then
  begin
    OutputFile := dlgSave.FileName;

    // Construir parâmetros para o PDFtk
    Params := '';
    for i := 0 to lstPDFs.Count - 1 do
    begin
      Params := Params + '"' + lstPDFs.Items[i] + '" ';
    end;

    Params := Params + 'cat output "' + OutputFile + '"';

    LogMessage('Iniciando merge de ' + IntToStr(lstPDFs.Count) + ' arquivos...');

    Screen.Cursor := crHourGlass;
    try
      if ExecutePDFtk(Params) then
      begin
        if TFile.Exists(OutputFile) then
        begin
          LogMessage('Merge concluído com sucesso!');
          LogMessage('Arquivo salvo em: ' + OutputFile);
          ShowMessage('Merge realizado com sucesso!' + #13#10 + 'Arquivo: ' + OutputFile);
        end
        else
        begin
          LogMessage('Erro: Arquivo de saída não foi criado');
          ShowMessage('Erro ao criar arquivo de saída.');
        end;
      end
      else
      begin
        ShowMessage('Erro ao executar o merge. Verifique o log.');
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TForm1.btnMoveDownClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := lstPDFs.ItemIndex;
  if (Idx >= 0) and (Idx < lstPDFs.Count - 1) then
  begin
    lstPDFs.Items.Exchange(Idx, Idx + 1);
    lstPDFs.ItemIndex := Idx + 1;
    LogMessage('Arquivo movido para baixo');
  end;
end;

procedure TForm1.btnMoveUpClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := lstPDFs.ItemIndex;
  if Idx > 0 then
  begin
    lstPDFs.Items.Exchange(Idx, Idx - 1);
    lstPDFs.ItemIndex := Idx - 1;
    LogMessage('Arquivo movido para cima');
  end;
end;

procedure TForm1.btnRemoveClick(Sender: TObject);
var
  FileName: string;
begin
  if lstPDFs.ItemIndex >= 0 then
  begin
    FileName := ExtractFileName(lstPDFs.Items[lstPDFs.ItemIndex]);
    lstPDFs.Items.Delete(lstPDFs.ItemIndex);
    LogMessage('Removido: ' + FileName);
    LogMessage('Total de arquivos: ' + IntToStr(lstPDFs.Count));
  end
  else
    ShowMessage('Selecione um arquivo para remover.');
end;

function TForm1.ExecutePDFtk(const Params: string): Boolean;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CommandLine: string;
  ExitCode: DWORD;
begin
  Result := False;

  if not TFile.Exists(edtPDFtkPath.Text) then
  begin
    if edtPDFtkPath.Text <> 'pdftk.exe' then // Se não for apenas o nome no PATH
    begin
      ShowMessage('PDFtk não encontrado. Por favor, selecione o caminho do pdftk.exe');
      Exit;
    end;
  end;

  ZeroMemory(@StartInfo, SizeOf(StartInfo));
  StartInfo.cb := SizeOf(StartInfo);
  StartInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartInfo.wShowWindow := SW_HIDE;

  CommandLine := '"' + edtPDFtkPath.Text + '" ' + Params;

  LogMessage('Executando: ' + CommandLine);

  if CreateProcess(nil, PChar(CommandLine), nil, nil, False,
    CREATE_NO_WINDOW or NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo) then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcInfo.hProcess, ExitCode);
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);

    Result := (ExitCode = 0);

    if Result then
      LogMessage('PDFtk executado com sucesso')
    else
      LogMessage('PDFtk retornou erro. Código: ' + IntToStr(ExitCode));
  end
  else
  begin
    LogMessage('Erro ao executar PDFtk: ' + SysErrorMessage(GetLastError));
    ShowMessage('Erro ao executar PDFtk. Verifique se o caminho está correto.');
  end;
end;

function TForm1.FindPDFtk: string;
var
  PossiblePaths: TArray<string>;
  Path: string;
begin
  Result := '';

  // Caminhos comuns de instalação do PDFtk
  PossiblePaths := ['C:\Program Files (x86)\PDFtk Server\bin\pdftk.exe',
    'C:\Program Files\PDFtk Server\bin\pdftk.exe', 'C:\PDFtk\bin\pdftk.exe',
    ExtractFilePath(Application.ExeName) + 'pdftk.exe'];

  for Path in PossiblePaths do
  begin
    if TFile.Exists(Path) then
    begin
      Result := Path;
      Exit;
    end;
  end;

  // Tentar encontrar no PATH do sistema
  if Result = '' then
  begin
    try
      var StartInfo: TStartupInfo;
      var ProcInfo: TProcessInformation;
      var CommandLine: string;

      ZeroMemory(@StartInfo, SizeOf(StartInfo));
      StartInfo.cb := SizeOf(StartInfo);
      StartInfo.dwFlags := STARTF_USESHOWWINDOW;
      StartInfo.wShowWindow := SW_HIDE;

      CommandLine := 'cmd.exe /C where pdftk.exe';

      if CreateProcess(nil, PChar(CommandLine), nil, nil, False,
        CREATE_NO_WINDOW, nil, nil, StartInfo, ProcInfo) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, 3000);
        CloseHandle(ProcInfo.hProcess);
        CloseHandle(ProcInfo.hThread);
        Result := 'pdftk.exe'; // Se encontrado no PATH, usar apenas o nome
      end;
    except
      // Ignorar erros
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  PDFtkPath: string;
begin
  // Configurar diálogos
  dlgOpen.Filter := 'Arquivos PDF (*.pdf)|*.pdf';
  dlgOpen.Options := dlgOpen.Options + [ofAllowMultiSelect];
  dlgSave.Filter := 'Arquivos PDF (*.pdf)|*.pdf';
  dlgSave.DefaultExt := 'pdf';

  dlgOpenPDFtk.Filter := 'PDFtk Executável (pdftk.exe)|pdftk.exe|Todos os arquivos (*.*)|*.*';
  dlgOpenPDFtk.Title := 'Selecione o executável do PDFtk';

  // Tentar localizar o PDFtk automaticamente
  PDFtkPath := FindPDFtk;
  if PDFtkPath <> '' then
  begin
    edtPDFtkPath.Text := PDFtkPath;
    LogMessage('PDFtk encontrado em: ' + PDFtkPath);
  end
  else
  begin
    LogMessage('PDFtk não encontrado. Por favor, selecione o caminho do pdftk.exe');
    LogMessage('Você pode baixar o PDFtk gratuitamente em: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/');
  end;
end;

procedure TForm1.LogMessage(const Msg: string);
begin
  memoLog.Lines.Add('[' + TimeToStr(Now) + '] ' + Msg);
end;

end.

