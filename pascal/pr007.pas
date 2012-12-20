program pr007;

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
**)

{$mode objfpc}

uses sieve;

var
  sv : TSieve;
  p, count : longint;

begin
  sv := TSieve.create;
  count := 1;
  p := 2;
  while count < 10001 do
    begin
      p := sv.nextPrime(p);
      count := count + 1;
    end;
  writeln(p)
end.
