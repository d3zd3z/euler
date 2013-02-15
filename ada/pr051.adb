----------------------------------------------------------------------
--  Problem 51

--
--  29 August 2003
--
--
--  By replacing the 1^st digit of *3, it turns out that six of the nine
--  possible values: 13, 23, 43, 53, 73, and 83, are all prime.
--
--  By replacing the 3^rd and 4^th digits of 56**3 with the same digit,
--  this 5-digit number is the first example having seven primes among
--  the ten generated numbers, yielding the family: 56003, 56113, 56333,
--  56443, 56663, 56773, and 56993. Consequently 56003, being the first
--  member of this family, is the smallest prime with this property.
--
--  Find the smallest prime which, by replacing part of the number (not
--  necessarily adjacent digits) with the same digit, is part of an eight
--  prime value family.
--
--  121313
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;
with Ada.Strings.Fixed;
with Prime_Sieve;

procedure Pr051 is

   package Str renames Ada.Strings.Fixed;
   package Ps renames Prime_Sieve;

   function Numbers (Part : Natural) return Character;

   function Numbers (Part : Natural) return Character is
   begin
      return Character'Val (Part + Character'Pos ('0'));
   end Numbers;

   procedure Family_Size (Base : Natural; Part : Natural; Size : out Natural);
   --  Given a base number, count how many numbers formed are prime
   --  when replacing all of the digits of the number in 'base', that
   --  are equal to 'Part'.

   procedure Family_Size (Base : Natural; Part : Natural; Size : out Natural)
   is
      Original : constant String := Natural'Image (Base);
      Work : String (1 .. Original'Length);
      Prime : Natural;
   begin
      Size := 0;

      --  Do nothing if the Part doesn't occur in the number.
      if Str.Count (Original, (1 => Numbers (Part))) = 0 then
         return;
      end if;

      for Value in Part .. 9 loop
         Work := Original;
         for Pos in Work'Range loop
            if Work (Pos) = Numbers (Part) then
               Work (Pos) := Numbers (Value);
            end if;
         end loop;

         Prime := Natural'Value (Work);
         if Ps.Is_Prime (Prime) then
            Size := Size + 1;
         end if;
      end loop;

   end Family_Size;

   Size : Natural;
   Base : Natural := 2;

begin
   loop
      Family_Size (Base, 1, Size);
      exit when Size >= 8;
      Base := Ps.Next_Prime (Base);
   end loop;
   Put_Line (Base'Img);
end Pr051;
