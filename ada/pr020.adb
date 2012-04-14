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

   type Digit_Array is array (Positive range <>) of Natural;

   Accumulator : Digit_Array (1 .. 160);
   Temp : Digit_Array (1 .. 3);

   procedure Set_Number (Number : out Digit_Array;
                         Value  :     Natural);

   procedure Add (Number : in out Digit_Array;
                  Other  :        Digit_Array)
     with Pre => Number'First = Other'First and
     Number'Last = Other'Last;

   procedure Multiply (Number : in out Digit_Array;
                       By     : in     Digit_Array);

   procedure Set_Number (Number : out Digit_Array;
                         Value  :     Natural)
   is
      Temp : Natural := Value;
   begin
      for I in reverse Number'Range loop
         Number (I) := Temp mod 10;
         Temp := Temp / 10;
      end loop;
   end Set_Number;

   procedure Add (Number : in out Digit_Array;
                  Other  :        Digit_Array)
   is
      Temp : Natural;
      Carry : Natural := 0;
   begin
      for I in reverse Number'Range loop
         Temp := Number (I) + Other (I)
      end loop;
   end Add;

   procedure Multiply (Number : in out Digit_Array;
                       By     : in     Digit_Array)
   is
      Result : Digit_Array (Number'First .. Number'Last) :=
        (others => 0);
      Temp : Natural;
      Carry : Natural := 0;
   begin
      for I in reverse Number'Range loop
         raise Program_Error;
      end loop;
   end Multiply;

   Sum : Natural := 0;

begin
   Set_Number (Accumulator, 1);
   for I in 2 .. 100 loop
      Set_Number (Temp, I);
      Multiply (Accumulator, Temp);
   end loop;

   for I of Accumulator loop
      Sum := Sum + I;
   end loop;
   Print_Result (Sum);
end Pr020;

