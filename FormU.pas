unit FormU;

interface

{$DEFINE Sample1}
{.$DEFINE Sample2}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Math, System.Generics.Collections;

type
  TBoard = array[1..9] of array[1..9] of Byte;
  TPointList = TList<TPoint>;
  TAllowedDigits = set of 1..9;

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
    function ReadBoard(): TBoard;
    procedure WriteBoard(board: TBoard);

    function GetValidDigits(board: TBoard; x, y: Integer): TAllowedDigits;
    function GetDigitsInRow(board: TBoard; row: Integer): TAllowedDigits;
    function GetDigitsInColumn(board: TBoard; col: Integer): TAllowedDigits;

    function GetDigitsInBlock(board: TBoard; block: Integer): TAllowedDigits;
    function GetBlockCoords(block: Integer): TPointList;
    function GetBlock(x, y: Integer): Integer;

    function GetFreePositions(board: TBoard): TPointList;
    function SolveBacktrack(board: TBoard; freePositions: TPointList): boolean;

    function heuristic(board: TBoard; freePositions: TPointList): TPoint;

    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmSudokuSolver: TFrmSudokuSolver;

implementation

{$R *.dfm}

procedure TFrmSudokuSolver.BtnStartClick(Sender: TObject);
var
  board: TBoard;
  freePositions: TPointList;
  msg: String;
  item: TPoint;
begin
  board := ReadBoard;

  // start solving
  freePositions := GetFreePositions(board);
  SolveBacktrack(board, freePositions);
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
  {$IFDEF Sample1}
    {$IFDEF Sample2}
      {$MESSAGE Fatal 'Invalid Sample Selection'}
    {$ENDIF}
  {$ENDIF}

  // In Case of Debug, initialize with a sample Sudoku
  {$IF Defined(Sample1) or Defined(Sample2)}
    {$IFDEF Sample1}
      board[1] := '8x945x3x2';
      board[2] := '35xx7xxxx';
      board[3] := 'xxxxxxx46';
      board[4] := 'xxxxxx4x9';
      board[5] := '5x76148x3';
      board[6] := '6x8xxxxxx';
      board[7] := '27xxxxxxx';
      board[8] := 'xxxx9xx81';
      board[9] := '9x6x432x7';
    {$ENDIF}
    {$IFDEF Sample2}
      board[1] := 'xxx3x56xx';
      board[2] := '7x4x29xxx';
      board[3] := 'xxxxxxxxx';
      board[4] := '5xx7xxxx8';
      board[5] := 'x1xxxxxxx';
      board[6] := '2x3x9xxxx';
      board[7] := '46xxx2x7x';
      board[8] := 'xxxxx6x2x';
      board[9] := 'xx9xxxx3x';
    {$ENDIF}

    for x := 1 to 9 do
    begin
      for y := 1 to 9 do
      begin
        if board[x][y] <> 'x' then
          (FindComponent('Edt' + IntToStr(x) + IntToStr(y)) as TEdit).Text := board[x][y];
      end;
    end;
  {$IFEND}
{$ENDIF}
end;

function TFrmSudokuSolver.GetBlock(x, y: Integer): Integer;
begin
  // Compute in which block the given coords lie
  // Index: 1
  Result := 3 * ((x - 1) div 3) + ((y - 1) div 3) + 1;
end;

function TFrmSudokuSolver.GetBlockCoords(block: Integer): TPointList;
var
  startRow, startCol: Integer;
  x, y: Integer;
begin
  Result := TPointList.Create;

  startRow := 3 * ((block - 1) div 3) + 1;
  startCol := 3 * ((block - 1) mod 3) + 1;

  for x := startRow to startRow + 2 do
      for y := startCol to startCol + 2 do
        Result.Add(Point(x, y));

end;

function TFrmSudokuSolver.GetDigitsInBlock(board: TBoard;
  block: Integer): TAllowedDigits;
var
  points: TPointList;
  point: TPoint;
