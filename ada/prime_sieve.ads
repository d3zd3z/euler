----------------------------------------------------------------------
--  Prime number sieve
----------------------------------------------------------------------

with Ada.Finalization;

package Prime_Sieve is

   type T (Limit : Natural) is tagged limited private;

   function Is_Prime (Object : T; Index : Natural) return Boolean;

   function Next_Prime (Object : T; Index : Natural) return Natural;

   function Sieve (Limit : Natural) return access T;
   --  Return a shared sieve capable of handling at least up to Limit.

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
