----------------------------------------------------------------------
--  Problem 60
--
--  02 January 2004
--
--
--  The primes 3, 7, 109, and 673, are quite remarkable. By taking any
--  two primes and concatenating them in any order the result will always
--  be prime. For example, taking 7 and 109, both 7109 and 1097 are
--  prime. The sum of these four primes, 792, represents the lowest sum
--  for a set of four primes with this property.
--
--  Find the lowest sum for a set of five primes for which any two primes
--  concatenate to produce another prime.
--
--  26033
----------------------------------------------------------------------

with Ada.Containers.Ordered_Sets;
with Ada.Containers.Ordered_Maps;
with Ada.Text_IO; use Ada.Text_IO;
with Miller_Rabin;
with Prime_Sieve;
--  with Euler; use Euler;

procedure Pr060 is

   --  Container types for holding the results.
   package Natural_Sets is new Ada.Containers.Ordered_Sets
     (Element_Type => Natural);
   subtype Natural_Set is Natural_Sets.Set;

   package Full_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type => Natural,
      Element_Type => Natural_Sets.Set,
      "=" => Natural_Sets."=");
   subtype Full_Map is Full_Maps.Map;

   Mapping : Full_Map;
   --  For each number, gives the set of other numbers that are
   --  pairwise combinable with it.

   procedure Build_Pairs;
   procedure Check (X, Y : Natural);
   function Concat_Numbers (A, B : Natural) return Natural;
   procedure Walk (Item : Natural);
   procedure Sub_Walk (Item     : Natural;
                       Possible : Natural_Set;
                       Depth    : Natural);
   procedure Top_Walk;

   Solution : array (1 .. 5) of Natural;

   -----------------
   -- Build_Pairs --
   -----------------

   procedure Build_Pairs is
      X, Y : Natural := 2;
   begin
      while X < 10000 loop

         Y := Prime_Sieve.Next_Prime (X);
         while Y < 10000 loop
            Check (X, Y);

            Y := Prime_Sieve.Next_Prime (Y);
         end loop;

         X := Prime_Sieve.Next_Prime (X);
      end loop;
   end Build_Pairs;

   -----------
   -- Check --
   -----------

   procedure Check (X, Y : Natural) is

      procedure Add_Ab (A, B : Natural);

      procedure Add_Ab (A, B : Natural) is
         Cursor : Full_Maps.Cursor;
         Inserted : Boolean;

         procedure Add_B (Key : Natural; Element : in out Natural_Set);
         procedure Add_B (Key : Natural; Element : in out Natural_Set)
         is
         begin
            pragma Assert (A = Key);
            Element.Include (B);
         end Add_B;
      begin
         Mapping.Insert (Key => A,
                         New_Item => Natural_Sets.Empty_Set,
                         Position => Cursor,
                         Inserted => Inserted);
         Mapping.Update_Element (Cursor, Add_B'Access);
      end Add_Ab;

   begin
      if Miller_Rabin.Is_Prime (Concat_Numbers (X, Y)) and then
        Miller_Rabin.Is_Prime (Concat_Numbers (Y, X))
      then
         Add_Ab (X, Y);
         Add_Ab (Y, X);
      end if;
   end Check;

   --------------------
   -- Concat_Numbers --
   --------------------

   function Concat_Numbers (A, B : Natural) return Natural is
      Result : Natural := A;
      Temp : Natural := B;
   begin
      while Temp > 0 loop
         Result := Result * 10;
         Temp := Temp / 10;
      end loop;

      return Result + B;
   end Concat_Numbers;

   --------------
   -- Sub_Walk --
   --------------

   procedure Sub_Walk (Item     : Natural;
                       Possible : Natural_Set;
                       Depth    : Natural)
   is
      use type Natural_Sets.Cursor;
      Item_Set : Natural_Set renames Mapping (Item).Element.all;
      Next_Set : constant Natural_Set := Possible.Intersection (Item_Set);
      Cur : Natural_Sets.Cursor;
      Elt : Natural;
   begin
      if Depth = 5 then
         Put ("solved:");
         for X of Solution loop
            Put (X'Img);
         end loop;
         New_Line;
         return;
      end if;

      Put_Line ("Sub walk, depth:" & Depth'Img);
      Put_Line ("  next set size:" & Next_Set.Length'Img);
      Cur := Next_Set.First;
      while Cur /= Natural_Sets.No_Element loop
         Elt := Natural_Sets.Element (Cur);
         Solution (Depth + 1) := Elt;
         Put_Line (Elt'Img);
         Sub_Walk (Elt, Next_Set, Depth + 1);
         Cur := Natural_Sets.Next (Cur);
      end loop;
      Put_Line ("Leave sub walk:" & Depth'Img);
   end Sub_Walk;

   --------------
   -- Top_Walk --
   --------------

   procedure Top_Walk is
      use type Full_Maps.Cursor;
      Cur : Full_Maps.Cursor;
      Key : Natural;
   begin
      Cur := Mapping.First;
      while Cur /= Full_Maps.No_Element loop
         Key := Full_Maps.Key (Cur);
         Solution (1) := Key;
         Walk (Key);
         Cur := Full_Maps.Next (Cur);
      end loop;
   end Top_Walk;

   ----------
   -- Walk --
   ----------

   procedure Walk (Item : Natural) is
      use type Natural_Sets.Cursor;
      This_Set : Natural_Set renames Mapping (Item).Element.all;
      Cur : Natural_Sets.Cursor;
      Elt : Natural;
   begin
      Cur := This_Set.First;
      while Cur /= Natural_Sets.No_Element loop
         Elt := Natural_Sets.Element (Cur);
         Solution (2) := Elt;
         --  Put_Line (Natural_Sets.Element (Cur)'Img);
         Sub_Walk (2, This_Set, 2);
         Cur := Natural_Sets.Next (Cur);
      end loop;
      New_Line;
   end Walk;

begin
   Build_Pairs;
   Put_Line (Mapping.Length'Img);
   Put_Line (Mapping.First_Key'Img);

   Top_Walk;
end Pr060;
