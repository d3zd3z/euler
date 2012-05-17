----------------------------------------------------------------------
--  Problem 36
--
--  31 January 2003
--
--
--  The decimal number, 585 = 1001001001[2] (binary), is palindromic in
--  both bases.
--
--  Find the sum of all numbers, less than one million, which are
--  palindromic in base 10 and base 2.
--
--  (Please note that the palindromic number, in either base, may not
--  include leading zeros.)
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr036 is

   function Is_Palindrome (Number : Natural; Base : Natural := 10)
      return Boolean;
   --  Is this Number a Palindrome when viewed in the given base?

   -------------------
   -- Is_Palindrome --
   -------------------
   function Is_Palindrome (Number : Natural; Base : Natural := 10)
      return Boolean
   is
   begin
      return Number = Reverse_Number (Number, Base);
   end Is_Palindrome;

   Sum : Natural := 0;

begin
   for I in 1 .. 999_999 loop
      if Is_Palindrome (I, 10) and then Is_Palindrome (I, 2) then
         Sum := Sum + I;
      end if;
   end loop;

   Put_Line (Natural'Image (Sum));
end Pr036;

