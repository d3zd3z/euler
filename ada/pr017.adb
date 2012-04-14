----------------------------------------------------------------------
--  Problem 17
--
--  17 May 2002
--
--  If the numbers 1 to 5 are written out in words: one, two, three, four,
--  five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
--
--  If all the numbers from 1 to 1000 (one thousand) inclusive were written
--  out in words, how many letters would be used?
--
--  NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
--  forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
--  20 letters. The use of "and" when writing out numbers is in compliance
--  with British usage.
--
----------------------------------------------------------------------

--  with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Euler; use Euler;
with Ada.Strings.Unbounded;

procedure Pr017 is

   package U renames Ada.Strings.Unbounded;
   function ToU (Source : String) return U.Unbounded_String
     renames U.To_Unbounded_String;

   type Unbounded_String_Array is array (Positive range <>)
     of U.Unbounded_String;

   Ones : constant Unbounded_String_Array :=
     (1 => ToU ("one"),
      2 => ToU ("two"),
      3 => ToU ("three"),
      4 => ToU ("four"),
      5 => ToU ("five"),
      6 => ToU ("six"),
      7 => ToU ("seven"),
      8 => ToU ("eight"),
      9 => ToU ("nine"),
      10 => ToU ("ten"),
      11 => ToU ("eleven"),
      12 => ToU ("twelve"),
      13 => ToU ("thirteen"),
      14 => ToU ("fourteen"),
      15 => ToU ("fifteen"),
      16 => ToU ("sixteen"),
      17 => ToU ("seventeen"),
      18 => ToU ("eighteen"),
      19 => ToU ("nineteen"));

   Tens : constant Unbounded_String_Array :=
     (1 => ToU ("ten"),
      2 => ToU ("twenty"),
      3 => ToU ("thirty"),
      4 => ToU ("forty"),
      5 => ToU ("fifty"),
      6 => ToU ("sixty"),
      7 => ToU ("seventy"),
      8 => ToU ("eighty"),
      9 => ToU ("ninety"));

   function To_English_Number (Number : Positive) return String;
   function Count_Letters (Text : String) return Natural;

   function To_English_Number (Number : Positive) return String is
      Result : U.Unbounded_String := U.Null_Unbounded_String;
      Add_Space : Boolean := False;

      procedure Add (Text : U.Unbounded_String);
      procedure Add (Text : U.Unbounded_String) is
      begin
         if Add_Space then
            U.Append (Result, ' ');
         end if;

         U.Append (Result, Text);
         Add_Space := True;
      end Add;

      Work : Natural  := Number;

   begin
      if Work = 1000 then
         return "one thousand";
      end if;

      if Work >= 100 then
         Add (Ones (Work / 100));
         Add (ToU ("hundred"));
         Work := Work mod 100;

         if Work /= 0 then
            Add (ToU ("and"));
         end if;
      end if;

      if Work >= 20 then
         Add (Tens (Work / 10));
         Work := Work mod 10;

         if Work > 0 then
            U.Append (Result, '-');
            Add_Space := False;
         end if;
      end if;

      if Work >= 1 then
         Add (Ones (Work));
      end if;

      return U.To_String (Result);

   end To_English_Number;

   function Count_Letters (Text : String) return Natural is
      Count : Natural := 0;
   begin
      for Ch of Text loop
         if Is_Letter (Ch) then
            Count := Count + 1;
         end if;
      end loop;

      return Count;
   end Count_Letters;

   Sum : Natural := 0;

begin
   for I in 1 .. 1000 loop
      --  Put_Line (To_English_Number (I));
      Sum := Sum + Count_Letters (To_English_Number (I));
   end loop;

   Print_Result (Sum);
end Pr017;

