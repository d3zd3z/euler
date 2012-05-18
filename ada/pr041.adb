----------------------------------------------------------------------
--  Problem 41

--
--  11 April 2003
--
--
--  We shall say that an n-digit number is pandigital if it makes use of
--  all the digits 1 to n exactly once. For example, 2143 is a 4-digit
--  pandigital and is also prime.
--
--  What is the largest n-digit pandigital prime that exists?
--
--
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Miller_Rabin; use Miller_Rabin;
--  with Prime_Sieve;
with Euler;

procedure Pr041 is

   procedure Next_Permutation is new Euler.Next_Permutation
      (Character, String);

   Largest : Natural := 0;
   Text : String := "1234567";
   Done : Boolean;
   N : Natural;

begin
   loop
      N := Natural'Value (Text);
      --  if Prime_Sieve.Is_Prime (N) then
      if Is_Prime (N) then
         --  Numbers always increase.
         Largest := N;
      end if;

      Next_Permutation (Text, Done);
      exit when Done;
   end loop;

   Put_Line (Natural'Image (Largest));
end Pr041;

