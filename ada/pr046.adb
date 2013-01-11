----------------------------------------------------------------------
--  Problem 46
--
--  20 June 2003
--
--
--  It was proposed by Christian Goldbach that every odd composite number
--  can be written as the sum of a prime and twice a square.
--
--  9 = 7 + 2x1^2
--  15 = 7 + 2x2^2
--  21 = 3 + 2x3^2
--  25 = 7 + 2x3^2
--  27 = 19 + 2x2^2
--  33 = 31 + 2x1^2
--
--  It turns out that the conjecture was false.
--
--  What is the smallest odd composite that cannot be written as the sum
--  of a prime and twice a square?
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;
with Prime_Sieve;

procedure Pr046 is

   package PS renames Prime_Sieve;

   function Is_Golbach (Number : Natural) return Boolean;

   function Is_Golbach (Number : Natural) return Boolean is
      P : Natural := 3;

      function Check return Boolean;
      function Check return Boolean is
         Diff : constant Natural := (Number - P) / 2;
         DiffSq : constant Natural := ISqrt (Diff);
      begin
         return DiffSq * DiffSq = Diff;
      end Check;
   begin
      while P < Number loop
         if Check then
            return True;
         end if;

         P := PS.Next_Prime (P);
      end loop;

      return False;
   end Is_Golbach;

   Number : Natural;

begin
   Number := 9;
   loop
      if not PS.Is_Prime (Number) then
         if not Is_Golbach (Number) then
            Put_Line (Natural'Image (Number));
            exit;
         end if;
      end if;

      Number := Number + 2;
   end loop;
end Pr046;
