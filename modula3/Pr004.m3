(*
 * Problem 4
 *
 * 16 November 2001
 *
 * A palindromic number reads the same both ways. The largest palindrome made
 * from the product of two 2-digit numbers is 9009 = 91 x 99.
 *
 * Find the largest palindrome made from the product of two 3-digit numbers.
 *
 * 906609
 *)

MODULE Pr004;

IMPORT Fmt;
IMPORT IO;

PROCEDURE Reverse (arg : INTEGER) : INTEGER =
  VAR
    result : INTEGER := 0;
  BEGIN
    WHILE arg > 0 DO
      result := result * 10 + arg MOD 10;
      arg := arg DIV 10;
    END;
    RETURN result;
  END Reverse;

PROCEDURE IsPalindrome (arg : INTEGER) : BOOLEAN =
  BEGIN
    RETURN arg = Reverse (arg);
  END IsPalindrome;

PROCEDURE Run () =
  VAR
    largest : INTEGER := 0;
  BEGIN
    FOR a := 100 TO 999 DO
      FOR b := a TO 999 DO
        VAR
          c := a * b;
        BEGIN
          IF c > largest AND IsPalindrome (c) THEN
            largest := c;
          END;
        END;
      END;
    END;

    IO.Put (Fmt.Int (largest) & "\n");
  END Run;

BEGIN
END Pr004.
