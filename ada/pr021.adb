----------------------------------------------------------------------
--  Problem 21
--
--  05 July 2002
--
--  Let d(n) be defined as the sum of proper divisors of n (numbers less than
--  n which divide evenly into n).
--  If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
--  and each of a and b are called amicable numbers.
--
--  For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
--  44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
--  2, 4, 71 and 142; so d(284) = 220.
--
--  Evaluate the sum of all the amicable numbers under 10000.
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;
with Prime_Sieve;

procedure Pr021 is

   Limit : constant := 10_000;

   function Is_Amicable (Number : Natural) return Boolean;

   function Is_Amicable (Number : Natural) return Boolean is
      B, C : Natural;
   begin
      if Number >= Limit then
         return False;
      end if;

      B := Prime_Sieve.Proper_Divisor_Sum (Number);

      if B >= Limit or else Number = B then
         return False;
      end if;

      C := Prime_Sieve.Proper_Divisor_Sum (B);
      return Number = C;
   end Is_Amicable;

   Total : Natural := 0;

begin
   for I in 2 .. Limit - 1 loop
      if Is_Amicable (I) then
         Total := Total + I;
      end if;
   end loop;
   Print_Result (Total);
end Pr021;

