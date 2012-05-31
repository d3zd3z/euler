----------------------------------------------------------------------
--  Problem 42

--
--  25 April 2003
--
--
--  The n^th term of the sequence of triangle numbers is given by, t[n] =
--  1/2n(n+1); so the first ten triangle numbers are:
--
--  1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
--
--  By converting each letter in a word to a number corresponding to its
--  alphabetical position and adding these values we form a word value.
--  For example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If
--  the word value is a triangle number then we shall call the word a
--  triangle word.
--
--  Using words.txt (right click and 'Save Link/Target As...'), a 16K
--  text file containing nearly two-thousand common English words, how
--  many are triangle words?
--
--
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler; use Euler;
--  with Ada.Containers.Vectors;
--  with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Pr042 is

   procedure Read_Words;
   function Is_Triangle (Number : Natural) return Boolean;
   procedure Process (Word : String);

   Count : Natural := 0;

   -----------------
   -- Is_Triangle --
   -----------------

   function Is_Triangle (Number : Natural) return Boolean is
      Square : constant Natural := (Number * 8) + 1;
      Root : constant Natural := ISqrt (Square);
   begin
      return (Root * Root) = Square;
   end Is_Triangle;

   procedure Process (Word : String) is
      Sum : Natural := 0;
   begin
      for Ch of Word loop
         Sum := Sum + Character'Pos (Ch) - Character'Pos ('A') + 1;
      end loop;

      if Is_Triangle (Sum) then
         Count := Count + 1;
      end if;
   end Process;

   ----------------
   -- Read_Words --
   ----------------

   procedure Read_Words is
      File : File_Type;
   begin
      Open (File => File, Mode => In_File, Name => "../haskell/words.txt");

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
            exit when Pos >= Line'Last;
            Must ('"');
            Left := Pos;

            while Line (Pos) /= '"' loop
               Pos := Pos + 1;
            end loop;
            Right := Pos - 1;

            Process (Line (Left .. Right));

            Must ('"');
            if Pos <= Line'Last then
               Must (',');
            end if;
         end loop;
      end;

      Close (File);

   end Read_Words;

begin
   Read_Words;
   Put_Line (Natural'Image (Count));
end Pr042;

