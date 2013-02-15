----------------------------------------------------------------------
--  Problem 53

--
--  26 September 2003
--
--
--  There are exactly ten ways of selecting three from five, 12345:
--
--  123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
--
--  In combinatorics, we use the notation, ^5C[3] = 10.
--
--  In general,
--
--  ^nC[r] = n!       ,where r ≤ n, n! = nx(n−1)x...x3x2x1, and 0! = 1.
--           r!(n−r)!
--
--  It is not until n = 23, that a value exceeds one-million: ^23C[10] =
--  1144066.
--
--  How many, not necessarily distinct, values of  ^nC[r], for 1 ≤ n ≤
--  100, are greater than one-million?
--
--  4075
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

--  The table of combinations is the same as Pascal's triangle.  By
--  using a saturating arithmetic, we can determine how many exceed 1
--  million without having to compute values more than 2x that size.

procedure Pr053 is

   Limit : constant := 1_000_000;

   Counter : Natural := 0;

   function Add (A, B : Natural) return Natural;
   --  Perform the saturated addition, as well, as updating the
   --  counter if we do saturate.

   function Add (A, B : Natural) return Natural is
      Tmp : Natural := A + B;
   begin
      if Tmp > Limit then
         Counter := Counter + 1;
         Tmp := Limit;
      end if;

      return Tmp;
   end Add;

   Buffer : array (1 .. 101) of Natural := (1 => 1, others => 0);

begin

   for I in 2 .. 101 loop
      for J in reverse 2 .. I loop
         Buffer (J) := Add (Buffer (J), Buffer (J - 1));
      end loop;
   end loop;

   Put_Line (Natural'Image (Counter));

end Pr053;
