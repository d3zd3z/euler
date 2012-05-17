----------------------------------------------------------------------
--  Problem 30

--
--  08 November 2002
--
--  Surprisingly there are only three numbers that can be written as the
--  sum of fourth powers of their digits:
--
--      1634 = 1^4 + 6^4 + 3^4 + 4^4
--      8208 = 8^4 + 2^4 + 0^4 + 8^4
--      9474 = 9^4 + 4^4 + 7^4 + 4^4
--
--  As 1 = 1^4 is not a sum it is not included.
--
--  The sum of these numbers is 1634 + 8208 + 9474 = 19316.
--
--  Find the sum of all the numbers that can be written as the sum of
--  fifth powers of their digits.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr030 is

   function Digit_Power_Sum (Number, Power : Natural) return Natural;
   --  Return the sum of the digits of Number, raised to Power.

   function Largest_Number (Power : Natural) return Natural;
   --  For a given exponent, return the largest number that might
   --  potentially be equal to the some of its digits raised to the given
   --  power.

   function Count_Summable (Power : Natural) return Natural;
   --  Count the number of values that are equal to the sum of their digits
   --  raised to the given Power.

   ---------------------
   -- Digit_Power_Sum --
   ---------------------
   function Digit_Power_Sum (Number, Power : Natural) return Natural is
      Result : Natural := 0;
      Temp : Natural := Number;
   begin
      while Temp > 0 loop
         Result := Result + ((Temp mod 10) ** Power);
         Temp := Temp / 10;
      end loop;
      return Result;
   end Digit_Power_Sum;

   --------------------
   -- Largest_Number --
   --------------------
   function Largest_Number (Power : Natural) return Natural is
      Sum : Natural;
      Number : Natural := 9;
   begin
      loop
         Sum := Digit_Power_Sum (Number, Power);
         exit when Number > Sum;
         Number := Number * 10 + 9;
      end loop;

      return Number;
   end Largest_Number;

   --------------------
   -- Count_Summable --
   --------------------
   function Count_Summable (Power : Natural) return Natural is
      Sum : Natural := 0;
   begin
      for I in 2 .. Largest_Number (Power) loop
         if Digit_Power_Sum (I, Power) = I then
            Sum := Sum + I;
         end if;
      end loop;

      return Sum;
   end Count_Summable;

begin
   Put_Line (Natural'Image (Count_Summable (5)));
end Pr030;

