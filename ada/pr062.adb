----------------------------------------------------------------------
--  Problem 62

--
--  30 January 2004
--
--
--  The cube, 41063625 (345^3), can be permuted to produce two other
--  cubes: 56623104 (384^3) and 66430125 (405^3). In fact, 41063625 is
--  the smallest cube which has exactly three permutations of its digits
--  which are also cube.
--
--  Find the smallest cube for which exactly five permutations of its
--  digits are cube.
--
--  127035954683
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers;
with Ada.Containers.Ordered_Sets;
with Ada.Containers.Ordered_Maps;

with Prime_Sieve;
--  with Euler; use Euler;

procedure Pr062 is

   type U64 is mod 2 ** 64
      with Size => 64;

   subtype Count_Type is Ada.Containers.Count_Type;
   use type Count_Type;

   --  Each digit "value" has a list of the cube bases that build it.
   package U64_Sets is new Ada.Containers.Ordered_Sets
      (Element_Type => U64);
   subtype U64_Set is U64_Sets.Set;

   package Full_Maps is new Ada.Containers.Ordered_Maps
      (Key_Type => U64,
       Element_Type => U64_Set,
       "=" => U64_Sets."=");
   subtype Full_Map is Full_Maps.Map;

   function Number_Value (Number : U64) return U64;
   --  Convert a number into another number that describes the digits present
   --  in the original number, without regard to the order of the digits.

   Early_Primes : array (U64 range 0 .. 9) of U64;

   procedure Init_Early_Primes;

   procedure Solve (Result : out U64);

   -----------------------
   -- Init_Early_Primes --
   -----------------------

   procedure Init_Early_Primes is
      P : Natural := 2;
   begin
      for Pos in Early_Primes'Range loop
         Early_Primes (Pos) := U64 (P);
         P := Prime_Sieve.Next_Prime (P);
      end loop;
   end Init_Early_Primes;

   ------------------
   -- Number_Value --
   ------------------

   function Number_Value (Number : U64) return U64 is
      Work : U64 := Number;
      Product : U64 := 1;
   begin
      while Work > 0 loop
         Product := Product * Early_Primes (Work mod 10);
         Work := Work / 10;
      end loop;

      return Product;
   end Number_Value;

   -----------
   -- Solve --
   -----------

   procedure Solve (Result : out U64) is
      use type Full_Maps.Cursor;

      Work : Full_Map;
      Base : U64 := 1;
      Key : U64;
      Place : Full_Maps.Cursor;
   begin
      loop
         Key := Number_Value (Base ** 3);
         Place := Work.Find (Key);
         if Place = Full_Maps.No_Element then
            --  Insert a new element.
            declare
               Target : U64_Set;
            begin
               --  Ada.Text_IO.Put_Line ("Insert:" & Base'Img & "," & Key'Img);
               Target.Insert (Base);
               Work.Insert (Key, Target);
            end;
         else
            declare
               Count : Count_Type := 0;
               procedure Updater (Key : U64; Target : in out U64_Set);

               pragma Warnings (Off, "*""Key""*not referenced");
               procedure Updater (Key : U64; Target : in out U64_Set) is
               begin
                  Target.Insert (Base);
                  Count := Target.Length;
                  --  Ada.Text_IO.Put_Line ("Count:" & Count'Img);

                  Result := Target.First_Element ** 3;
               end Updater;
               pragma Warnings (On, "*""Key""*not referenced");
            begin
               Work.Update_Element (Place, Updater'Access);
               exit when Count = 5;
            end;
         end if;

         Base := Base + 1;
      end loop;
   end Solve;

   Result : U64;

begin
   Init_Early_Primes;
   Solve (Result);
   Put_Line (U64'Image (Result));
end Pr062;

