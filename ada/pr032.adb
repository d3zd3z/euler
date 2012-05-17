----------------------------------------------------------------------
--  Problem 32

--
--  06 December 2002
--
--  We shall say that an n-digit number is pandigital if it makes use of
--  all the digits 1 to n exactly once; for example, the 5-digit number,
--  15234, is 1 through 5 pandigital.
--
--  The product 7254 is unusual, as the identity, 39 x 186 = 7254,
--  containing multiplicand, multiplier, and product is 1 through 9
--  pandigital.
--
--  Find the sum of all products whose multiplicand/multiplier/product
--  identity can be written as a 1 through 9 pandigital.
--
--  HINT: Some products can be obtained in more than one way so be sure
--  to only include it once in your sum.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler;

with Ada.Containers.Vectors;

procedure Pr032 is

   package Natural_Vectors is new Ada.Containers.Vectors (
      Index_Type => Natural,
      Element_Type => Natural);
   subtype Natural_Vector is Natural_Vectors.Vector;

   package Natural_Sorting is new Natural_Vectors.Generic_Sorting;

   procedure Make_Grouping (Base : String;
      Result : in out Natural_Vector);
   --  Appends the valid groupings to the result.

   procedure Permutor is new Euler.Next_Permutation (
      Element_Type => Character, Element_Array => String);

   Numbers : Natural_Vector;
   Sequence : String := "123456789";
   Done : Boolean;
   Sum : Natural := 0;
   Last_Number : Natural := Natural'Last;

   -------------------
   -- Make_Grouping --
   -------------------
   procedure Make_Grouping (Base : String;
      Result : in out Natural_Vector)
   is
      A, B, C : Natural;
   begin
      for I in Base'First .. Base'Last - 2 loop
         for J in I + 1 .. Base'Last - 1 loop
            A := Natural'Value (Base (Base'First .. I));
            B := Natural'Value (Base (I + 1 .. J));
            C := Natural'Value (Base (J + 1 .. Base'Last));
            if A * B = C then
               Result.Append (C);
            end if;
         end loop;
      end loop;
   end Make_Grouping;

begin
   --  Loop through all of the permutations of the digits, collecting all of
   --  the valid products that come from it.
   loop
      Make_Grouping (Sequence, Numbers);
      Permutor (Sequence, Done);
      exit when Done;
   end loop;

   --  Eliminate duplicates by sorting, and tracking the previously seen
   --  value.
   Natural_Sorting.Sort (Numbers);

   for X of Numbers loop
      if X /= Last_Number then
         Sum := Sum + X;

         Last_Number := X;
      end if;
   end loop;

   Put_Line (Natural'Image (Sum));

end Pr032;

