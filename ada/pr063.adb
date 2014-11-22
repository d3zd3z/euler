----------------------------------------------------------------------
--  Problem 63

--
--  13 February 2004
--
--
--  The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the
--  9-digit number, 134217728=8^9, is a ninth power.
--
--  How many n-digit positive integers exist which are also an nth power?
--
--  49
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr063 is

   function Solve return Natural;

   Max_Digits : constant := 35;

   Overflow : exception;

   type Digit is range 0 .. 9;
   type Digit_Array is array (Positive range <>) of Digit;

   type Number (Max_Base : Positive) is
      record
         Whole : Digit_Array (1 .. Max_Base) :=
            (1 => 1, others => 0);
      end record;

   procedure Multiply (N : in out Number; By : Natural);
   --  Multiply the large Number by the factor 'By'.

   function Power (Base : Natural; Exponent : Natural) return Number;

   function Digit_Count (N : in Number) return Natural;

   --  procedure Put_Number (N : in Number);

   -----------------
   -- Digit_Count --
   -----------------

   function Digit_Count (N : in Number) return Natural is
      Count : Natural := N.Max_Base;
   begin
      for I in reverse N.Whole'Range loop
         if N.Whole (I) /= 0 then
            return Count;
         end if;

         Count := Count - 1;
      end loop;

      raise Overflow;
   end Digit_Count;

   --------------
   -- Multiply --
   --------------

   procedure Multiply (N : in out Number; By : Natural) is
      Carry : Natural := 0;
      Work : Natural;
   begin
      for I in N.Whole'Range loop
         Work := Natural (N.Whole (I)) * By + Carry;
         N.Whole (I) := Digit (Work mod 10);
         Carry := Work / 10;
      end loop;

      if Carry /= 0 then
         raise Overflow;
      end if;
   end Multiply;

   -----------
   -- Power --
   -----------

   function Power (Base : Natural; Exponent : Natural) return Number is
      Result : Number (Max_Digits);
   begin
      for I in 1 .. Exponent loop
         Multiply (Result, Base);
      end loop;

      return Result;
   end Power;

   ----------------
   -- Put_Number --
   ----------------

   --  procedure Put_Number (N : in Number) is
   --     Inside : Boolean := False;
   --  begin
   --     for D of reverse N.Whole loop
   --        if not Inside and then D /= 0 then
   --           Inside := True;
   --        end if;

   --        if Inside then
   --           declare
   --              Text : constant String := Digit'Image (D);
   --           begin
   --              Put (Text (Text'First + 1 .. Text'Last));
   --           end;
   --        end if;
   --     end loop;
   --  end Put_Number;

   --  25 digits is sufficient,  Not clear why, but it seems to be.
   function Solve return Natural is
      Base : Natural;
      Count : Natural;
      Total : Natural := 0;
      Work : Number (Max_Digits);
   begin
      for Exponent in 1 .. 25 loop
         Base := 1;

         loop
            Work := Power (Base, Exponent);

            --  pragma Debug (Put (Base'Img & " **" & Exponent'Img & " = "));
            --  pragma Debug (Put_Number (Work));
            --  pragma Debug (New_Line);

            Count := Digit_Count (Work);

            exit when Count > Exponent;
            if Count = Exponent then
               Total := Total + 1;
            end if;

            Base := Base + 1;
         end loop;
      end loop;

      return Total;
   end Solve;

begin
   Put_Line (Solve'Img);
end Pr063;
