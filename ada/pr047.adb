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

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Prime_Sieve;
--  with Euler; use Euler;

procedure Pr047 is

   procedure Solve (Size : Natural);

   --------------------------------------------------------------------
   --  All of this until the next banner to instantiate a vector of
   --  the vectors.
   --------------------------------------------------------------------
   package Fv renames Prime_Sieve.Factor_Vectors;

   function Fv_Equals (Left, Right : Fv.Vector)
                      return Boolean;

   package Factor_Vectors_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => Fv.Vector,
      "="          => Fv_Equals);

   package Fvv renames Factor_Vectors_Vectors;

   function Fv_Equals (Left, Right : Fv.Vector)
                      return Boolean
   is
      use type Ada.Containers.Count_Type;
      use type Prime_Sieve.Factor;
   begin
      if Left.Length /= Right.Length then
         return False;
      end if;

      for Index in 1 .. Left.Last_Index loop
         if Left.Element (Index) /= Right.Element (Index) then
            return False;
         end if;
      end loop;

      return True;
   end Fv_Equals;

   --------------------------------------------------------------------

   procedure Solve (Size : Natural)
   is
   begin
      null;
   end Solve;

begin
   null;
end Pr047;
