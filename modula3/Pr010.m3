(*
 * Problem 10
 *
 * 08 February 2002
 *
 * The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million.
 *
 * 142913828922
 *)

(* Note that the result is larger than 32-bits *)

MODULE Pr010;

IMPORT Fmt;
IMPORT IO;
IMPORT Sieve;

(* Unfortunately, it seems that Fmt.LongInt prints the result
   incorrectly.  That means that this code will only run correctly on a
   64-bit system, where INTEGER is a 64-bit type. *)

PROCEDURE Run() =
  VAR
    sieve : Sieve.T := NEW(Sieve.T).init();
    p := 2;
    total := 0;
  BEGIN
    WHILE p < 2000000 DO
      (* total := total + VAL(p, LONGINT); *)
      total := total + p;
      p := sieve.nextPrime(p);
    END;

    (* It as lovely as it seems, Fmt.LongInt prints the answer
       incorrectly. *)
    (* IO.Put(Fmt.LongInt(total) & "\n"); *)

    (* This works on 32-bit platforms. *)
    (* IO.Put(Fmt.Int(NARROW(total, INTEGER)) & "\n"); *)
    IO.Put(Fmt.Int(total) & "\n");
  END Run;

BEGIN
END Pr010.
