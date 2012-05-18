----------------------------------------------------------------------
--  Problem 38
--
--  28 February 2003
--
--
--  Take the number 192 and multiply it by each of 1, 2, and 3:
--
--      192 x 1 = 192
--      192 x 2 = 384
--      192 x 3 = 576
--
--  By concatenating each product we get the 1 to 9 pandigital,
--  192384576. We will call 192384576 the concatenated product of 192 and
--  (1,2,3)
--
--  The same can be achieved by starting with 9 and multiplying by 1, 2,
--  3, 4, and 5, giving the pandigital, 918273645, which is the
--  concatenated product of 9 and (1,2,3,4,5).
--
--  What is the largest 1 to 9 pandigital 9-digit number that can be
--  formed as the concatenated product of an integer with (1,2, ... , n)
--  where n > 1?
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;
with Euler; use Euler;

procedure Pr038 is

   type Large_Number is range 0 .. 2**63-1;

   function Is_Pandigital (Number : Large_Number) return Boolean;
   --  Is Number a full 9-element pandigital number.

   procedure Large_Sum (Base : Natural; Result : out Large_Number);
   --  Multiply Base times successive integers, starting from 1, concatenating
   --  the results, and returning the number when it has at least 9 digits.

   -------------------
   -- Is_Pandigital --
   -------------------
   function Is_Pandigital (Number : Large_Number) return Boolean is
      N : Large_Number := Number;
      Bits : Unsigned_32 := 0;
      Bit : Unsigned_32;
   begin
      while N > 0 loop
         Bit := Shift_Left (1, Natural (N mod 10));
         if (Bit and Bits) /= 0 then
            return False;
         end if;

         Bits := Bits or Bit;
         N := N / 10;
      end loop;

      return Bits = 1022;
   end Is_Pandigital;

   ---------------
   -- Large_Sum --
   ---------------
   procedure Large_Sum (Base : Natural; Result : out Large_Number) is
      Length : Natural := 0;
      I : Natural := 1;
      Piece : Natural;
      Piece_Length : Natural;
   begin
      Result := 0;

      loop
         if Length >= 9 then
            return;
         end if;

         Piece := Base * I;
         Piece_Length := Number_Of_Digits (Piece);
         Length := Length + Piece_Length;
         Result := Result * (10 ** Piece_Length) + Large_Number (Piece);
         I := I + 1;
      end loop;
   end Large_Sum;

   Result : Large_Number;
   Largest : Large_Number := 0;

begin
   for A in 1 .. 9_999 loop
      Large_Sum (A, Result);
      if Is_Pandigital (Result) and then Result > Largest then
         Largest := Result;
      end if;
   end loop;

   Put_Line (Largest'Img);
end Pr038;

