--  Euler utilities.

package Euler is

   generic
      type Element is (<>);
   procedure Print_Something (Value : Element);
   --  Print the result of an Euler problem, assuming it is a Natural.

   subtype Long_Natural is Long_Integer range 0 .. Long_Integer'Last;

   procedure Print_Result (Value : Natural);
   procedure Print_Result (Value : Long_Natural);

   generic
      type Element_Type is private;
      type Element_Array is array (Positive range <>) of Element_Type;

      with function "<" (Left, Right : Element_Type) return Boolean is <>;
   procedure Next_Permutation (
      Items : in out Element_Array;
      Done  : out Boolean);
   --  Modify Items in place to compute the next permutation.  If the items is
   --  already the largest lexical permutation, doesn't modify it, and sets
   --  Done to True.  Otherwise, the Items will contain the next possible
   --  permutation, and Done will be set to False.

end Euler;
