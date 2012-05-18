----------------------------------------------------------------------
--  Triangle utilities.

with Ada.Containers.Vectors;

package body Euler.Triangle is

   package Box_Vectors is new Ada.Containers.Vectors (
      Index_Type => Natural,
      Element_Type => Box_Type);

   subtype Box_Vector is Box_Vectors.Vector;

   Initial_Box : constant Box_Type := (
      P1 => 1,
      P2 => 1,
      Q1 => 2,
      Q2 => 3);

   procedure Add_Children (Box : Box_Type; Destination : in out Box_Vector);
   --  Add the children of the specified Box to the Destination vector.

   procedure Generate_Fibonacci_Triples (Limit : Natural;
      Act : not null access procedure (
         Triple : Triple_Type;
         Circumference : Natural));

   procedure Make_Triple (Box : Box_Type; Triple : out Triple_Type);

   procedure Multiply_Triple (Triple : Triple_Type;
      K : Natural;
      Result : out Triple_Type);

   function Compute_Circumference (Triple : Triple_Type) return Natural;

   ------------------
   -- Add_Children --
   ------------------
   procedure Add_Children (Box : Box_Type; Destination : in out Box_Vector) is
      X : constant Natural := Box.P2;
      Y : constant Natural := Box.Q2;
   begin
      Destination.Append
         (Box_Type'(P1 => Y - X, P2 => X, Q1 => Y, Q2 => Y * 2 - X));
      Destination.Append
         (Box_Type'(P1 => X, P2 => Y, Q1 => X + Y, Q2 => X * 2 + Y));
      Destination.Append
         (Box_Type'(P1 => Y, P2 => X, Q1 => X + Y, Q2 => Y * 2 + X));
   end Add_Children;

   function Compute_Circumference (Triple : Triple_Type) return Natural is
   begin
      return Triple.A + Triple.B + Triple.C;
   end Compute_Circumference;

   --------------------------------
   -- Generate_Fibonacci_Triples --
   --------------------------------
   procedure Generate_Fibonacci_Triples (Limit : Natural;
      Act : not null access procedure (
         Triple : Triple_Type;
         Circumference : Natural))
   is
      Work : Box_Vector;
      Box : Box_Type;
      Triple : Triple_Type;
      Circumference : Natural;
   begin
      Work.Append (Initial_Box);

      while not Work.Is_Empty loop
         --  Note that this isn't very efficient.  A list might be better.
         Box := Work.First_Element;
         Work.Delete_First;

         Make_Triple (Box, Triple);
         Circumference := Compute_Circumference (Triple);
         if Circumference <= Limit then
            Add_Children (Box, Work);
            Act (Triple, Circumference);
         end if;
      end loop;
   end Generate_Fibonacci_Triples;

   ----------------------
   -- Generate_Triples --
   ----------------------
   procedure Generate_Triples (Limit : Natural;
      Act : not null access procedure (
         Triple : Triple_Type;
         Circumference : Natural))
   is
      procedure Sub_Act (Triple : Triple_Type; Circumference : Natural);

      pragma Warnings
         (Off, "formal parameter ""Circumference"" is not referenced");
      procedure Sub_Act (Triple : Triple_Type; Circumference : Natural) is
         K_Triple : Triple_Type;
         K_Size : Natural;
         K : Natural := 1;
      begin
         loop
            Multiply_Triple (Triple, K, K_Triple);
            K_Size := Compute_Circumference (K_Triple);
            exit when K_Size > Limit;
            Act (K_Triple, K_Size);
            K := K + 1;
         end loop;
      end Sub_Act;
      pragma Warnings
         (On, "formal parameter ""Circumference"" is not referenced");
   begin
      Generate_Fibonacci_Triples (Limit, Sub_Act'Access);
   end Generate_Triples;

   -----------------
   -- Make_Triple --
   -----------------
   procedure Make_Triple (Box : Box_Type; Triple : out Triple_Type) is
   begin
      Triple.A := Box.Q1 * Box.P1 * 2;
      Triple.B := Box.Q2 * Box.P2;
      Triple.C := Box.P1 * Box.Q2 + Box.P2 * Box.Q1;
   end Make_Triple;

   ---------------------
   -- Multiply_Triple --
   ---------------------
   procedure Multiply_Triple (Triple : Triple_Type;
      K : Natural;
      Result : out Triple_Type)
   is
   begin
      Result.A := Triple.A * K;
      Result.B := Triple.B * K;
      Result.C := Triple.C * K;
   end Multiply_Triple;

end Euler.Triangle;
