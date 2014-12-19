----------------------------------------------------------------------
--  Problem 64
--
--  27 February 2004
--
--  All square roots are periodic when written as continued fractions and
--  can be written in the form:
--
--  √N = a[0] + 1
--              a[1] + 1
--                     a[2] + 1
--                            a[3] + ...
--
--  For example, let us consider √23:
--
--  √23 = 4 + √23 — 4 = 4 +  1      = 4 +  1
--                           1             1 +  √23 – 3
--                           √23—4              7
--
--  If we continue we would get the following expansion:
--
--  √23 = 4 + 1
--            1 + 1
--                3 + 1
--                    1 + 1
--                        8 + ...
--
--  The process can be summarised as follows:
--
--  a[0] = 4,   1      =  √23+4     = 1 +  √23—3
--              √23—4     7                7
--  a[1] = 1,   7      =  7(√23+3)  = 3 +  √23—3
--              √23—3     14               2
--  a[2] = 3,   2      =  2(√23+3)  = 1 +  √23—4
--              √23—3     14               7
--  a[3] = 1,   7      =  7(√23+4)  = 8 +  √23—4
--              √23—4     7
--  a[4] = 8,   1      =  √23+4     = 1 +  √23—3
--              √23—4     7                7
--  a[5] = 1,   7      =  7(√23+3)  = 3 +  √23—3
--              √23—3     14               2
--  a[6] = 3,   2      =  2(√23+3)  = 1 +  √23—4
--              √23—3     14               7
--  a[7] = 1,   7      =  7(√23+4)  = 8 +  √23—4
--              √23—4     7
--
--  It can be seen that the sequence is repeating. For conciseness, we
--  use the notation √23 = [4;(1,3,1,8)], to indicate that the block
--  (1,3,1,8) repeats indefinitely.
--
--  The first ten continued fraction representations of (irrational)
--  square roots are:
--
--  √2=[1;(2)], period=1
--  √3=[1;(1,2)], period=2
--  √5=[2;(4)], period=1
--  √6=[2;(2,4)], period=2
--  √7=[2;(1,1,1,4)], period=4
--  √8=[2;(1,4)], period=2
--  √10=[3;(6)], period=1
--  √11=[3;(3,6)], period=2
--  √12= [3;(2,6)], period=2
--  √13=[3;(1,1,1,1,6)], period=5
--
--  Exactly four continued fractions, for N ≤ 13, have an odd period.
--
--  How many continued fractions for N ≤ 10000 have an odd period?
--
--  1322
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr064 is

   function Series (S : Natural) return Natural;
   --  Compute the series values of the series of the square root of 'S'.
   --  For this particular instance, we really only care about the length of
   --  the repeated portion.
   --
   --  This must not be called with a perfect square, or it will cause an
   --  exception.

   type State is
      record
         M, D, A : Natural;
      end record;

   ------------
   -- Series --
   ------------

   function Series (S : Natural) return Natural is
      A0 : constant Natural := ISqrt (S);

      function Step (Now : State) return State;
      --  Advance the given state to the next state.

      ----------
      -- Step --
      ----------

      function Step (Now : State) return State is
      begin
         return Next : State do
            Next.M := Now.D * Now.A - Now.M;
            Next.D := (S - (Next.M ** 2)) / Now.D;
            Next.A := (A0 + Next.M) / Next.D;
         end return;
      end Step;

      S0 : constant State := Step (State'(M => 0, D => 1, A => A0));
      Sn : State := S0;

      Count : Natural := 0;

   begin
      loop
         Sn := Step (Sn);
         Count := Count + 1;

         exit when Sn = S0;
      end loop;

      return Count;
   end Series;

   Count : Natural := 0;

begin
   for I in Natural range 2 .. 9999 loop

      --  Perfect squares will not terminate the Series function, so avoid
      --  these.
      if ISqrt (I) ** 2 = I then
         goto Next;
      end if;

      if Series (I) mod 2 = 1 then
         Count := Count + 1;
      end if;

      <<Next>>
   end loop;

   Put_Line (Natural'Image (Count));
end Pr064;
