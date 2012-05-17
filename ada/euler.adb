with Ada.Text_IO; use Ada.Text_IO;

package body Euler is

   procedure Print_Something (Value : Element) is
      Text : constant String := Element'Image (Value);
   begin
      Put_Line (Text (2 .. Text'Length));
   end Print_Something;

   procedure Print_Result (Value : Natural) is
      procedure Print is new Print_Something (Natural);
   begin
      Print (Value);
   end Print_Result;

   procedure Print_Result (Value : Long_Natural) is
      procedure Print is new Print_Something (Long_Natural);
   begin
      Print (Value);
   end Print_Result;

   procedure Next_Permutation (
      Items : in out Element_Array;
      Done  : out Boolean)
   is
      K : Natural := Items'First - 1;
      L : Natural := Items'First - 1;
      procedure Swap (A, B : Positive);
      procedure Flip (A, B : Positive);

      procedure Swap (A, B : Positive) is
         Temp : constant Element_Type := Items (A);
      begin
         Items (A) := Items (B);
         Items (B) := Temp;
      end Swap;

      procedure Flip (A, B : Positive) is
         AA : Positive := A;
         BB : Positive := B;
      begin
         while AA < BB loop
            Swap (AA, BB);
            AA := AA + 1;
            BB := BB - 1;
         end loop;
      end Flip;

   begin
      for X in Items'First .. Items'Last - 1 loop
         if Items (X) < Items (X + 1) then
            K := X;
         end if;
      end loop;
      if K < Items'First then
         Done := True;
         return;
      end if;

      for X in K + 1 .. Items'Last loop
         if Items (K) < Items (X) then
            L := X;
         end if;
      end loop;

      Swap (K, L);
      Flip (K + 1, Items'Last);

      Done := False;
   end Next_Permutation;

   --------------------
   -- Reverse_Number --
   --------------------
   function Reverse_Number (Number : Natural; Base : Natural := 10)
      return Natural
   is
      N : Natural := Number;
      Result : Natural := 0;
   begin
      while N > 0 loop
         Result := Result * Base + N mod Base;
         N := N / Base;
      end loop;

      return Result;
   end Reverse_Number;

end Euler;
