----------------------------------------------------------------------
--  Problem 3
--
--  02 November 2001
--
--  The prime factors of 13195 are 5, 7, 13 and 29.
--
--  What is the largest prime factor of the number 600851475143 ?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;

--  It's not actually necessary to know the prime numbers, just trial
--  division will be sufficiently fast.
procedure Pr003 is

   type Long is range 0 .. 2**63 - 1;

   Number : Long := 600851475143;
   Factor : Long := 2;

begin
   while Number > 1 loop
      if Number mod Factor = 0 then
         Number := Number / Factor;
      else
         if Factor = 2 then
            Factor := 3;
         else
            Factor := Factor + 2;
         end if;
      end if;
   end loop;

   Put_Line (Long'Image (Factor));
end Pr003;

