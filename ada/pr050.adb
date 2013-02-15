----------------------------------------------------------------------
--  Problem 50

--
--  15 August 2003
--
--
--  The prime 41, can be written as the sum of six consecutive primes:
--
--  41 = 2 + 3 + 5 + 7 + 11 + 13
--
--  This is the longest sum of consecutive primes that adds to a prime
--  below one-hundred.
--
--  The longest sum of consecutive primes below one-thousand that adds to
--  a prime, contains 21 terms, and is equal to 953.
--
--  Which prime, below one-million, can be written as the sum of the most
--  consecutive primes?
--
--  997651
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;
with Prime_Sieve;

procedure Pr050 is

   subtype Natural_Vector is Prime_Sieve.Natural_Vectors.Vector;

   procedure Primes_Upto (Result : out Natural_Vector; Limit : Natural);
   --  Fill the vector with all of the primes up to the given result.

   --  Test
   Primes : Natural_Vector;

   procedure Primes_Upto (Result : out Natural_Vector; Limit : Natural)
   is
      P : Natural := 2;
   begin
      Result.Clear;

      loop
         exit when P > Limit;
         Result.Append (P);
         P := Prime_Sieve.Next_Prime (P);
      end loop;
   end Primes_Upto;

   Largest_Count : Natural := 0;
   Largest_Prime : Natural := 0;
   Sum : Natural := 0;

begin
   --  Tacky check because of bug where Next_Prime doesn't expand the sieve.
   if not Prime_Sieve.Is_Prime (1_000_003) then
      raise Constraint_Error;
   end if;

   Primes_Upto (Primes, 1_000_000);

   for I in Primes.First_Index .. Primes.Last_Index loop
      Sum := 0;
      for J in I .. Primes.Last_Index loop
         Sum := Sum + Primes.Element (J);
         exit when Sum > 1_000_000;
         if J - I + 1 > Largest_Count and then Prime_Sieve.Is_Prime (Sum) then
            Largest_Count := J - I + 1;
            Largest_Prime := Sum;
         end if;
      end loop;
   end loop;

   Put_Line (Natural'Image (Largest_Prime));

end Pr050;
