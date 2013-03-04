--  Generate permutations of an array.

private with Ada.Finalization;

generic
   type Index_Type is range <>;

package Permutations is

   type Permutation_State (Low, High : Index_Type) is tagged limited private;

   type Swap_Type is
      record
         A, B : Index_Type;
      end record;

   procedure Next_Permutation (State : in out Permutation_State;
                               Swap  :    out Swap_Type;
                               Done  :    out Boolean);
   --  If there are more permutations, set the values in 'Swap' to the
   --  next permutation to perform, and set Done to true.  Otherwise,
   --  set Done to false.

private

   type Direction_Type is range -1 .. 1;

   type Directed_Index is
      record
         Direction : Direction_Type;
         Index     : Natural;
      end record;

   type Directed_Index_Array is array (Index_Type range <>)
     of Directed_Index;

   type Permutation_State (Low, High : Index_Type) is
     new Ada.Finalization.Limited_Controlled with
      record
         Indices : Directed_Index_Array (Low .. High);
      end record;

   procedure Initialize (Object : in out Permutation_State);

end Permutations;
