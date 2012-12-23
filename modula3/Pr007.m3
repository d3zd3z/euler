(*
 * Problem 7
 *
 * 28 December 2001
 *
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
 * that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 *
 * 104743
 *)

MODULE Pr007;

IMPORT Fmt;
IMPORT IO;
IMPORT Sieve;

PROCEDURE Run () =
  VAR
    sieve : Sieve.T := NEW(Sieve.T).init();
    p := 2;
    count := 1;
  BEGIN
    WHILE count < 10001 DO
      p := sieve.nextPrime(p);
      count := count + 1;
    END;

    IO.Put(Fmt.Int(p) & "\n");
  END Run;

BEGIN
END Pr007.
