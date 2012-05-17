----------------------------------------------------------------------
--  Problem 34

--
--  03 January 2003
--
--  145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
--
--  Find the sum of all numbers which are equal to the sum of the
--  factorial of their digits.
--
--  Note: as 1! = 1 and 2! = 2 are not sums they are not included.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr034 is

   Factorials : array (0 .. 9) of Natural;
   Last_Factorial : Natural;

   procedure Initialize_Factorials;

   ---------------------------
   -- Initialize_Factorials --
   ---------------------------
   procedure Initialize_Factorials is
   begin
      Factorials (0) := 1;
      for I in 1 .. 9 loop
         Factorials (I) := Factorials (I - 1) * I;
      end loop;

      Last_Factorial := Factorials (9);
   end Initialize_Factorials;

   --  Sum the total, but remove 1! and 2! as per the problem description.
   Total : Integer := -3;

   procedure Chain (Number, Sum : Natural);
   --  Recursively compute all of the factorials (limiting the search by
   --  Last_Factorial), adding those that are equal to the sum of their digits
   --  to Total.

   -----------
   -- Chain --
   -----------
   procedure Chain (Number, Sum : Natural) is
      Base : Natural;
   begin
      if Number > 0 and then Number = Sum then
         Total := Total + Number;
      end if;

      if Number * 10 < Sum + Last_Factorial then
         Base := 0;
         if Number = 0 then
            Base := 1;
         end if;
         for I in Base .. 9 loop
            Chain (Number * 10 + I, Sum + Factorials (I));
         end loop;
      end if;
   end Chain;

begin
   Initialize_Factorials;
   Chain (0, 0);
   Put_Line (Integer'Image (Total));
end Pr034;

