----------------------------------------------------------------------
--  Problem 43

--
--  09 May 2003
--
--
--  The number, 1406357289, is a 0 to 9 pandigital number because it is
--  made up of each of the digits 0 to 9 in some order, but it also has a
--  rather interesting sub-string divisibility property.
--
--  Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In
--  this way, we note the following:
--
--    • d[2]d[3]d[4]=406 is divisible by 2
--    • d[3]d[4]d[5]=063 is divisible by 3
--    • d[4]d[5]d[6]=635 is divisible by 5
--    • d[5]d[6]d[7]=357 is divisible by 7
--    • d[6]d[7]d[8]=572 is divisible by 11
--    • d[7]d[8]d[9]=728 is divisible by 13
--    • d[8]d[9]d[10]=289 is divisible by 17
--
--  Find the sum of all 0 to 9 pandigital numbers with this property.
--
--
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler;

procedure Pr043 is

   procedure Next_Permutation is new Euler.Next_Permutation
      (Character, String);

   function Valid (Text : String) return Boolean;

   -----------
   -- Valid --
   -----------

   Primes : constant array (Positive range <>) of Natural := (
      2, 3, 5, 7, 11, 13, 17);

   function Valid (Text : String) return Boolean is
      Pos : Natural := 2;
   begin
      for I in Primes'Range loop
         if Natural'Value (Text (Pos .. Pos + 2)) mod Primes (I) /= 0 then
            return False;
         end if;

         Pos := Pos + 1;
      end loop;

      return True;
   end Valid;

   Text : String := "1023456789";
   Done : Boolean;

   type Large_Number is range 0 .. 2**63 - 1;

   Sum : Large_Number := 0;

begin
   loop
      if Valid (Text) then
         Sum := Sum + Large_Number'Value (Text);
      end if;

      Next_Permutation (Text, Done);
      exit when Done;
   end loop;

   Put_Line (Large_Number'Image (Sum));
end Pr043;

