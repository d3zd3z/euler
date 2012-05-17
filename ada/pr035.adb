----------------------------------------------------------------------
--  Problem 35
--
--  17 January 2003
--
--
--  The number, 197, is called a circular prime because all rotations of
--  the digits: 197, 971, and 719, are themselves prime.
--
--  There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31,
--  37, 71, 73, 79, and 97.
--
--  How many circular primes are there below one million?
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Prime_Sieve;
--  with Euler; use Euler;

procedure Pr035 is

   function Number_Of_Digits (Number : Natural) return Natural;
   --  Returns the number of decimal digits in Number;

   procedure Number_Rotations (
      Number : Natural;
      Operate : not null access procedure (Value : Natural));
   --  Call Operate on all of the rotations of the given number;

   function Is_Circular_Prime (Number : Natural) return Boolean;
   --  Is the given Number a circular prime?

   -----------------------
   -- Is_Circular_Prime --
   -----------------------
   function Is_Circular_Prime (Number : Natural) return Boolean is
      Result : Boolean := True;

      procedure Test (Number : Natural);
      procedure Test (Number : Natural) is
      begin
         if not Prime_Sieve.Is_Prime (Number) then
            Result := False;
         end if;
      end Test;
   begin
      Number_Rotations (Number, Test'Access);
      return Result;
   end Is_Circular_Prime;

   ----------------------
   -- Number_Of_Digits --
   ----------------------
   function Number_Of_Digits (Number : Natural) return Natural is
      Count : Natural := 0;
      Temp : Natural := Number;
   begin
      while Temp > 0 loop
         Count := Count + 1;
         Temp := Temp / 10;
      end loop;

      return Count;
   end Number_Of_Digits;

   ----------------------
   -- Number_Rotations --
   ----------------------
   procedure Number_Rotations (
      Number : Natural;
      Operate : not null access procedure (Value : Natural))
   is
      Len : constant Natural := Number_Of_Digits (Number);
      Highest_One : constant Natural := 10 ** (Len - 1);
      Right : Natural := Highest_One;
      Left : Natural := 1;
      Accum : Natural := 0;
      N : Natural := Number;

      New_Accum : Natural;
      Next : Natural;
   begin
      while Left <= Highest_One loop
         New_Accum := Accum + Left * (N mod 10);
         Next := (N / 10) + Right * New_Accum;
         Operate (Next);

         Right := Right / 10;
         Left := Left * 10;
         Accum := New_Accum;
         N := N / 10;
      end loop;
   end Number_Rotations;

   Count : Natural := 0;

begin
   for I in 2 .. 999_999 loop
      if Is_Circular_Prime (I) then
         Count := Count + 1;
      end if;
   end loop;
   Put_Line (Natural'Image (Count));
end Pr035;

