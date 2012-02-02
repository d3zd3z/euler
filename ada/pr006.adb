----------------------------------------------------------------------
--  Problem 6
--
--  14 December 2001
--
--  The sum of the squares of the first ten natural numbers is,
--
--  1^2 + 2^2 + ... + 10^2 = 385
--
--  The square of the sum of the first ten natural numbers is,
--
--  (1 + 2 + ... + 10)^2 = 55^2 = 3025
--
--  Hence the difference between the sum of the squares of the first ten
--  natural numbers and the square of the sum is 3025 − 385 = 2640.
--
--  Find the difference between the sum of the squares of the first one
--  hundred natural numbers and the square of the sum.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;

procedure Pr006 is

   Sum_Of_Squares : Natural := 0;
   Sums : Natural := 0;

begin
   for I in Natural range 1 .. 100 loop
      Sums := Sums + I;
      Sum_Of_Squares := Sum_Of_Squares + I * I;
   end loop;

   Sums := Sums * Sums;

   Put_Line (Natural'Image (Sums - Sum_Of_Squares));
end Pr006;

