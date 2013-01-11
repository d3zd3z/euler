(*
 * Problem 21
 *
 * 05 July 2002
 *
 * Let d(n) be defined as the sum of proper divisors of n (numbers less than
 * n which divide evenly into n).
 * If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
 * and each of a and b are called amicable numbers.
 *
 * For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
 * 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
 * 2, 4, 71 and 142; so d(284) = 220.
 *
 * Evaluate the sum of all the amicable numbers under 10000.
 *
 * 31626
 *)

{$mode objfpc}
program pr021;

uses sieve;

var
   s : TSieve;

   function divisorSum(n : longint) : longint;
   var
      ds : Tdivisors;
      tmp : longint;
   begin
      ds := s.divisors(n);
      result := 0;
      for tmp in ds do
	 result := result + tmp;

      { Subtract out the original number to get proper divisors. }
      result := result - n;
   end;

   function isAmicable(n : longint) : boolean;
   var
      other : longint;
   begin
      other := divisorSum(n);
      result := (n <> other) and (n = divisorSum(other));
   end;

var
   total : longint = 0;
   i : longint;

begin
   s := TSieve.create;
   for i := 2 to 9999 do
      if isAmicable(i) then
         total := total + i;
   writeln(total);
end.
