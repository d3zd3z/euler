----------------------------------------------------------------------
--  Problem 24

--
--  16 August 2002
--
--  A permutation is an ordered arrangement of objects. For example, 3124 is
--  one possible permutation of the digits 1, 2, 3 and 4. If all of the
--  permutations are listed numerically or alphabetically, we call it
--  lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
--
--  012   021   102   120   201   210
--
--  What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
--  4, 5, 6, 7, 8 and 9?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr024 is

   Text : String := "0123456789";
   Done : Boolean;

   procedure Next is new Next_Permutation (Character, String);

begin
   for I in 2 .. 1_000_000 loop
      Next (Text, Done);
      if Done then
         raise Program_Error;
      end if;
   end loop;
   Put_Line (Text);
end Pr024;

