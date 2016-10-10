unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure SetUpGrid;
    procedure LoadStrings(const ASourcePath, ADestinationPath: string);
    procedure SaveStrings(const ADestinationPath: string);
    function LoadFile(const AFileName: string): string;
    procedure SaveFile(const AFileName, AText: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.Types,
  Vcl.FileCtrl,
  System.IOUtils;

procedure TForm1.Button1Click(Sender: TObject);
var
  Directory: string;
begin
  if SelectDirectory(Directory, [], 0) then
    LabeledEdit1.Text := Directory;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Directory: string;
begin
  if SelectDirectory(Directory, [], 0) then
    LabeledEdit2.Text := Directory;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SetUpGrid;
  LoadStrings(LabeledEdit1.Text, LabeledEdit2.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SaveStrings(LabeledEdit2.Text);
end;

procedure TForm1.LoadStrings(const ASourcePath, ADestinationPath: string);
var
  SourceFiles: TStringDynArray;
  FileName: string;
  DestinationPath: string;
  LC: Integer;
  DestinationExists: Boolean;
begin
  if not TDirectory.Exists(ASourcePath) then
    raise Exception.Create('Source directory not found');

  DestinationExists := TDirectory.Exists(ADestinationPath);
  SourceFiles := TDirectory.GetFiles(ASourcePath);

  StringGrid1.RowCount := High(SourceFiles) + 1;

  for LC := 0 to High(SourceFiles) do
  begin
    FileName := ExtractFileName(SourceFiles[LC]);

    StringGrid1.Cells[0, LC + 1] := FileName;
    StringGrid1.Cells[1, LC + 1] := LoadFile(SourceFiles[LC]);
    if DestinationExists then
    begin
      DestinationPath := TPath.Combine(ADestinationPath, FileName);
      StringGrid1.Cells[2, LC + 1] := LoadFile(DestinationPath);
      if StringGrid1.Cells[1, LC + 1] <> StringGrid1.Cells[2, LC + 1] then
        StringGrid1.Cells[3, LC + 1] := '*';
    end;
  end;
end;

function TForm1.LoadFile(const AFileName: string): string;
begin
  Result := '';
  with TStreamReader.Create(AFileName, TEncoding.UTF8) do
    try
      Result := ReadToEnd;
    finally
      Free;
    end;
end;

procedure TForm1.SaveStrings(const ADestinationPath: string);
var
  LC: Integer;
  FileName : string;
  DestinationFilePath: string;
begin
  if StringGrid1.RowCount < 2 then
    raise Exception.Create('Nothing to save');

  if not TDirectory.Exists(ADestinationPath) then
    raise Exception.Create('Target directory not found');

  for LC := 1 to StringGrid1.RowCount - 1 do
  begin
    FileName := StringGrid1.Cells[0, LC];
    DestinationFilePath := TPath.Combine(ADestinationPath, FileName);
    SaveFile(DestinationFilePath, StringGrid1.Cells[2, LC]);
  end;
end;

procedure TForm1.SaveFile(const AFileName, AText: string);
begin
  with TStreamWriter.Create(AFileName, False, TEncoding.UTF8) do
    try
      BaseStream.Size := 0;
      Write(AText);
    finally
      Free;
    end;
end;

procedure TForm1.SetUpGrid;
begin
  StringGrid1.RowCount := 1;
  StringGrid1.RowCount := 2;

  StringGrid1.ColCount := 4;
  StringGrid1.FixedRows := 1;

  StringGrid1.Cells[0, 0] := 'Resource ID';
  StringGrid1.Cells[1, 0] := 'Original value';
  StringGrid1.Cells[2, 0] := 'Translated value';
  StringGrid1.Cells[3, 0] := 'Diff';

  StringGrid1.ColWidths[1] := 300;
  StringGrid1.ColWidths[2] := 300;
  StringGrid1.ColWidths[3] := 20;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  GridOptions: TGridOptions;
begin
  GridOptions := StringGrid1.Options;
  if ACol = 2 then
    Include(GridOptions, TGridOption.goEditing)
  else
    Exclude(GridOptions, TGridOption.goEditing);
  StringGrid1.Options := GridOptions;
end;

procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  if Value = StringGrid1.Cells[ACol - 1, ARow] then
    StringGrid1.Cells[ACol + 1, ARow] := ''
  else
    StringGrid1.Cells[ACol + 1, ARow] := '*';
end;

end.
