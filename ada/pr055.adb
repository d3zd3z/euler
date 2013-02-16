----------------------------------------------------------------------
--  Problem 55
--
--  24 October 2003
--
--
--  If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.
--
--  Not all numbers produce palindromes so quickly. For example,
--
--  349 + 943 = 1292,
--  1292 + 2921 = 4213
--  4213 + 3124 = 7337
--
--  That is, 349 took three iterations to arrive at a palindrome.
--
--  Although no one has proved it yet, it is thought that some numbers,
--  like 196, never produce a palindrome. A number that never forms a
--  palindrome through the reverse and add process is called a Lychrel
--  number. Due to the theoretical nature of these numbers, and for the
--  purpose of this problem, we shall assume that a number is Lychrel
--  until proven otherwise. In addition you are given that for every
--  number below ten-thousand, it will either (i) become a palindrome in
--  less than fifty iterations, or, (ii) no one, with all the computing
--  power that exists, has managed so far to map it to a palindrome. In
--  fact, 10677 is the first number to be shown to require over fifty
--  iterations before producing a palindrome:
--  4668731596684224866951378664 (53 iterations, 28-digits).
--
--  Surprisingly, there are palindromic numbers that are themselves
--  Lychrel numbers; the first example is 4994.
--
--  How many Lychrel numbers are there below ten-thousand?
--
--  NOTE: Wording was modified slightly on 24 April 2007 to emphasise the
--  theoretical nature of Lychrel numbers.
--
--  249
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr055 is

   --  Represent the numbers in base-10.
   Max_Digits : constant := 29;

   subtype One_Digit is Natural range 0 .. 9;
   type Digit_Array is array (Positive range <>) of One_Digit;

   type Number_Type is
      record
         First : Natural;
         Data  : Digit_Array (1 .. Max_Digits);
      end record;

   procedure Natural_To_Number (Input : Natural;
                                Number : out Number_Type);

   procedure Add (Base  : in out Number_Type;
                  Other :        Number_Type);
   --  Add the 'Other' number to 'Base', storing the result in 'Base'.

   procedure Reverse_Number (Input  :     Number_Type;
                             Output : out Number_Type);
   --  Put into 'Output' the reversed version of the number in
   --  'Input'.

   function Is_Palindrome (Input : Number_Type) return Boolean;

   --  procedure Put (Number : Number_Type);

   procedure Add (Base  : in out Number_Type;
                  Other :        Number_Type)
   is
      Temp : Natural;
      Carry : Natural := 0;
   begin
      if Base.First /= Other.First then
         --  This problem doesn't need different length numbers.
         raise Program_Error;
      end if;

      for I in reverse Base.First .. Base.Data'Last loop
         Temp := (Natural (Base.Data (I)) +
                    Natural (Other.Data (I)) + Carry);
         Base.Data (I) := Temp mod 10;
         Carry := Temp / 10;
      end loop;

      if Carry > 0 then
         Base.First := Base.First - 1;
         Base.Data (Base.First) := Carry;
      end if;
   end Add;

   function Is_Palindrome (Input : Number_Type) return Boolean is
      A : Natural := Input.First;
      B : Natural := Input.Data'Last;
   begin
      while A < B loop
         if Input.Data (A) /= Input.Data (B) then
            return False;
         end if;
         A := A + 1;
         B := B - 1;
      end loop;

      return True;
   end Is_Palindrome;

   procedure Natural_To_Number (Input : Natural;
                                Number : out Number_Type)
   is
      First : Natural := Number.Data'Last + 1;
      Temp : Natural := Input;
   begin
      while Temp /= 0 loop
         First := First - 1;
         Number.Data (First) := Temp mod 10;
         Temp := Temp / 10;
      end loop;

      Number.First := First;
   end Natural_To_Number;

   --  procedure Put (Number : Number_Type) is
   --  begin
   --     for I in Number.First .. Number.Data'Last loop
   --        Put (Character'Val (Number.Data (I) + Character'Pos ('0')));
   --     end loop;
   --  end Put;

   procedure Reverse_Number (Input  :     Number_Type;
                             Output : out Number_Type)
   is
      A : Natural := Input.First;
      B : Natural := Output.Data'Last;
   begin
      Output.First := Input.First;

      while A <= Input.Data'Last loop
         Output.Data (B) := Input.Data (A);
         A := A + 1;
         B := B - 1;
      end loop;
   end Reverse_Number;

   function Is_Lychrel (Number : Natural) return Boolean;

   function Is_Lychrel (Number : Natural) return Boolean is
      Work, Temp : Number_Type;
   begin
      Natural_To_Number (Number, Work);

      for I in 1 .. 50 loop
         Reverse_Number (Work, Temp);
         Add (Work, Temp);
         if Is_Palindrome (Work) then
            return False;
         end if;
      end loop;

      return True;
   end Is_Lychrel;

   Count : Natural := 0;

begin
   for I in 1 .. 9999 loop
      if Is_Lychrel (I) then
         Count := Count + 1;
      end if;
   end loop;

   Put_Line (Natural'Image (Count));
end Pr055;
