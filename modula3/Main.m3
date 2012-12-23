(* Driver for Project euler problems. *)

MODULE Main EXPORTS Main;

IMPORT IO;
IMPORT RTArgs;
IMPORT Scan;
IMPORT Fmt;

IMPORT Pr001;
IMPORT Pr002;
IMPORT Pr003;
IMPORT Pr004;
IMPORT Pr005;

EXCEPTION UsageError;

VAR
  number : INTEGER;
  ran : BOOLEAN := FALSE;

TYPE
  Tproblem = RECORD
    number : INTEGER;
    run : PROCEDURE ();
  END;

  TproblemArray = ARRAY OF Tproblem;

CONST
  problems = TproblemArray {
  Tproblem { number := 1, run := Pr001.Run },
  Tproblem { number := 2, run := Pr002.Run },
  Tproblem { number := 3, run := Pr003.Run },
  Tproblem { number := 4, run := Pr004.Run },
  Tproblem { number := 5, run := Pr005.Run }
  };

BEGIN
  TRY
    IF RTArgs.ArgC () # 2 THEN
      RAISE UsageError;
    END;

    number := Scan.Int(RTArgs.GetArg (1));

    FOR i := FIRST (problems) TO LAST (problems) DO
      IF number = problems[i].number THEN
        ran := TRUE;
        problems[i].run ();
      END;
    END;
    IF NOT ran THEN
      IO.Put ("Unknown problem: " & Fmt.Int (number) & "\n");
    END;

  EXCEPT
  ELSE
    IO.Put ("Error\n\nUsage: euler num\n");
  END;
END Main.
