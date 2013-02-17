----------------------------------------------------------------------
--  Problem 57
--
--  21 November 2003
--
--
--  It is possible to show that the square root of two can be expressed
--  as an infinite continued fraction.
--
--  √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
--
--  By expanding this for the first four iterations, we get:
--
--  1 + 1/2 = 3/2 = 1.5
--  1 + 1/(2 + 1/2) = 7/5 = 1.4
--  1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
--  1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
--
--  The next three expansions are 99/70, 239/169, and 577/408, but the
--  eighth expansion, 1393/985, is the first example where the number of
--  digits in the numerator exceeds the number of digits in the
--  denominator.
--
--  In the first one-thousand expansions, how many fractions contain a
--  numerator with more digits than denominator?
--
--  153
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;
with Ada.Numerics.Long_Long_Elementary_Functions;
use  Ada.Numerics.Long_Long_Elementary_Functions;

procedure Pr057 is

   --  Although the numerator and denominator grow quite large (384
   --  digits), we only need the top few digits to get a reasonable
   --  result.  We need to use Long_Long_Float in order to be able to
   --  hold values large enough.  Without that, we'd be forced to
   --  implement our own floating point type.

   type Step_Type is
      record
         Num, Den : Long_Long_Float;
      end record;

   Initial_Step : constant Step_Type := (Num => 1.0, Den => 1.0);

   function Digits_Used (Value : Long_Long_Float) return Natural;
   --  Determine how many digits are needed to the left of the decimal point.

   function Next_Step (Input : Step_Type) return Step_Type;
   --  Compute the next iteration.

   -----------------
   -- Digits_Used --
   -----------------
   function Digits_Used (Value : Long_Long_Float) return Natural
   is
   begin
      return Natural (Long_Long_Float'Truncation (Log (Value, 10.0))) + 1;
   end Digits_Used;

   ---------------
   -- Next_Step --
   ---------------
   function Next_Step (Input : Step_Type) return Step_Type is
   begin
      return (Num => Input.Num + 2.0 * Input.Den,
              Den => Input.Num + Input.Den);
   end Next_Step;

   Count : Natural := 0;
   Step : Step_Type := Initial_Step;

begin
   for I in 1 .. 1000 loop
      Step := Next_Step (Step);
      if Digits_Used (Step.Num) > Digits_Used (Step.Den) then
         Count := Count + 1;
      end if;
   end loop;

   Put_Line (Natural'Image (Count));
end Pr057;
