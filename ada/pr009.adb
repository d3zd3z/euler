----------------------------------------------------------------------
--  Problem 9
--
--  25 January 2002
--
--  A Pythagorean triplet is a set of three natural numbers, a < b < c, for
--  which,
--
--  a^2 + b^2 = c^2
--
--  For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
--
--  There exists exactly one Pythagorean triplet for which a + b + c = 1000.
--  Find the product abc.
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr009 is

   C : Natural;

begin
   for A in 1 .. 999 loop
      for B in A .. 1000 - A loop
         C := 1000 - A - B;
         if A * A + B * B = C * C then
            Print_Result (A * B * C);
         end if;
      end loop;
   end loop;

end Pr009;

