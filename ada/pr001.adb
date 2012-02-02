----------------------------------------------------------------------
--  Problem 1
--
--  05 October 2001
--
--  If we list all the natural numbers below 10 that are multiples of 3
--  or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
--
--  Find the sum of all the multiples of 3 or 5 below 1000.
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;

procedure Pr001 is

   Sum : Integer := 0;

begin
   for I in 1 .. 999 loop
      if I mod 3 = 0 or else I mod 5 = 0 then
         Sum := Sum + I;
      end if;
   end loop;

   Put_Line (Integer'Image (Sum));
end Pr001;
