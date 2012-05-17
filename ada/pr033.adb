----------------------------------------------------------------------
--  Problem 33

--
--  20 December 2002
--
--  The fraction ^49/[98] is a curious fraction, as an inexperienced
--  mathematician in attempting to simplify it may incorrectly believe
--  that ^49/[98] = ^4/[8], which is correct, is obtained by cancelling
--  the 9s.
--
--  We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
--  examples.
--
--  There are exactly four non-trivial examples of this type of fraction,
--  less than one in value, and containing two digits in the numerator
--  and denominator.
--
--  If the product of these four fractions is given in its lowest common
--  terms, find the value of the denominator.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr033 is

   function Is_Fraction (A, B : Integer) return Boolean;
   --  Does A/B represent one of the problem-style fractions?

   function GCD (A, B : Natural) return Natural;

   -----------------
   -- Is_Fraction --
   -----------------
   function Is_Fraction (A, B : Integer) return Boolean is
      AN : constant Integer := A / 10;
      AM : constant Integer := A mod 10;
      BN : constant Integer := B / 10;
      BM : constant Integer := B mod 10;
   begin
      return (AN = BM and then BN > 0 and then AM * B = BN * A) or else
         (AM = BN and then BM > 0 and then AN * B = BM * A);
   end Is_Fraction;

   ---------
   -- GCD --
   ---------
   function GCD (A, B : Natural) return Natural is
   begin
      --  GNAT will only code this as a tail call for higher optimization
      --  levels (for gcc 4.7 -O2 or -Os seem to do it).  For this particular
      --  problem, the values don't get much over 100, so it isn't really an
      --  issue here.  But, to make this more general, the computation should
      --  be broken out into a loop.
      if B = 0 then
         return A;
      else
         return GCD (B, A mod B);
      end if;
   end GCD;

   Prod_N, Prod_M : Natural := 1;
   G : Natural;

begin
   for A in 10 .. 99 loop
      for B in A + 1 .. 99 loop
         if Is_Fraction (A, B) then
            Prod_N := Prod_N * A;
            Prod_M := Prod_M * B;

            G := GCD (Prod_N, Prod_M);
            if G > 1 then
               Prod_N := Prod_N / G;
               Prod_M := Prod_M / G;
            end if;
         end if;
      end loop;
   end loop;

   Put_Line (Natural'Image (Prod_M));
end Pr033;
