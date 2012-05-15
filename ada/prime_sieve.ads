----------------------------------------------------------------------
--  Prime number sieve
----------------------------------------------------------------------

with Ada.Containers.Vectors;
with Ada.Finalization;

package Prime_Sieve is

   type T (Limit : Natural) is tagged limited private;

   function Is_Prime (Object : T; Index : Natural) return Boolean;
   function Is_Prime (Index : Natural) return Boolean;

   function Next_Prime (Object : T; Index : Natural) return Natural;
   function Next_Prime (Index : Natural) return Natural;

   function Sieve (Limit : Natural) return access T;
   --  Return a shared sieve capable of handling at least up to Limit.

   type Factor is
      record
         Prime : Natural;
         Power : Natural;
      end record;

   package Factor_Vectors is new Ada.Containers.Vectors
      (Index_Type   => Natural,
       Element_Type => Factor);

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

   type Bit_Array is array (Positive range <>) of Boolean;
   pragma Pack (Bit_Array);

   type T (Limit : Natural) is new Ada.Finalization.Limited_Controlled with
      record
         Primes : Bit_Array (1 .. Limit) := (others => True);
      end record;

   procedure Initialize (Object : in out T);

   pragma Inline (Is_Prime);

end Prime_Sieve;
