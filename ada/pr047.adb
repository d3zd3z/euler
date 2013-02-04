----------------------------------------------------------------------
--  Problem 47
--
--  04 July 2003
--
--
--  The first two consecutive numbers to have two distinct prime factors
--  are:
--
--  14 = 2 x 7
--  15 = 3 x 5
--
--  The first three consecutive numbers to have three distinct prime
--  factors are:
--
--  644 = 2^2 x 7 x 23
--  645 = 3 x 5 x 43
--  646 = 2 x 17 x 19.
--
--  Find the first four consecutive integers to have four distinct primes
--  factors. What is the first of these numbers?
--
--  134043
----------------------------------------------------------------------

with Ada.Containers;
with Prime_Sieve;
with Euler; use Euler;

procedure Pr047 is

   procedure Solve (Size : Natural);

   procedure Solve (Size : Natural) is
      Numbers : array (1 .. Size) of Natural;
      Factors : array (1 .. Size) of Prime_Sieve.Factor_Vectors.Vector;
      Pos : Natural := Size + 1;
      Count : Natural;

      subtype Count_Type is Ada.Containers.Count_Type;
      use type Count_Type;
   begin
      for I in 1 .. Size loop
         Numbers (I) := I;
         Factors (I) := Prime_Sieve.Factorize (I);
      end loop;

      loop
         --  Check if we are done.
         Count := 0;
         for I in Factors'Range loop
            if Factors (I).Length = Count_Type (Size) then
               Count := Count + 1;
            end if;
         end loop;
         if Count = Size then
            Print_Result (Numbers (1));
            exit;
         end if;

         --  If not, advance the numbers along.
         Numbers (1 .. Size - 1) := Numbers (2 .. Size);
         Factors (1 .. Size - 1) := Factors (2 .. Size);
         Numbers (Size) := Pos;
         Factors (Size) := Prime_Sieve.Factorize (Pos);
         Pos := Pos + 1;
      end loop;
   end Solve;

begin
   Solve (4);
end Pr047;
