--  Mostly derived from the Wikipedia article on Miller-Rabin.

with Interfaces; use Interfaces;
with Ada.Numerics.Discrete_Random;

package body Miller_Rabin is

   subtype Core_Type is Unsigned_64;
   --  These computations need bit manipulation, which requires modular
   --  numbers.

   package Random is new Ada.Numerics.Discrete_Random (Unsigned_64);

   Gen : Random.Generator;

   function Check (Number : Core_Type; K : Natural) return Boolean;
   --  The primality test itself.  Doesn't work for small values, though.

   procedure Compute_SD (Number : Core_Type; S, D : out Core_Type);
   --  For a given Number, compute values S, and D, such that 2**S * D is
   --  Number - 1.

   function Round (N, S, D : Core_Type) return Boolean;
   --  Perform a single round of the M-R algorithm.

   function Exp_Mod (Base, Power, Modulus : Core_Type) return Core_Type;
   --  Compute (Base**Power) mod Modulus, more efficiently.

   -----------
   -- Check --
   -----------

   function Check (Number : Core_Type; K : Natural) return Boolean is
      S, D : Core_Type;
   begin
      Compute_SD (Number, S, D);

      for I in 1 .. K loop
         if not Round (Number, S, D) then
            return False;
         end if;
      end loop;

      return True;
   end Check;

   ----------------
   -- Compute_SD --
   ----------------

   procedure Compute_SD (Number : Core_Type; S, D : out Core_Type) is
   begin
      S := 0;
      D := Number - 1;
      while (D and 1) = 0 loop
         S := S + 1;
         D := Shift_Right (D, 1);
      end loop;
   end Compute_SD;

   function Exp_Mod (Base, Power, Modulus : Core_Type) return Core_Type is
      P : Core_Type := Power;
      B : Core_Type := Base;
      Result : Core_Type := 1;
   begin
      while P > 0 loop
         if (P and 1) /= 0 then
            Result := (Result * B) mod Modulus;
         end if;

         B := (B * B) mod Modulus;
         P := Shift_Right (P, 1);
      end loop;

      return Result;
   end Exp_Mod;

   --------------
   -- Is_Prime --
   --------------

   function Is_Prime (Number : Natural; K : Natural := 20) return Boolean is
   begin
      if Number = 1 or else Number = 0 then
         return False;
      end if;

      if Number = 2 or else Number = 3 or else Number = 5 or else
         Number = 7
      then
         return True;
      end if;

      if (Number mod 2) = 0 or else
         (Number mod 3) = 0 or else
         (Number mod 5) = 0 or else
         (Number mod 7) = 0
      then
         return False;
      end if;

      return Check (Core_Type (Number), K);
   end Is_Prime;

   -----------
   -- Round --
   -----------

   function Round (N, S, D : Core_Type) return Boolean is
      --  A should be in the range [2 .. N-2].  This isn't completely
      --  uniformly distributed, because of the upper range, but is sufficient
      --  for the primality test.
      A : constant Core_Type := Random.Random (Gen) mod (N - 3) + 2;

      X : Core_Type := Exp_Mod (A, D, N);
   begin
      if X = 1 or else X = N - 1 then
         return True;
      end if;

      for R in 1 .. S - 1 loop
         X := (X * X) mod N;
         if X = 1 then
            return False;
         end if;

         if X = N - 1 then
            return True;
         end if;
      end loop;

      return False;
   end Round;

end Miller_Rabin;
