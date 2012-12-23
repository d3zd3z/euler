(*
 * Problem 5
 *
 * 30 November 2001
 *
 * 2520 is the smallest number that can be divided by each of the numbers
 * from 1 to 10 without any remainder.
 *
 * What is the smallest positive number that is evenly divisible by all of
 * the numbers from 1 to 20?
 *
 * 232792560
 *)

MODULE Pr005;

IMPORT Fmt;
IMPORT IO;

PROCEDURE Gcd (a, b : INTEGER) : INTEGER =
  VAR
    r : INTEGER;
  BEGIN
    r := a MOD b;
    WHILE r > 0 DO
      a := b;
      b := r;
      r := a MOD b;
    END;

    RETURN b;
  END Gcd;

PROCEDURE Lcm (a, b : INTEGER) : INTEGER =
  BEGIN
    RETURN (a DIV Gcd (a, b)) * b;
  END Lcm;

PROCEDURE Run () =
  VAR
    total : INTEGER := 1;
  BEGIN
    FOR i := 2 TO 20 DO
      total := Lcm (total, i);
    END;
    IO.Put (Fmt.Int (total) & "\n");
  END Run;

BEGIN
END Pr005.
