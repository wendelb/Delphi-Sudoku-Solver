unit FormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Math;

type
  TFrmSudokuSolver = class(TForm)
    BtnStart: TButton;
    Edt11: TEdit;
    Edt12: TEdit;
    Edt13: TEdit;
    Edt14: TEdit;
    Edt15: TEdit;
    Edt16: TEdit;
    Edt17: TEdit;
    Edt18: TEdit;
    Edt19: TEdit;
    Edt21: TEdit;
    Edt22: TEdit;
    Edt23: TEdit;
    Edt24: TEdit;
    Edt25: TEdit;
    Edt26: TEdit;
    Edt27: TEdit;
    Edt28: TEdit;
    Edt29: TEdit;
    Edt31: TEdit;
    Edt32: TEdit;
    Edt33: TEdit;
    Edt34: TEdit;
    Edt35: TEdit;
    Edt36: TEdit;
    Edt37: TEdit;
    Edt38: TEdit;
    Edt39: TEdit;
    Edt41: TEdit;
    Edt42: TEdit;
    Edt43: TEdit;
    Edt44: TEdit;
    Edt45: TEdit;
    Edt46: TEdit;
    Edt47: TEdit;
    Edt48: TEdit;
    Edt49: TEdit;
    Edt51: TEdit;
    Edt52: TEdit;
    Edt53: TEdit;
    Edt54: TEdit;
    Edt55: TEdit;
    Edt56: TEdit;
    Edt57: TEdit;
    Edt58: TEdit;
    Edt59: TEdit;
    Edt61: TEdit;
    Edt62: TEdit;
    Edt63: TEdit;
    Edt64: TEdit;
    Edt65: TEdit;
    Edt66: TEdit;
    Edt67: TEdit;
    Edt68: TEdit;
    Edt69: TEdit;
    Edt71: TEdit;
    Edt72: TEdit;
    Edt73: TEdit;
    Edt74: TEdit;
    Edt75: TEdit;
    Edt76: TEdit;
    Edt77: TEdit;
    Edt78: TEdit;
    Edt79: TEdit;
    Edt81: TEdit;
    Edt82: TEdit;
    Edt83: TEdit;
    Edt84: TEdit;
    Edt85: TEdit;
    Edt86: TEdit;
    Edt87: TEdit;
    Edt88: TEdit;
    Edt89: TEdit;
    Edt91: TEdit;
    Edt92: TEdit;
    Edt93: TEdit;
    Edt94: TEdit;
    Edt95: TEdit;
    Edt96: TEdit;
    Edt97: TEdit;
    Edt98: TEdit;
    Edt99: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmSudokuSolver: TFrmSudokuSolver;

implementation

{$R *.dfm}

procedure TFrmSudokuSolver.BtnStartClick(Sender: TObject);
begin
//.. start solving
end;

procedure TFrmSudokuSolver.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Edit: TEdit;
  x, y: Integer;
begin
  // This will only work for edits
  if not (Sender is TEdit) then
  begin
    Exit;
  end;

  // No modifier allowed
  if Shift <> [] then
  begin
    Exit;
  end;

  // We checked earlier, hard-casting is therefore allowed
  Edit := TEdit(Sender);
  x := StrToInt(Copy(Edit.Name, 4, 1));
  y := StrToInt(Copy(Edit.Name, 5, 1));

  case Key of
    VK_DOWN:  x := x + 1;
    VK_UP:    x := x - 1;
    VK_RIGHT: y := y + 1;
    VK_LEFT:  y := y - 1;
  else
    // We only want the arrow keys
    Exit;
  end;

  // Check boundaries
  x := Min(Max(x, 1), 9);
  y := Min(Max(y, 1), 9);

  (FindComponent(Format('Edt%d%d', [x, y])) as TEdit).SetFocus;
end;

procedure TFrmSudokuSolver.FormCreate(Sender: TObject);
{$IFDEF DEBUG}
var
  board: array[1..9] of string[9];
  x, y: Integer;
{$ENDIF}

begin

{$IFDEF DEBUG}
  // In Case of Debug, initialize with a sample Sudoku
  board[1] := '8x945x3x2';
  board[2] := '35xx7xxxx';
  board[3] := 'xxxxxxx46';
  board[4] := 'xxxxxx4x9';
  board[5] := '5x76148x3';
  board[6] := '6x8xxxxxx';
  board[7] := '27xxxxxxx';
  board[8] := 'xxxx9xx81';
  board[9] := '9x6x432x7';

  for x := 1 to 9 do
  begin
    for y := 1 to 9 do
    begin
      if board[x][y] <> 'x' then
        (FindComponent('Edt' + IntToStr(x) + IntToStr(y)) as TEdit).Text := board[x][y];
    end;
  end;
{$ENDIF}

end;

end.
