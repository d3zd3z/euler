----------------------------------------------------------------------
--  A heap-based priority queue.
----------------------------------------------------------------------

private with Ada.Containers.Vectors;

generic
   type Element_Type is private;

   with function "=" (Left, Right : Element_Type) return Boolean is <>;
   with function "<" (Left, Right : Element_Type) return Boolean is <>;

package Heap is

   type Heap is tagged limited private;

   function Pop (Object : in out Heap) return Element_Type
     with Pre => not Empty (Object);
   --  Remove the youngest element from the heap.

   function Peek (Object : in out Heap) return Element_Type
     with Pre => not Empty (Object);

   procedure Push (Object : in out Heap; Item : Element_Type);
   --  Insert a new element into the heap.

   function Empty (Object : Heap) return Boolean
     with Inline => True;

   generic
      with function Image (Item : Element_Type) return String;
   procedure Dump (Object : in Heap);

private

   subtype Index_Type is Natural;

   --  Heaps assume zero-based indexing.
   package V is new Ada.Containers.Vectors
     (Index_Type   => Index_Type,
      Element_Type => Element_Type,
      "="          => "=");

   type Heap is tagged limited record
      Data : V.Vector;
   end record;

end Heap;
