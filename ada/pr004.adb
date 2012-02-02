----------------------------------------------------------------------
--  Problem 4
--
--  16 November 2001
--
--  A palindromic number reads the same both ways. The largest palindrome made
--  from the product of two 2-digit numbers is 9009 = 91 × 99.
--
--  Find the largest palindrome made from the product of two 3-digit numbers.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;

procedure Pr004 is

   function Reverse_Number (Number : Natural) return Natural;
   function Is_Palindrome (Number : Natural) return Boolean;

   function Is_Palindrome (Number : Natural) return Boolean is
   begin
      return Number = Reverse_Number (Number);
   end Is_Palindrome;

   function Reverse_Number (Number : Natural) return Natural is
      Base : Natural := Number;
      Result : Natural := 0;
   begin
      while Base /= 0 loop
         Result := Result * 10 + Base mod 10;
         Base := Base / 10;
      end loop;
      return Result;
   end Reverse_Number;

   Largest : Natural := 0;
   Tmp : Natural;

begin
   for A in 100 .. 999 loop
      for B in A .. 999 loop
         Tmp := A * B;
         if Is_Palindrome (Tmp) and then Tmp > Largest then
            Largest := Tmp;
         end if;
      end loop;
   end loop;

   Put_Line (Natural'Image (Largest));
end Pr004;

