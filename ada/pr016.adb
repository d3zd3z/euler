----------------------------------------------------------------------
--  Problem 16
--
--  03 May 2002
--
--  2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
--
--  What is the sum of the digits of the number 2^1000?
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr016 is

   Decimal_Size : constant := 700;
   --  How many digits are needed for the result.

   Values : array (1 .. Decimal_Size) of Natural :=
     (1 => 1, others => 0);
   --  The digits representing this number in base 10.

   procedure Double;
   --  Double the value of the digit array.

   procedure Show_Result;

   procedure Double is
      Carry : Natural := 0;
      Temp : Natural;
   begin
      for I in Values'Range loop
         Temp := Values (I) * 2 + Carry;
         Values (I) := Temp mod 10;
         Carry := Temp / 10;
      end loop;

      if Carry /= 0 then
         raise Constraint_Error;
      end if;
   end Double;

   procedure Show_Result is
      Sum : Natural := 0;
   begin
      --  for I in Values'Range loop
      --     Sum := Sum + Values (I);
      --  end loop;
      for Piece of Values loop
         Sum := Sum + Piece;
      end loop;
      Print_Result (Sum);
   end Show_Result;

begin
   for I in 1 .. 1000 loop
      Double;
   end loop;
   Show_Result;
end Pr016;

