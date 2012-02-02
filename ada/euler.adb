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

end Euler;
