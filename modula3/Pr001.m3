(*
 * Problem 1
 *
 * 05 October 2001
 *
 * If we list all the natural numbers below 10 that are multiples of 3 or 5,
 * we get 3, 5, 6 and 9. The sum of these multiples is 23.
 *
 * Find the sum of all the multiples of 3 or 5 below 1000.
 *
 *)

MODULE Pr001;

IMPORT IO;

VAR
  total : INTEGER := 0;

PROCEDURE Run () =
  BEGIN
    FOR i := 1 TO 999 DO
      IF (i MOD 3) = 0 OR (i MOD 5) = 0 THEN
        total := total + i;
      END;
    END;
    IO.PutInt (total);
    IO.Put ("\n");
  END Run;

BEGIN
END Pr001.
