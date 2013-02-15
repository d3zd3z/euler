----------------------------------------------------------------------
--  Prime number sieve
----------------------------------------------------------------------

with Ada.Containers.Vectors;

package Prime_Sieve is

   function Is_Prime (Index : Natural) return Boolean;

   function Next_Prime (Index : Natural) return Natural;

   type Factor is
      record
         Prime : Natural;
         Power : Natural;
      end record;

   package Factor_Vectors is new Ada.Containers.Vectors
      (Index_Type   => Natural,
       Element_Type => Factor);

   procedure Dump_Factors (Factors : Factor_Vectors.Vector);
   --  Debugging utility to show a set of factors.

   package Natural_Vectors is new Ada.Containers.Vectors
      (Index_Type   => Natural,
       Element_Type => Natural);

   function Factorize (Number : Natural) return Factor_Vectors.Vector;
   --  Return the prime factors of the Number, with their powers.

   function Divisors (Number : Natural) return Natural_Vectors.Vector;
   --  Return a list of the divisors of the number.

   function Proper_Divisor_Sum (Number : Natural) return Natural;
   --  Return the sum of the proper divisors of the given number.

private

   pragma Inline (Is_Prime);

end Prime_Sieve;
