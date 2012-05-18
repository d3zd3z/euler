----------------------------------------------------------------------
--  Problem 39
--
--  14 March 2003
--
--
--  If p is the perimeter of a right angle triangle with integral length
--  sides, {a,b,c}, there are exactly three solutions for p = 120.
--
--  {20,48,52}, {24,45,51}, {30,40,50}
--
--  For which value of p ≤ 1000, is the number of solutions maximised?
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler.Triangle; use Euler.Triangle;
--  with Euler; use Euler;

procedure Pr039 is

   Counts : array (1 .. 1000) of Natural := (others => 0);

   procedure Add (Triple : Triple_Type; Size : Natural);

   pragma Warnings (Off, "formal parameter ""Triple"" is not referenced");
   procedure Add (Triple : Triple_Type; Size : Natural) is
   pragma Warnings (On, "formal parameter ""Triple"" is not referenced");
   begin
      Counts (Size) := Counts (Size) + 1;
   end Add;

   Largest : Natural := 0;
   Largest_Value : Natural := 0;

begin
   Generate_Triples (1000, Add'Access);

   for I in Counts'Range loop
      if Counts (I) > Largest then
         Largest := Counts (I);
         Largest_Value := I;
      end if;
   end loop;

   Put_Line (Natural'Image (Largest_Value));

end Pr039;

