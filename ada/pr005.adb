----------------------------------------------------------------------
--  Problem 5
--
--  30 November 2001
--
--  2520 is the smallest number that can be divided by each of the numbers
--  from 1 to 10 without any remainder.
--
--  What is the smallest positive number that is evenly divisible by all of
--  the numbers from 1 to 20?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;

procedure Pr005 is

   function Gcd (A, B : Natural) return Natural;
   function Lcm (A, B : Natural) return Natural;

   function Lcm (A, B : Natural) return Natural is
   begin
      return (A * B) / Gcd (A, B);
   end Lcm;

   function Gcd (A, B : Natural) return Natural is
   begin
      if B = 0 then
         return A;
      else
         return Gcd (B, A mod B);
      end if;
   end Gcd;

   Accumulator : Natural := 1;

begin
   for I in Natural range 2 .. 20 loop
      Accumulator := Lcm (Accumulator, I);
   end loop;

   Put_Line (Natural'Image (Accumulator));
end Pr005;

