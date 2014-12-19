--  Generate the problem list.
--
--  Scans the current directory for problems, and generates the
--  problem list data structure.

with Ada.Directories; use Ada.Directories;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;

procedure Generate_List is

   procedure Put_Padded (Item : Natural; Count : Natural;
                                         Pad : Character := '0');

   procedure Put_Padded (Item : Natural; Count : Natural;
                                         Pad : Character := '0')
   is
      Text : constant String := Natural'Image (Item);
   begin
      for I in Text'Length .. Count loop
         Put (Pad);
      end loop;
      Put (Text (2 .. Text'Last));
   end Put_Padded;

   package Natural_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => Natural);

   package Nv_Sort is new Natural_Vectors.Generic_Sorting;

   Search : Search_Type;
   Single : Directory_Entry_Type;

   Nodes : Natural_Vectors.Vector;
   Last_Node : Natural;

begin
   Start_Search (Search, ".", "pr[0-9][0-9][0-9].adb",
                 (Ordinary_File => True, others => False));
   while More_Entries (Search) loop
      Get_Next_Entry (Search, Single);
      declare
         Name : constant String := Simple_Name (Single);
      begin
         Nodes.Append (Natural'Value (Name (3 .. 5)));
      end;
   end loop;
   End_Search (Search);

   Nv_Sort.Sort (Nodes);

   Put_Line ("--  Project euler problems.  Auto generated, do not edit");
   New_Line;
   for N of Nodes loop
      Put ("private with Pr");
      Put_Padded (N, 3);
      Put_Line (";");
   end loop;

   New_Line;
   Put_Line ("package Problem_List is");
   New_Line;
   Put_Line ("   type Problem is record");
   Put_Line ("      Index : Natural;");
   Put_Line ("      Action : access procedure;");
   Put_Line ("   end record;");
   New_Line;
   Put ("   Problem_Count : constant :=");
   Put (Natural'Image (Nodes.Last_Index - Nodes.First_Index + 1));
   Put_Line (";");
   New_Line;
   Put_Line ("   type Problem_Array is array (1 .. Problem_Count) " &
               "of aliased Problem;");
   New_Line;
   Put_Line ("   Problems : constant Problem_Array;");
   New_Line;
   Put_Line ("private");
   New_Line;
   Put_Line ("   Problems : constant Problem_Array := (");
   Last_Node := Nodes.Last_Element;
   for N of Nodes loop
      Put ("      (Index => ");
      Put_Padded (N, 3, ' ');
      Put (", Action => Pr");
      Put_Padded (N, 3);
      Put ("'Access)");
      if N /= Last_Node then
         Put (',');
      else
         Put (");");
      end if;
      New_Line;
   end loop;
   New_Line;
   Put_Line ("end Problem_List;");

end Generate_List;
