(*
 * Problem 3
 *
 * 02 November 2001
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 *
 * 6857
 *)

MODULE Pr003;

IMPORT IO;

PROCEDURE Run () =
  VAR
    base : LONGINT := 600851475143L;
    p : INTEGER := 2;

  PROCEDURE Next(x : INTEGER) : INTEGER =
    BEGIN
      IF x = 2 THEN
        RETURN 3;
      ELSE
        RETURN x + 2;
      END;
    END Next;

  BEGIN
    WHILE base # 1L DO
      IF base MOD VAL (p, LONGINT) = 0L THEN
        base := base DIV VAL (p, LONGINT);
      ELSE
        p := Next(p);
      END;
    END;
    IO.PutInt(p);
    IO.Put ("\n");
  END Run;

BEGIN
END Pr003.
