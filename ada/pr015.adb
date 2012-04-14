----------------------------------------------------------------------
--  Problem 15

--
--  19 April 2002
--
--  Starting in the top left corner of a 2×2 grid, there are 6 routes (without
--  backtracking) to the bottom right corner.
--
--  [p_015]
--
--  How many routes are there through a 20×20 grid?
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr015 is

   Steps : constant := 20;

   type Long_Natural_Array is array (Positive range <>) of Long_Natural;

   Values : Long_Natural_Array (1 .. Steps + 1) := (others => 1);
   --  How many ways of getting to each intersection, with the initial
   --  values based on the first row.

   procedure Bump;

   --  Compute the paths to the next line.  It's basically all of the
   --  ways from either above (which is the number present), plus the
   --  previous number.
   procedure Bump is
   begin
      for I in Values'First .. Values'Last - 1 loop
         Values (I + 1) := Values (I + 1) + Values (I);
      end loop;
   end Bump;

begin
   for I in 1 .. Steps loop
      Bump;
   end loop;

   Print_Result (Values (Values'Last));
end Pr015;