begin
  Result := [];
  points := GetBlockCoords(block);

  for point in points do
  begin
    if board[point.X][point.Y] <> 0 then
    begin
      Result := Result + [board[point.X][point.Y]];
    end;
  end;

  points.Free;
end;

function TFrmSudokuSolver.GetDigitsInColumn(board: TBoard;
  col: Integer): TAllowedDigits;
var
  i: Integer;
begin
  Result := [];
  for i := 1 to 9 do
  begin
    if board[i][col] <> 0 then
    begin
      Result := Result + [board[i][col]];
    end;
  end;
end;

function TFrmSudokuSolver.GetDigitsInRow(board: TBoard;
  row: Integer): TAllowedDigits;
var
  i: Integer;
begin
  Result := [];
  for i := 1 to 9 do
  begin
    if board[row][i] <> 0 then
    begin
      Result := Result + [board[row][i]];
    end;
  end;
end;

function TFrmSudokuSolver.GetFreePositions(board: TBoard): TPointList;
var
  x, y: Integer;
begin
  Result := TPointList.Create;

  for x := 1 to 9 do
    for y := 1 to 9 do
      if board[x][y] = 0 then
        Result.Add(Point(x, y));

end;

function TFrmSudokuSolver.GetValidDigits(board: TBoard; x,
  y: Integer): TAllowedDigits;
var
  all, row, col, block: TAllowedDigits;
  blockNumber: Integer;
begin
  row := GetDigitsInRow(board, x);
  col := GetDigitsInColumn(board, y);

  blockNumber := GetBlock(x, y);
  block := GetDigitsInBlock(board, blockNumber);

  all := [1,2,3,4,5,6,7,8,9];

  Result := all - (block + row + col);
end;

function TFrmSudokuSolver.heuristic(board: TBoard;
  freePositions: TPointList): TPoint;
var
  bestResult: Integer;
  item: TPoint;
  validDigits: TAllowedDigits;
  count: Integer;

  function countValidDigits: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to 9 do
    begin
      if i in validDigits then
        inc(Result);
    end;
  end;
begin
  Result := Point(0, 0);
  bestResult := 10; // Unreachable bad

  for item in freePositions do
  begin
    validDigits := getValidDigits(board, item.X, item.Y);
    count := countValidDigits;

    if count < bestResult then
    begin
      bestResult := count;
      Result := item;

      if count = 1 then
        Exit;
    end;
  end;
end;

function TFrmSudokuSolver.ReadBoard: TBoard;
var
  x, y: Integer;
begin
  for x := 1 to 9 do
  begin
    for y := 1 to 9 do
      begin
        Result[x][y] := StrToIntDef((FindComponent(Format('Edt%d%d', [x, y])) as TEdit).Text, 0);
      end;
  end;
end;

function TFrmSudokuSolver.SolveBacktrack(board: TBoard;
  freePositions: TPointList): boolean;
var
  item: TPoint;
  digits: TAllowedDigits;
  digit: Integer;
begin
  if freePositions.Count = 0 then
  begin
    WriteBoard(board);
    Result := true;
  end
  else
  begin
    // There are free spaces
    Result := false;

    // Get one and try to solve
    item := heuristic(board, freePositions);
    freePositions.Remove(item);

{
    // Use this if you do not want to use the heuristic
    item := freePositions[0];
    freePositions.Delete(0);
}

    digits := GetValidDigits(board, item.X, item.Y);
    for digit := 1 to 9 do
    begin
      if digit in digits then
      begin
        board[item.X, item.Y] := digit;

        Result := SolveBacktrack(board, freePositions);
        if Result then
          Exit;

        board[item.X, item.Y] := 0;
      end;
    end;

    freePositions.Add(item);
  end;
end;

procedure TFrmSudokuSolver.WriteBoard(board: TBoard);
var
  x, y: Integer;
begin
  for x := 1 to 9 do
  begin
    for y := 1 to 9 do
      begin
        (FindComponent(Format('Edt%d%d', [x, y])) as TEdit).Text := IntToStr(board[x][y]);
      end;
  end;
end;

end.
