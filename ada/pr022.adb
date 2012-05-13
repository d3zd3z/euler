----------------------------------------------------------------------
--  Problem 22
--
--  19 July 2002
--
--  Using names.txt (right click and 'Save Link/Target As...'), a 46K text
--  file containing over five-thousand first names, begin by sorting it into
--  alphabetical order. Then working out the alphabetical value for each name,
--  multiply this value by its alphabetical position in the list to obtain a
--  name score.
--
--  For example, when the list is sorted into alphabetical order, COLIN, which
--  is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
--  COLIN would obtain a score of 938 x 53 = 49714.
--
--  What is the total of all the name scores in the file?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Euler; use Euler;

procedure Pr022 is

   procedure Read_Names;

   type Info is
      record
         Name : Unbounded_String;
         Score : Natural;
      end record;

   function Name_Less (Left, Right : Info) return Boolean;

   function Make_Info (Name : String) return Info;

   package Info_Vectors is new Ada.Containers.Vectors
      (Index_Type => Natural,
       Element_Type => Info);

   subtype Info_Vector is Info_Vectors.Vector;

   Names : Info_Vector;

   package Info_Sorting is new Info_Vectors.Generic_Sorting (Name_Less);

   procedure Read_Names is
      File : File_Type;
   begin
      Open (File => File, Mode => In_File, Name => "../haskell/names.txt");

      declare
         Line : constant String := Get_Line (File);
         Pos : Natural := Line'First;
         Left, Right : Natural;

         procedure Must (Ch : Character);
         procedure Must (Ch : Character) is
         begin
            if Line (Pos) /= Ch then
               raise Constraint_Error;
            end if;
            Pos := Pos + 1;
         end Must;

      begin
         loop
            exit when Pos > Line'Last;
            Must ('"');
            Left := Pos;

            while Line (Pos) /= '"' loop
               Pos := Pos + 1;
            end loop;
            Right := Pos - 1;

            Names.Append (Make_Info (Line (Left .. Right)));

            Must ('"');
            if Pos <= Line'Last then
               Must (',');
            end if;
         end loop;
      end;

      Close (File);
   end Read_Names;

   function Make_Info (Name : String) return Info is
      Item : Info;
      Score : Natural := 0;
   begin
      Item.Name := To_Unbounded_String (Name);
      for Ch of Name loop
         Score := Score + Character'Pos (Ch) - Character'Pos ('A') + 1;
      end loop;
      Item.Score := Score;
      return Item;
   end Make_Info;

   function Name_Less (Left, Right : Info) return Boolean is
   begin
      return Left.Name < Right.Name;
   end Name_Less;

   Total : Natural := 0;

begin
   Read_Names;
   Info_Sorting.Sort (Names);

   for I in Names.First_Index .. Names.Last_Index loop
      declare
         X : Info renames Names.Element (I);
         Pos : constant Natural := I - Names.First_Index + 1;
      begin
         Total := Total + Pos * X.Score;
      end;
   end loop;

   Print_Result (Total);
end Pr022;

