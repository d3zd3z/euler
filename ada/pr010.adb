----------------------------------------------------------------------
--  Problem 10
--
--  08 February 2002
--
--  The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
--
--  Find the sum of all the primes below two million.
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;
with Prime_Sieve;

procedure Pr010 is

   --  Result doesn't fit in a 32-bit number.

   Upper_Bound : constant := 2_000_000;

   Sum : Long_Natural := 0;
   Prime : Natural := 2;

begin
   while Prime < Upper_Bound loop
      Sum := Sum + Long_Natural (Prime);
      Prime := Prime_Sieve.Next_Prime (Prime);
   end loop;

   Print_Result (Sum);
end Pr010;
