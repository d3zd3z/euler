(* Problem description system. *)

INTERFACE Problems;

TYPE
  Tproblem = RECORD
    number : INTEGER;
    run : PROCEDURE ();
  END;

PROCEDURE Count () : CARDINAL;
PROCEDURE Get (n : CARDINAL) : Tproblem;

END Problems.
