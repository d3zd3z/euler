----------------------------------------------------------------------
--  Problem 12
--
--  08 March 2002
--
--  The sequence of triangle numbers is generated by adding the natural
--  numbers. So the 7^th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 =
--  28. The first ten terms would be:
--
--  1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
--
--  Let us list the factors of the first seven triangle numbers:
--
--       1: 1
--       3: 1,3
--       6: 1,2,3,6
--      10: 1,2,5,10
--      15: 1,3,5,15
--      21: 1,3,7,21
--      28: 1,2,4,7,14,28
--
--  We can see that 28 is the first triangle number to have over five
--  divisors.
--
--  What is the value of the first triangle number to have over five hundred
--  divisors?
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Euler; use Euler;

with Heap_Sieve;

procedure Pr012 is

   Sieve : Heap_Sieve.T;

   --  Build up this vector to easily find more primes.
   package Natural_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Natural);

   Primes : Natural_Vectors.Vector;

   function Nth_Prime (Index : Positive) return Natural;
   --  Return the nth prime, starting with 1.

   function Divisor_Count (Number : Natural) return Natural;

   function Divisor_Count (Number : Natural) return Natural is
      Count : Natural := 1;
      Prime_Index : Positive := Positive'First;
      Prime : Natural := Nth_Prime (Prime_Index);
      Tmp : Natural := Number;
      Divide_Count : Natural;
   begin
      while Tmp > 1 loop
         Divide_Count := 0;
         while Tmp mod Prime = 0 loop
            Tmp := Tmp / Prime;
            Divide_Count := Divide_Count + 1;
         end loop;

         Count := Count * (Divide_Count + 1);

         if Tmp > 1 then
            Prime_Index := Prime_Index + 1;
            Prime := Nth_Prime (Prime_Index);
         end if;

      end loop;

      return Count;
   end Divisor_Count;


   function Nth_Prime (Index : Positive) return Natural is
      Prime : Natural;
   begin
      while Primes.Last_Index < Index loop
         Sieve.Next (Prime);
         Primes.Insert (Before   => Primes.Last_Index + 1,
                        New_Item => Prime);
      end loop;

      return Primes.Element (Index);
   end Nth_Prime;

   Number : Natural := 1;
   Step : Natural := 1;

begin
   loop
      if Divisor_Count (Number) > 500 then
         Print_Result (Number);
         exit;
      end if;

      Step := Step + 1;
      Number := Number + Step;
   end loop;
end Pr012;
