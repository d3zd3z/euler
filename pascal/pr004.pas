program pr004;

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
**)

  function Reverse(Arg : LongInt) : LongInt;
  begin
    Reverse := 0;
    while Arg > 0 do
      begin
	Reverse := Reverse * 10 + Arg mod 10;
	Arg := Arg div 10
      end;
  end;

  function IsPalindrome(Arg : LongInt) : Boolean;
  begin
    IsPalindrome := (Arg = Reverse(Arg))
  end;

var
  A, B, C : LongInt;
  Best : LongInt = 0;

begin
  for A := 100 to 999 do
    for B := A to 999 do
      begin
	C := A * B;
	if (C > Best) and IsPalindrome(C) then
	  Best := C
      end;
  writeln(Best);
end.
