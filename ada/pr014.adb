----------------------------------------------------------------------
--  Problem 14
--
--  05 April 2002
--
--  The following iterative sequence is defined for the set of positive
--  integers:
--
--  n → n/2 (n is even)
--  n → 3n + 1 (n is odd)
--
--  Using the rule above and starting with 13, we generate the following
--  sequence:
--
--  13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
--
--  It can be seen that this sequence (starting at 13 and finishing at 1)
--  contains 10 terms. Although it has not been proved yet (Collatz Problem),
--  it is thought that all starting numbers finish at 1.
--
--  Which starting number, under one million, produces the longest chain?
--
--  NOTE: Once the chain starts the terms are allowed to go above one million.
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;

procedure Pr014 is

   type Long_Natural_Array is array (Long_Natural range <>) of Long_Natural;
   Cache : Long_Natural_Array (1 .. 1000) := (others => 0);

   function Next_Collatz (Number : Long_Natural) return Long_Natural
     with Inline => True;

   function Chain_Length (Number : Long_Natural) return Long_Natural;

   function Next_Collatz (Number : Long_Natural) return Long_Natural is
   begin
      if Number mod 2 = 0 then
         return Number / 2;
      else
         return Number * 3 + 1;
      end if;

   exception
      when Constraint_Error =>
         Print_Result (Number);
         raise Constraint_Error;
   end Next_Collatz;

   function Chain_Length (Number : Long_Natural) return Long_Natural is
      Result : Long_Natural;
   begin
      if Number in Cache'Range then
         Result := Cache (Number);
         if Result > 0 then
            return Result;
         end if;

         if Number = 1 then
            Result := 1;
         else
            Result := 1 + Chain_Length (Next_Collatz (Number));
         end if;

         Cache (Number) := Result;
         return Result;
      else
         --  Don't cache large values.  The cache size is a tradeoff
         --  of space/time.  It is fastest to cache everything,
         --  though.  Note that we also depend on '1' being in the
         --  range of the cache.
         return 1 + Chain_Length (Next_Collatz (Number));
      end if;
   end Chain_Length;

   Longest : Long_Natural := 0;
   Longest_Length : Long_Natural := 0;
   Temp : Long_Natural;

begin
   for I in Long_Natural range 1 .. 1_000_000 loop
      Temp := Chain_Length (I);
      if Temp > Longest_Length then
         Longest := I;
         Longest_Length := Temp;
      end if;
   end loop;

   Print_Result (Longest);
end Pr014;
