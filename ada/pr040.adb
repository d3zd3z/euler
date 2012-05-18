----------------------------------------------------------------------
--  Problem 40
--
--  28 March 2003
--
--
--  An irrational decimal fraction is created by concatenating the
--  positive integers:
--
--  0.123456789101112131415161718192021...
--
--  It can be seen that the 12^th digit of the fractional part is 1.
--
--  If d[n] represents the n^th digit of the fractional part, find the
--  value of the following expression.
--
--  d[1] x d[10] x d[100] x d[1000] x d[10000] x d[100000] x d[1000000]
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr040 is

   Pos : Natural := 0;
   Product : Natural := 1;

   function Done return Boolean;
   procedure Add_Number (Number : Natural);
   function Interesting return Boolean;

   J : Natural := 1;

   ----------------
   -- Add_Number --
   ----------------

   procedure Add_Number (Number : Natural) is
      Text : constant String := Natural'Image (Number);
      Item : Natural;
   begin
      for K in Text'First + 1 .. Text'Last loop
         Pos := Pos + 1;
         if Interesting then
            Item := Natural'Value (Text (K .. K));
            Product := Product * Item;
         end if;
      end loop;
   end Add_Number;

   ----------
   -- Done --
   ----------

   function Done return Boolean is
   begin
      return Pos > 1_000_000;
   end Done;

   -----------------
   -- Interesting --
   -----------------

   function Interesting return Boolean is
   begin
      --  Interesting values are those that consist of a power of 10.  It's a
      --  small set, so just check them explicitly.
      return Pos = 1 or else Pos = 10 or else Pos = 100 or else
         Pos = 1_000 or else Pos = 10_000 or else Pos = 100_000 or else
         Pos = 1_000_000;
   end Interesting;

begin
   while not Done loop
      Add_Number (J);
      J := J + 1;
   end loop;

   Put_Line (Natural'Image (Product));
end Pr040;

