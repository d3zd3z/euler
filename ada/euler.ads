--  Euler utilities.

package Euler is

   generic
      type Element is (<>);
   procedure Print_Something (Value : Element);
   --  Print the result of an Euler problem, assuming it is a Natural.

   subtype Long_Natural is Long_Integer range 0 .. Long_Integer'Last;

   procedure Print_Result (Value : Natural);
   procedure Print_Result (Value : Long_Natural);

end Euler;
