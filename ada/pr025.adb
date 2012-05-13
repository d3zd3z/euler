----------------------------------------------------------------------
--  Problem 25

--
--  30 August 2002
--
--  The Fibonacci sequence is defined by the recurrence relation:
--
--      F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
--
--  Hence the first 12 terms will be:
--
--      F[1] = 1
--      F[2] = 1
--      F[3] = 2
--      F[4] = 3
--      F[5] = 5
--      F[6] = 8
--      F[7] = 13
--      F[8] = 21
--      F[9] = 34
--      F[10] = 55
--      F[11] = 89
--      F[12] = 144
--
--  The 12th term, F[12], is the first term to contain three digits.
--
--  What is the first term in the Fibonacci sequence to contain 1000 digits?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr025 is

   Limit : constant := 999;

   type Number_Type is array (1 .. Limit) of Natural;

   A : Number_Type := (1 => 1, others => 0);
   B : Number_Type := (1 => 1, others => 0);

   Overflow : exception;

   procedure Add (Dest : in out Number_Type; Other : Number_Type);
   --  Add 'Other' to 'Dest', updating Dest.  Raises Overflow if the result
   --  doesn't fit.

   procedure Add (Dest : in out Number_Type; Other : Number_Type) is
      Carry : Natural := 0;
      Temp : Natural;
   begin
      for Place in Dest'Range loop
         Temp := Dest (Place) + Other (Place) + Carry;
         Dest (Place) := Temp mod 10;
         Carry := Temp / 10;
      end loop;
      if Carry /= 0 then
         raise Overflow;
      end if;
   end Add;

   procedure Show (Value : Number_Type);
   procedure Show (Value : Number_Type) is
   begin
      for D of reverse Value loop
         Put (Natural'Image (D));
      end loop;
      New_Line;
   end Show;

   Count : Natural := 3;

begin
   loop
      Add (A, B);
      Count := Count + 1;
      Add (B, A);
      Count := Count + 1;
   end loop;

exception
   when Overflow =>
      Put_Line (Natural'Image (Count));
      if False then
         Show (A);
         Show (B);
      end if;
end Pr025;

