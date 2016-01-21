program SudokuSolver;

uses
  Vcl.Forms,
  FormU in 'FormU.pas' {FrmSudokuSolver};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSudokuSolver, FrmSudokuSolver);
  Application.Run;
end.
