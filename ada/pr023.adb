----------------------------------------------------------------------
--  Problem 23

--
--  02 August 2002
--
--  A perfect number is a number for which the sum of its proper divisors is
--  exactly equal to the number. For example, the sum of the proper divisors
--  of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
--  number.
--
--  A number n is called deficient if the sum of its proper divisors is less
--  than n and it is called abundant if this sum exceeds n.
--
--  As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
--  smallest number that can be written as the sum of two abundant numbers is
--  24. By mathematical analysis, it can be shown that all integers greater
--  than 28123 can be written as the sum of two abundant numbers. However,
--  this upper limit cannot be reduced any further by analysis even though it
--  is known that the greatest number that cannot be expressed as the sum of
--  two abundant numbers is less than this limit.
--
--  Find the sum of all the positive integers which cannot be written as the
--  sum of two abundant numbers.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;

procedure Pr023 is

   package Natural_Vectors is new Ada.Containers.Vectors
      (Index_Type => Natural, Element_Type => Natural);
   subtype Natural_Vector is Natural_Vectors.Vector;

   --  To compute a bunch of abundants, just compute a prime sieve up until a
   --  limit, but actually count the divisors.
   Limit : constant := 28123;

   Abundants : Natural_Vector;

   procedure Compute_Abundants;
   --  Compute all of the abundant numbers up until the given limit.

   function Answer return Natural;
   --  After computing the abundants, compute the answer.

   procedure Compute_Abundants is
      Counts : array (1 .. Limit) of Natural := (1 => 0, others => 1);
      N : Natural;
   begin
      --  Run the sieve.
      for Base in 2 .. Limit loop
         N := Base + Base;
         while N <= Limit loop
            Counts (N) := Counts (N) + Base;
            N := N + Base;
         end loop;
      end loop;

      --  Find all of the numbers that are abundant.
      for Num in 12 .. Limit loop
         if Counts (Num) > Num then
            Abundants.Append (Num);
         end if;
      end loop;
   end Compute_Abundants;

   function Answer return Natural is
      Summable : array (1 .. Limit) of Boolean := (others => False);
      Num : Natural;
      Sum : Natural := 0;
   begin
      for I of Abundants loop
         for J of Abundants loop
            Num := I + J;
            exit when Num > Limit;
            Summable (Num) := True;
         end loop;
      end loop;

      for I in Summable'Range loop
         if not Summable (I) then
            Sum := Sum + I;
         end if;
      end loop;

      return Sum;
   end Answer;

begin
   Compute_Abundants;
   Put_Line (Natural'Image (Answer));
end Pr023;

