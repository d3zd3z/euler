program pr006;

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
**)

var
  I : LongInt;
  SumSq : LongInt = 0;
  SqSum : LongInt = 0;

begin
  for I := 1 to 100 do
    begin
      SumSq := SumSq + I * I;
      SqSum := SqSum + I;
    end;
  SqSum := SqSum * SqSum;

  writeln(SqSum - SumSq)
end.
