----------------------------------------------------------------------
--  Problem 37
--
--  14 February 2003
--
--  The number 3797 has an interesting property. Being prime itself, it
--  is possible to continuously remove digits from left to right, and
--  remain prime at each stage: 3797, 797, 97, and 7. Similarly we can
--  work from right to left: 3797, 379, 37, and 3.
--
--  Find the sum of the only eleven primes that are both truncatable from
--  left to right and right to left.
--
--  NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Prime_Sieve;
with Euler; use Euler;

procedure Pr037 is

   procedure Handle (Number : Natural);

   procedure Add_Primes (Number : Natural;
      Thunk : not null access procedure (Number : Natural));
   --  For a given number, call Think for all numbers that have a single digit
   --  appended that are still prime.

   procedure Left_Trunc (Number : Natural;
      Thunk : not null access procedure (Number : Natural));
   --  If the Number is left truncatable, call Thunk with it.

   procedure Right_Trunc (Base : Natural;
      Thunk : not null access procedure (Number : Natural));

   procedure Add_Primes (Number : Natural;
      Thunk : not null access procedure (Number : Natural))
   is
      Extra : constant array (1 .. 4) of Natural := (1, 3, 7, 9);
      Temp : Natural;
   begin
      for E of Extra loop
         Temp := Number * 10 + E;
         if Prime_Sieve.Is_Prime (Temp) then
            Thunk (Temp);
         end if;
      end loop;
   end Add_Primes;

   procedure Left_Trunc (Number : Natural;
      Thunk : not null access procedure (Number : Natural))
   is
      N : Natural := Number;
   begin
      while N > 0 loop
         if not Prime_Sieve.Is_Prime (N) then
            return;
         end if;

         N := Reverse_Number (Reverse_Number (N) / 10);
      end loop;

      Thunk (Number);
   end Left_Trunc;

   procedure Right_Trunc (Base : Natural;
      Thunk : not null access procedure (Number : Natural))
   is
      procedure Next (Number : Natural);
      procedure Next (Number : Natural) is
      begin
         Left_Trunc (Number, Thunk);
         Right_Trunc (Number, Thunk);
      end Next;
   begin
      if Base < 1_000_000 then
         Add_Primes (Base, Next'Access);
      end if;
   end Right_Trunc;

   Sum : Natural := 0;

   procedure Handle (Number : Natural) is
   begin
      Sum := Sum + Number;
   end Handle;

   First_Digits : constant array (1 .. 4) of Natural := (2, 3, 5, 7);

begin
   for J of First_Digits loop
      Right_Trunc (J, Handle'Access);
   end loop;
   Put_Line (Natural'Image (Sum));
end Pr037;

