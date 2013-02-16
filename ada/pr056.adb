----------------------------------------------------------------------
--  Problem 56
--
--  07 November 2003
--
--  A googol (10^100) is a massive number: one followed by one-hundred
--  zeros; 100^100 is almost unimaginably large: one followed by
--  two-hundred zeros. Despite their size, the sum of the digits in each
--  number is only 1.
--
--  Considering natural numbers of the form, a^b, where a, b < 100, what
--  is the maximum digital sum?
--
--  972
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr056 is

   --  TODO: Extract this into a large decimal package.

   Max_Digits : constant := 201;

   subtype One_Digit is Natural range 0 .. 9;
   type Digit_Array is array (Positive range <>) of One_Digit;

   subtype Number_Type is Digit_Array (1 .. Max_Digits);

   procedure Natural_To_Number (Input : Natural;
                                Number : out Number_Type);
   --  Convert the given natural number into an expanded decimal
   --  number.

   procedure Multiply_By (Number : in out Number_Type;
                          By     :        Natural);
   --  Multiply the given 'Number' by the constant 'By'.  By should be
   --  small enough that multiplied by a single digit and a carry
   --  added won't overflow a Natural.

   procedure Power (Number : out Number_Type;
                    A, B   :     Natural);
   --  Computer A ** B using the large decimal number.

   function Digit_Sum (Number : Number_Type) return Natural;
   --  Compute the sum of the digits in the given number.

   ---------------
   -- Digit_Sum --
   ---------------
   function Digit_Sum (Number : Number_Type) return Natural is
      Sum : Natural := 0;
   begin
      for X of Number loop
         Sum := Sum + X;
      end loop;

      return Sum;
   end Digit_Sum;

   -----------------
   -- Multiply_By --
   -----------------
   procedure Multiply_By (Number : in out Number_Type;
                          By     :        Natural)
   is
      Carry : Natural := 0;
      Temp : Natural;
   begin
      for Pos in reverse Number'Range loop
         Temp := Natural (Number (Pos)) * By + Carry;
         Number (Pos) := Temp mod 10;
         Carry := Temp / 10;
      end loop;

      if Carry /= 0 then
         raise Constraint_Error;
      end if;
   end Multiply_By;

   -----------------------
   -- Natural_To_Number --
   -----------------------
   procedure Natural_To_Number (Input : Natural;
                                Number : out Number_Type)
   is
      Pos : Natural := Number'Last;
      Temp : Natural := Input;
   begin
      Number := (others => 0);

      while Temp /= 0 loop
         Number (Pos) := Temp mod 10;
         Temp := Temp / 10;
         Pos := Pos - 1;
      end loop;
   end Natural_To_Number;

   -----------
   -- Power --
   -----------
   procedure Power (Number : out Number_Type;
                    A, B   :     Natural)
   is
   begin
      Natural_To_Number (1, Number);

      for I in 1 .. B loop
         Multiply_By (Number, A);
      end loop;
   end Power;

   ------------------------------

   Work : Number_Type;
   Size : Natural;
   Largest : Natural := 0;

begin
   for A in 1 .. 99 loop
      for B in 1 .. 99 loop
         Power (Work, A, B);
         Size := Digit_Sum (Work);
         if Size > Largest then
            Largest := Size;
         end if;
      end loop;
   end loop;

   Put_Line (Natural'Image (Largest));
end Pr056;
