----------------------------------------------------------------------
--  A heap-based prime number sieve.
----------------------------------------------------------------------

private with Heap;
private with Ada.Containers.Vectors;
private with Ada.Containers.Hashed_Maps;

package Heap_Sieve is

   type T is tagged limited private;

   procedure Next (Sieve : in out T; Value : out Natural);
   --  Advance the sieve to the next value.

private

   package Natural_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => Natural);

   type Node is record
      Next : Natural;
      Steps : Natural_Vectors.Vector;
   end record;

   type Node_Access is access Node;

   function Hash (Key : Natural) return Ada.Containers.Hash_Type;

   function "<" (Left, Right : Node_Access) return Boolean;

   package Node_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Natural,
      Element_Type    => Node_Access,
      Hash            => Hash,
      Equivalent_Keys => "=");

   package Node_Heap is new Heap
     (Element_Type => Node_Access);

   type T is tagged limited record
      Prime : Natural := 2;
      Heap  : Node_Heap.Heap;
      Nodes : Node_Maps.Map;
   end record;

end Heap_Sieve;
