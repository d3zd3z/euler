----------------------------------------------------------------------
--  Problem 52

--
--  12 September 2003
--
--
--  It can be seen that the number, 125874, and its double, 251748,
--  contain exactly the same digits, but in a different order.
--
--  Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and
--  6x, contain the same digits.
--
--  142857
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

--  The answer is actually a fairly commonly known fact about the
--  repeating decimal digits of the value 1/7.  However, it is still
--  an interesting problem to solve efficiently by searching.
--
--  Some simple deduction can easily determine that the result will be
--  6 digits, and will start with a 1.

procedure Pr052 is

   function Digits_Of (Number : Natural) return String;
   --  Return the digits of the number, sorted.

   function Digits_Of (Number : Natural) return String is
      Text : String := Natural'Image (Number);
      First : constant Natural := Text'First + 1;
      Tmp : Character;
      Pos : Natural;
   begin
      for I in First .. Text'Last loop
         Tmp := Text (I);
         Pos := I;
         while Pos > First and then Tmp < Text (Pos - 1) loop
            Text (Pos) := Text (Pos - 1);
            Pos := Pos - 1;
         end loop;
         Text (Pos) := Tmp;
      end loop;

      return Text;
   end Digits_Of;

begin
   for Base in 100000 .. 199999 loop
      declare
         Base_Text : constant String := Digits_Of (Base);
      begin
         for Multiplier in 2 .. 6 loop
            declare
               Mult_Text : constant String := Digits_Of (Base * Multiplier);
            begin
               if Base_Text /= Mult_Text then
                  goto Mismatch;
               end if;
            end;
         end loop;

         Put_Line (Natural'Image (Base));
         exit;

      <<Mismatch>>
         --  Ada 2012 doesn't require the null here.  Interesting test
         --  for that.
         null;
      end;
   end loop;
end Pr052;
