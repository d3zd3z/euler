----------------------------------------------------------------------
--  Problem 27

--
--  27 September 2002
--
--  Euler published the remarkable quadratic formula:
--
--  n^2 + n + 41
--
--  It turns out that the formula will produce 40 primes for the consecutive
--  values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41
--  is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly
--  divisible by 41.
--
--  Using computers, the incredible formula  n^2 − 79n + 1601 was discovered,
--  which produces 80 primes for the consecutive values n = 0 to 79. The
--  product of the coefficients, −79 and 1601, is −126479.
--
--  Considering quadratics of the form:
--
--      n^2 + an + b, where |a| < 1000 and |b| < 1000
--
--      where |n| is the modulus/absolute value of n
--      e.g. |11| = 11 and |−4| = 4
--
--  Find the product of the coefficients, a and b, for the quadratic
--  expression that produces the maximum number of primes for consecutive
--  values of n, starting with n = 0.
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;
with Prime_Sieve;

procedure Pr027 is

   function Count_Primes (A, B : Integer) return Integer;

   function Count_Primes (A, B : Integer) return Integer is
      N : Natural := 0;
      P : Integer;
   begin
      loop
         P := N * N + A * N + B;
         exit when P <= 0 or else not Prime_Sieve.Is_Prime (P);
         N := N + 1;
      end loop;

      return N;
   end Count_Primes;

   Largest : Integer := 0;
   Largest_Result : Integer := Integer'First;
   Count : Integer;

begin
   for A in -999 .. 1000 loop
      for B in -999 .. 1000 loop
         Count := Count_Primes (A, B);
         if Count > Largest then
            Largest := Count;
            Largest_Result := A * B;
         end if;
      end loop;
   end loop;

   Put_Line (Natural'Image (Largest_Result));
end Pr027;

