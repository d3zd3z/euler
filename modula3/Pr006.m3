(*
 * Problem 6
 *
 * 14 December 2001
 *
 * The sum of the squares of the first ten natural numbers is,
 *
 * 1^2 + 2^2 + ... + 10^2 = 385
 *
 * The square of the sum of the first ten natural numbers is,
 *
 * (1 + 2 + ... + 10)^2 = 55^2 = 3025
 *
 * Hence the difference between the sum of the squares of the first ten
 * natural numbers and the square of the sum is 3025 − 385 = 2640.
 *
 * Find the difference between the sum of the squares of the first one
 * hundred natural numbers and the square of the sum.
 *
 * 25164150
 *)

MODULE Pr006;

IMPORT Fmt;
IMPORT IO;

PROCEDURE Run () =
  VAR
    sumsq : INTEGER := 0;
    sqsum : INTEGER := 0;
  BEGIN
    FOR i := 1 TO 100 DO
      sumsq := sumsq + i * i;
      sqsum := sqsum + i;
    END;

    sqsum := sqsum * sqsum;

    IO.Put (Fmt.Int (sqsum - sumsq) & "\n");
  END Run;

BEGIN
END Pr006.
