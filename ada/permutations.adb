--  Generation array permutations.

package body Permutations is

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Object : in out Permutation_State) is
      Index : Positive := 1;
   begin
      for I in Object.Indices'Range loop
         Object.Indices (I).Direction := -1;
         Object.Indices (I).Index := Index;
         Index := Index + 1;
      end loop;

      Object.Indices (Object.Indices'First).Direction := 0;
   end Initialize;

   ----------------------
   -- Next_Permutation --
   ----------------------

   procedure Next_Permutation (State : in out Permutation_State;
                               Swap  :    out Swap_Type;
                               Done  :    out Boolean)
   is
      Chosen : Natural := Natural'First;
      Oldpos : Index_Type := Index_Type'First;
      Direction : Integer;
      Newpos : Index_Type;
      Temp : Directed_Index;
   begin
      for I in State.Indices'Range loop
         if State.Indices (I).Direction /= 0 and then
           State.Indices (I).Index > Chosen
         then
            Chosen := State.Indices (I).Index;
            Oldpos := I;
         end if;
      end loop;

      if Chosen = Natural'First then
         Done := True;
         return;
      else
         Done := False;
      end if;

      Direction := Integer (State.Indices (Oldpos).Direction);
      Newpos := Index_Type (Integer (Oldpos) + Direction);

      Swap.A := Oldpos;
      Swap.B := Newpos;

      --  Swap the elements.
      Temp := State.Indices (Oldpos);
      State.Indices (Oldpos) := State.Indices (Newpos);
      State.Indices (Newpos) := Temp;

      --  Check if this element either reaches the last position in
      --  the permutation, or the next element in this direction is
      --  larger than the chosen element, make this element 'static'.
      if (Newpos = State.Indices'First or else
            Newpos = State.Indices'Last or else
            State.Indices (Index_Type (Integer (Newpos) + Direction)).Index
            > Chosen)
      then
         State.Indices (Newpos).Direction := 0;
      end if;

      --  Find any pieces that are larger than the one we just moved,
      --  and make them mobile, toward the moved one.
      for I in State.Indices'First .. Newpos - 1 loop
         if State.Indices (I).Index > State.Indices (Newpos).Index then
            State.Indices (I).Direction := 1;
         end if;
      end loop;

      for I in Newpos + 1 .. State.Indices'Last loop
         if State.Indices (I).Index > State.Indices (Newpos).Index then
            State.Indices (I).Direction := -1;
         end if;
      end loop;
   end Next_Permutation;

end Permutations;
