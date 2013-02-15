----------------------------------------------------------------------
--  Problem 49
--
--  01 August 2003
--
--
--  The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
--  increases by 3330, is unusual in two ways: (i) each of the three
--  terms are prime, and, (ii) each of the 4-digit numbers are
--  permutations of one another.
--
--  There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
--  primes, exhibiting this property, but there is one other 4-digit
--  increasing sequence.
--
--  What 12-digit number do you form by concatenating the three terms in
--  this sequence?
--
--  296962999629
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Euler;
with Prime_Sieve;

with Ada.Containers;

procedure Pr049 is

   type Digit is range 0 .. 9;
   type Digit_Array is array (Positive range <>) of Digit;

   subtype Natural_Vector is Prime_Sieve.Natural_Vectors.Vector;

   use type Ada.Containers.Count_Type;

   procedure Permute_Digits is new Euler.Next_Permutation (Digit, Digit_Array);

   function To_Digit_Array (Number : Positive) return Digit_Array;
   --  Convert a number into an array of the digits of that number.

   function From_Digit_Array (Seq : Digit_Array) return Natural;
   --  Convert a digit array back into a number.

   function Is_Ascending_Number (Number : Positive) return Boolean;
   --  Determine if the digits of the number are monotonically increasing.

   procedure All_Permutations (Number : Positive;
                               Permutations : out Natural_Vector);
   --  Fill the vector with all (prime) permutations of the given number.

   procedure With_Selections
     (Full : Natural_Vector;
      Action : access procedure (Elements : Natural_Vector));
   --  Call Action with every subset of the Full elements.

   procedure Check_Valid (Elements : Natural_Vector);
   --  Print out the result if the given vector meets the criteria of
   --  the problem definition.

   procedure Put_Terse (Element : Natural);
   --  Like 'Put' but without the leading space.

   ----------------------
   -- All_Permutations --
   ----------------------
   procedure All_Permutations (Number : Positive;
                               Permutations : out Natural_Vector)
   is
      Seq : Digit_Array := To_Digit_Array (Number);
      Done : Boolean;
      Temp : Natural;
   begin
      Permutations.Clear;
      if Prime_Sieve.Is_Prime (Number) then
         Permutations.Append (Number);
      end if;

      loop
         Permute_Digits (Seq, Done);
         exit when Done;

         Temp := From_Digit_Array (Seq);
         if Prime_Sieve.Is_Prime (Temp) then
            Permutations.Append (Temp);
         end if;
      end loop;
   end All_Permutations;

   -----------------
   -- Check_Valid --
   -----------------
   procedure Check_Valid (Elements : Natural_Vector) is
      Base : Natural;
   begin
      if Elements.Length /= 3 then
         return;
      end if;

      Base := Elements.First_Index;

      if Elements.Element (Base + 1) - Elements.Element (Base) /=
        Elements.Element (Base + 2) - Elements.Element (Base + 1)
      then
         return;
      end if;

      Put_Terse (Elements.Element (Base));
      Put_Terse (Elements.Element (Base + 1));
      Put_Terse (Elements.Element (Base + 2));
      New_Line;
   end Check_Valid;

   ----------------------
   -- From_Digit_Array --
   ----------------------
   function From_Digit_Array (Seq : Digit_Array) return Natural is
      Result : Natural := 0;
   begin
      for I in Seq'Range loop
         Result := Result * 10 + Natural (Seq (I));
      end loop;

      return Result;
   end From_Digit_Array;

   -------------------------
   -- Is_Ascending_Number --
   -------------------------
   function Is_Ascending_Number (Number : Positive) return Boolean is
      Current : Natural := 9;
      Temp : Natural := Number;
      Single : Natural;
   begin
      while Temp > 0 loop
         Single := Temp mod 10;
         if Single > Current then
            return False;
         end if;
         Current := Single;
         Temp := Temp / 10;
      end loop;

      return True;
   end Is_Ascending_Number;

   --------------------
   -- To_Digit_Array --
   --------------------
   function To_Digit_Array (Number : Positive) return Digit_Array is
      Temp : Natural := Number;
      Count : Natural := 0;
   begin
      --  Determine how many digits are present.
      while Temp > 0 loop
         Count := Count + 1;
         Temp := Temp / 10;
      end loop;

      declare
         Result : Digit_Array (1 .. Count);
      begin
         Temp := Number;
         for I in reverse Result'Range loop
            Result (I) := Digit (Temp mod 10);
            Temp := Temp / 10;
         end loop;

         return Result;
      end;

   end To_Digit_Array;

   ---------------
   -- Put_Terse --
   ---------------
   procedure Put_Terse (Element : Natural) is
      Text : constant String := Natural'Image (Element);
   begin
      Put (Text (Text'First + 1 .. Text'Last));
   end Put_Terse;

   ---------------------
   -- With_Selections --
   ---------------------
   procedure With_Selections
     (Full : Natural_Vector;
      Action : access procedure (Elements : Natural_Vector))
   is
      Work : Natural_Vector;

      procedure Walk (Position : Natural);
      procedure Walk (Position : Natural) is
      begin
         if Position > Full.Last_Index then
            Action (Work);
            return;
         end if;

         Walk (Position + 1);
         Work.Append (Full.Element (Position));
         Walk (Position + 1);
         Work.Delete_Last;
      end Walk;

   begin
      Walk (Full.First_Index);
   end With_Selections;

   -- Top level test --
   Test : Natural_Vector;
   Prime : Natural;

begin
   Prime := 1009;
   while Prime < 10000 loop
      All_Permutations (Prime, Test);
      if Is_Ascending_Number (Prime) then
         With_Selections (Test, Check_Valid'Access);
      end if;

      Prime := Prime_Sieve.Next_Prime (Prime);
   end loop;

end Pr049;
