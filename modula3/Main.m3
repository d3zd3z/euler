(* Driver for Project euler problems. *)

MODULE Main EXPORTS Main;

IMPORT IO;
IMPORT RTArgs;
IMPORT Scan;
IMPORT Fmt;

IMPORT FloatMode;
IMPORT Lex;

IMPORT Problems;

EXCEPTION UsageError;

VAR
  number : INTEGER;
  ran : BOOLEAN := FALSE;

BEGIN
  TRY
    IF RTArgs.ArgC () # 2 THEN
      RAISE UsageError;
    END;

    number := Scan.Int(RTArgs.GetArg (1));

    FOR i := 0 TO Problems.Count () - 1 DO
      VAR
        problem := Problems.Get (i);
      BEGIN
        IF number = problem.number THEN
          ran := TRUE;
          problem.run ();
        END;
      END;
    END;
    IF NOT ran THEN
      IO.Put ("Unknown problem: " & Fmt.Int (number) & "\n");
    END;

  EXCEPT
  | UsageError =>
    IO.Put("Usage error\n\nUsage: euler num\n");
  | Lex.Error, FloatMode.Trap =>
    IO.Put("That doesn't seem to be anumber\n");
  (* ELSE
    IO.Put ("Error\n\nUsage: euler num\n"); *)
  END;
END Main.
