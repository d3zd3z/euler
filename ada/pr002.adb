----------------------------------------------------------------------
--  Problem 2
--
--  19 October 2001
--
--  Each new term in the Fibonacci sequence is generated by adding the
--  previous two terms. By starting with 1 and 2, the first 10 terms will be:
--
--  1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
--
--  By considering the terms in the Fibonacci sequence whose values do not
--  exceed four million, find the sum of the even-valued terms.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;

procedure Pr002 is

   Sum : Integer := 0;
   A : Integer := 1;
   B : Integer := 2;
   Tmp : Integer;

begin
   while A < 4_000_000 loop

      if A mod 2 = 0 then
         Sum := Sum + A;
      end if;

      Tmp := A;
      A := B;
      B := B + Tmp;
   end loop;

   Put_Line (Integer'Image (Sum));
end Pr002;

