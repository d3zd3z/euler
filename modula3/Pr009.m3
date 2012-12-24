(*
 * Problem 9
 *
 * 25 January 2002
 *
 * A Pythagorean triplet is a set of three natural numbers, a < b < c, for
 * which,
 *
 * a^2 + b^2 = c^2
 *
 * For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
 *
 * There exists exactly one Pythagorean triplet for which a + b + c = 1000.
 * Find the product abc.
 *
 * 31875000
 *)

MODULE Pr009;

IMPORT Fmt;
IMPORT IO;

PROCEDURE Run() =
  VAR
    c : INTEGER;
  BEGIN
    FOR a := 1 TO 999 DO
      FOR b := a + 1 TO 999 DO
        c := 1000 - a - b;
        IF c > b AND a*a + b*b = c*c THEN
          IO.Put(Fmt.Int(a*b*c) & "\n");
        END;
      END;
    END;
  END Run;

BEGIN
END Pr009.
