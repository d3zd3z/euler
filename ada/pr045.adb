----------------------------------------------------------------------
--  Problem 45

--
--  06 June 2003
--
--
--  Triangle, pentagonal, and hexagonal numbers are generated by the
--  following formulae:
--
--  Triangle     T[n]=n(n+1)/2    1, 3, 6, 10, 15, ...
--  Pentagonal   P[n]=n(3n−1)/2   1, 5, 12, 22, 35, ...
--  Hexagonal    H[n]=n(2n−1)     1, 6, 15, 28, 45, ...
--
--  It can be verified that T[285] = P[165] = H[143] = 40755.
--
--  Find the next triangle number that is also pentagonal and hexagonal.
----------------------------------------------------------------------
--
--  All the hexagonal numbers are triangle numbers, so there's no need to
--  check for triangle numbers.
--  To get the nth pentagonal number P(n-1) + (3n-2)
--  To get the nth hexagonal number  H(n-1) + (4n-3)
--
--  This is fairly simple, just track the two numbers, incrementing whichever
--  one is smaller until they are equal (and greater than the number in the
--  problem statement).

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr045 is

   Pn, Hn, Pentagonal, Hexagonal : Natural := 1;

begin
   while Pentagonal /= Hexagonal or else Pentagonal <= 40755 loop
      if Pentagonal < Hexagonal then
         Pn := Pn + 1;
         Pentagonal := Pentagonal + 3 * Pn - 2;
      else
         Hn := Hn + 1;
         Hexagonal := Hexagonal + 4 * Hn - 3;
      end if;
   end loop;

   Put_Line (Natural'Image (Pentagonal));
end Pr045;
