program pr003;

(*
 * Problem 3
 *
 * 02 November 2001
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 *
 * 6857
**)

var
  Base : Int64 = 600851475143;
  P : Integer = 2;

  function Next(X: Integer) : Integer;
  begin
    if X = 2 then
      Next := 3
    else
      Next := X + 2
  end;

begin
  while Base <> 1 do
    begin
      if Base mod P = 0 then
	Base := Base div P
      else
	P := Next(P);
    end;
  writeln(P)
end.
