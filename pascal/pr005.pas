program pr005;

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

  function gcd(a, b : LongInt) : LongInt;
  var
    r : LongInt;
  begin
    r := a mod b;
    while r > 0 do
      begin
	a := b;
	b := r;
	r := a mod b
      end;
      gcd := b
  end;

  function lcm(a, b : LongInt) : LongInt;
  begin
    lcm := (a div gcd(a, b)) * b
  end;

var
  Total : LongInt = 1;
  I : LongInt;

begin
  for I := 2 to 20 do
    Total := lcm(Total, I);

  writeln(Total)
end.
