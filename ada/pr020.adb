----------------------------------------------------------------------
--  Problem 20
--
--  21 June 2002
--
--  n! means n × (n − 1) × ... × 3 × 2 × 1
--
--  For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
--  and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
--  27.
--
--  Find the sum of the digits in the number 100!
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr020 is

   Base : constant := 10_000;

   --  Represent the intermediate result in base 10,000.
   type Digit_Array is array (Positive range <>) of Natural;

   --  Length is determined by trial and error.
   Accumulator : Digit_Array (1 .. 40) := (1 => 1, others => 0);

   procedure Multiply (By : in Natural);

   procedure Multiply (By : in Natural) is
      Temp : Natural;
      Carry : Natural := 0;
   begin
      for I in Accumulator'Range loop
         Temp := Accumulator (I) * By + Carry;
         Accumulator (I) := Temp mod Base;
         Carry := Temp / Base;
      end loop;
      if Carry /= 0 then
         raise Constraint_Error;
      end if;
   end Multiply;

   Sum : Natural := 0;
   Temp : Natural;

begin
   for I in 2 .. 100 loop
      Multiply (I);
   end loop;

   for I in Accumulator'Range loop
      Temp := Accumulator (I);
      while Temp /= 0 loop
         Sum := Sum + Temp mod 10;
         Temp := Temp / 10;
      end loop;
   end loop;

   Print_Result (Sum);

end Pr020;

