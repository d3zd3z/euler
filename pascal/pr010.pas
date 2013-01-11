program pr010;

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
**)

uses sieve;

{ Note that the result is larger than a 32-bit int. }

var
  answer : int64 = 0;
  p : longint = 2;
  sv : TSieve;
begin
  sv := TSieve.create;
  while p < 2000000 do
    begin
      answer := answer + p;
      p := sv.nextPrime(p)
    end;

  writeln(answer);
  { p := 2;
  while p < 2000000 do
    begin
      writeln(p);
      p := sv.nextPrime(p);
    end; }
end.
