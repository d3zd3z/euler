----------------------------------------------------------------------
--  Problem 7
--
--  28 December 2001
--
--  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
--  that the 6th prime is 13.
--
--  What is the 10 001st prime number?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Prime_Sieve;

procedure Pr007 is

   Sieve : Prime_Sieve.T (200000);

   Prime : Natural := 2;

begin
   for I in 1 .. 10_000 loop
      Prime := Sieve.Next_Prime (Prime);
   end loop;

   Put_Line (Natural'Image (Prime));
end Pr007;

