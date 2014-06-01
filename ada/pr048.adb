----------------------------------------------------------------------
--  Problem 48

--
--  18 July 2003
--
--
--  The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
--
--  Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^
--  1000.
--
--  9110846700
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr048 is

   --  The intermediate result requires about 44 bits.
   type Work_Value is range 0 .. 2**63 - 1;

   Modulus : constant := 10_000_000_000;

   function Expt (Base : Work_Value; Power : Natural) return Work_Value;

   function Expt (Base : Work_Value; Power : Natural) return Work_Value is
      Result : Work_Value := 1;
   begin
      for I in 1 .. Power loop
         Result := (Result * Base) mod Modulus;
      end loop;

      return Result;
   end Expt;

   Sum : Work_Value := 0;

begin
   for I in 1 .. 1000 loop
      Sum := (Sum + Expt (Work_Value (I), I)) mod Modulus;
   end loop;
   Put_Line (Work_Value'Image (Sum));
end Pr048;
