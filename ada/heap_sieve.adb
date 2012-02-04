package body Heap_Sieve is

   procedure Add_Node (Sieve : in out T; Next, Step : Natural);
   --  Add a new step, possibly creating the node.  The node should
   --  not already be present in the heap.

   procedure Update_First (Sieve : in out T);
   --  Update the lowest keyed node in the heap.

   function Hash (Key : Natural) return Ada.Containers.Hash_Type is
   begin
      return Ada.Containers.Hash_Type (Key);
   end Hash;

   function "<" (Left, Right : Node_Access) return Boolean is
   begin
      return Left.Next < Right.Next;
   end "<";

   procedure Next (Sieve : in out T; Value : out Natural) is
      Cur : Natural;
      Peek : Node_Access;
   begin
      case Sieve.Prime is
         when 2 =>
            Sieve.Prime := 3;
            Value := 2;

         when 3 =>
            Sieve.Prime := 5;
            Value := 3;
            Add_Node (Sieve, 9, 6);

         when others =>
            --  Advance the prime number until done.
            loop
               Peek := Sieve.Heap.Peek;
               Cur := Sieve.Prime;

               --  If the 'next' divisor is greater than our current
               --  number, the current is prime.
               if Cur < Peek.Next then
                  Sieve.Prime := Cur + 2;
                  Add_Node (Sieve, Cur * Cur, Cur + Cur);
                  Value := Cur;
                  return;

               else
                  --  Otherwise, this value is composite, advance to the next.
                  Update_First (Sieve);
                  Sieve.Prime := Sieve.Prime + 2;
               end if;
            end loop;
      end case;
   end Next;

   procedure Add_Node (Sieve : in out T; Next, Step : Natural) is
      use type Node_Maps.Cursor;
      Cursor : Node_Maps.Cursor;
      Temp : Node_Access;
   begin
      Cursor := Sieve.Nodes.Find (Next);
      if Cursor = Node_Maps.No_Element then
         Temp := new Node;
         Temp.Next := Next;
         Sieve.Nodes.Insert (Next, Temp);
         Sieve.Heap.Push (Temp);
      else
         Temp := Node_Maps.Element (Cursor);
      end if;
      Temp.Steps.Insert (Before   => Temp.Steps.Last_Index + 1,
                         New_Item => Step);
   end Add_Node;

   procedure Update_First (Sieve : in out T) is
      Head : constant Node_Access := Sieve.Heap.Pop;
      Next : constant Natural := Head.Next;
      Step : Natural;
   begin
      Sieve.Nodes.Delete (Next);

      --  Spread out the steps to all appropriate nodes.
      --  for Step of Head.Steps loop
      --     Add_Node (Sieve, Next + Step, Step);
      --  end loop;

      for Step_Index in Head.Steps.First_Index .. Head.Steps.Last_Index loop
         Step := Head.Steps.Element (Step_Index);
         Add_Node (Sieve, Next + Step, Step);
      end loop;
   end Update_First;

end Heap_Sieve;
