----------------------------------------------------------------------
--  Problem 28
--
--  11 October 2002
--
--  Starting with the number 1 and moving to the right in a clockwise
--  direction a 5 by 5 spiral is formed as follows:
--
--  21 22 23 24 25
--  20  7  8  9 10
--  19  6  1  2 11
--  18  5  4  3 12
--  17 16 15 14 13
--
--  It can be verified that the sum of the numbers on the diagonals is 101.
--
--  What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
--  formed in the same way?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;

procedure Pr028 is

   function Ring_Sum (N : Natural) return Natural;

   function Ring_Sum (N : Natural) return Natural is
   begin
      return 4 * N * N - 6 * N + 6;
   end Ring_Sum;

   A : Natural;
   Sum : Natural := 1;

begin
   A := 3;
   while A < 1002 loop
      Sum := Sum + Ring_Sum (A);
      A := A + 2;
   end loop;

   Put_Line (Natural'Image (Sum));
end Pr028;
