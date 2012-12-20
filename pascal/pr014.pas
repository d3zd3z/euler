(*
 * Problem 14
 *
 * 05 April 2002
 *
 * The following iterative sequence is defined for the set of positive
 * integers:
 *
 * n → n/2 (n is even)
 * n → 3n + 1 (n is odd)
 *
 * Using the rule above and starting with 13, we generate the following
 * sequence:
 *
 * 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
 *
 * It can be seen that this sequence (starting at 13 and finishing at 1)
 * contains 10 terms. Although it has not been proved yet (Collatz Problem),
 * it is thought that all starting numbers finish at 1.
 *
 * Which starting number, under one million, produces the longest chain?
 *
 * NOTE: Once the chain starts the terms are allowed to go above one million.
 *
 * 837799
 *)

{ Two steps here.  Implement a simple solution.  Make general with an
  interface.  Use that to cache. }

program pr014;

  function chainLen(n : longint) : longint;
  begin
    if n = 1 then
      chainLen := 1
    else if (n and 1) = 0 then
      chainLen := 1 + chainLen(n >> 1)
    else
      chainLen := 1 + chainLen(3 * n + 1)
  end;

  function compute : longint;
  var
    max : longint = 0;
    i : longint;
    len : longint;
  begin
    compute := 0;
    for i := 1 to 999999 do
      begin
	len := chainLen(i);
	if len > max then
	  begin
	    max := len;
	    compute := i;
	  end;
      end;
  end;

begin
  writeln(compute)
end.
