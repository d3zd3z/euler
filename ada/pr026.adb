----------------------------------------------------------------------
--  Problem 26

--
--  13 September 2002
--
--  A unit fraction contains 1 in the numerator. The decimal representation of
--  the unit fractions with denominators 2 to 10 are given:
--
--      ^1/[2]  =  0.5
--      ^1/[3]  =  0.(3)
--      ^1/[4]  =  0.25
--      ^1/[5]  =  0.2
--      ^1/[6]  =  0.1(6)
--      ^1/[7]  =  0.(142857)
--      ^1/[8]  =  0.125
--      ^1/[9]  =  0.(1)
--      ^1/[10] =  0.1
--
--  Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can
--  be seen that ^1/[7] has a 6-digit recurring cycle.
--
--  Find the value of d < 1000 for which ^1/[d] contains the longest recurring
--  cycle in its decimal fraction part.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Prime_Sieve;
--  with Euler; use Euler;

procedure Pr026 is

   function Dlog (N : Natural) return Natural;
   --  Compute 'k' for 10^k = 1 (mod N).

   function Dlog (N : Natural) return Natural is
      Temp : Natural := 10 mod N;
      K : Natural := 1;
   begin
      while Temp /= 1 loop
         K := K + 1;
         Temp := (Temp * 10) mod N;
      end loop;

      return K;
   end Dlog;

   P : Natural := 7;
   Size : Natural;

   Largest : Natural := 0;
   Largest_Value : Natural := 0;

begin
   while P < 1000 loop
      Size := Dlog (P);
      if Size > Largest then
         Largest := Size;
         Largest_Value := P;
      end if;

      P := Prime_Sieve.Next_Prime (P);
   end loop;

   Put_Line (Natural'Image (Largest_Value));
end Pr026;

