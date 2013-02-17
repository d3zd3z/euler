----------------------------------------------------------------------
--  Problem 58
--
--  05 December 2003
--
--
--  Starting with 1 and spiralling anticlockwise in the following way, a
--  square spiral with side length 7 is formed.
--
--  37 36 35 34 33 32 31
--  38 17 16 15 14 13 30
--  39 18  5  4  3 12 29
--  40 19  6  1  2 11 28
--  41 20  7  8  9 10 27
--  42 21 22 23 24 25 26
--  43 44 45 46 47 48 49
--
--  It is interesting to note that the odd squares lie along the bottom
--  right diagonal, but what is more interesting is that 8 out of the 13
--  numbers lying along both diagonals are prime; that is, a ratio of 8/
--  13 ≈ 62%.
--
--  If one complete new layer is wrapped around the spiral above, a
--  square spiral with side length 9 will be formed. If this process is
--  continued, what is the side length of the square spiral for which the
--  ratio of primes along both diagonals first falls below 10%?
--
--  26241
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Miller_Rabin;

procedure Pr058 is

   subtype Work_Type is Natural;

   --  Initial values, based on the 1x1 'square' containing the number 1.
   Primes : Work_Type := 0;
   Non_Primes : Work_Type := 1;
   Size : Work_Type := 1;

   --  One less than the width of the square.
   Span : Work_Type := 0;

begin
   loop
      Span := Span + 2;

      for I in 1 .. 4 loop
         Size := Size + Span;
         if Miller_Rabin.Is_Prime (Natural (Size)) then
            Primes := Primes + 1;
         else
            Non_Primes := Non_Primes + 1;
         end if;
      end loop;

      exit when Primes * 10 < (Primes + Non_Primes);
   end loop;

   Put_Line (Work_Type'Image (Span + 1));
end Pr058;
