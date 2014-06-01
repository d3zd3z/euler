----------------------------------------------------------------------

with Ada.Text_IO;

package body Heap is

   procedure Down (Object : in out Heap; I, N : Index_Type);
   --  Given a heap of size N, move node I down appropriately

   procedure Up (Object : in out Heap; I : Index_Type);
   --  Move object I upward in the heap.

   --  procedure Initialize (Object : in out Heap) is
   --     use Ada.Text_IO;
   --  begin
   --     Put_Line ("Heap: " & Object.Data.First_Index'Img &
   --                 " .. " & Object.Data.Last_Index'Img);
   --  end Initialize;

   function Empty (Object : Heap) return Boolean is
   begin
      return Object.Data.Last_Index < Object.Data.First_Index;
   end Empty;

   function Pop (Object : in out Heap) return Element_Type is
      Last : constant V.Extended_Index := Object.Data.Last_Index;
      Result : Element_Type;
   begin
      if Last not in Index_Type then
         raise Constraint_Error;
      end if;

      Result := Object.Data.First_Element;

      --  Swap the '0' element with the last in the heap.
      if Last > 0 then
         Object.Data.Swap (0, Last);
         Down (Object, 0, Last);
      end if;

      Object.Data.Delete (Last);
      return Result;
   end Pop;

   function Peek (Object : in out Heap) return Element_Type is
   begin
      return Object.Data.First_Element;
   end Peek;

   procedure Push (Object : in out Heap; Item : Element_Type) is
      Last : V.Extended_Index := Object.Data.Last_Index;
   begin
      Object.Data.Insert (Before   => Last + 1,
                          New_Item => Item);
      Last := Object.Data.Last_Index;
      Up (Object, Last);
   end Push;

   procedure Down (Object : in out Heap; I, N : Index_Type) is
      J1, J2, J : Index_Type;
      I_Work : Index_Type := I;
   begin
      loop
         J1 := I_Work * 2 + 1;
         exit when J1 >= N;
         J2 := J1 + 1;
         if J2 < N and then
           not (Object.Data.Element (J1) < Object.Data.Element (J2))
         then
            J := J2;
         else
            J := J1;
         end if;
         exit when Object.Data.Element (I_Work) < Object.Data.Element (J);
         Object.Data.Swap (I_Work, J);
         I_Work := J;
      end loop;
   end Down;

   procedure Up (Object : in out Heap; I : Index_Type) is
      I_Work : Index_Type;
      J : Index_Type := I;
   begin
      loop
         I_Work := (J - 1) / 2;
         exit when I_Work = J
           or else Object.Data.Element (I_Work) < Object.Data.Element (J);
         Object.Data.Swap (I_Work, J);
         J := I_Work;
      end loop;
   end Up;

   package Natural_IO is new Ada.Text_IO.Integer_IO (Index_Type);

   procedure Dump (Object : in Heap) is
      use Natural_IO;
      use Ada.Text_IO;
   begin
      --  To start, just print out the heap with the indexes.
      Put_Line ("Heap:");
      for Index in Object.Data.First_Index .. Object.Data.Last_Index loop
         Put (Index, 3);
         Put (": ");
         Put (Image (Object.Data.Element (Index)));
         New_Line;
      end loop;
   end Dump;

end Heap;
