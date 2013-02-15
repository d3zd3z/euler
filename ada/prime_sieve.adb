--  Prime number sieve

with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Ada.Finalization;

package body Prime_Sieve is

   package Sieve_Object is
      type Bit_Array is array (Positive range <>) of Boolean;
      pragma Pack (Bit_Array);

      type T (Limit : Natural) is new Ada.Finalization.Limited_Controlled with
         record
            Primes : Bit_Array (1 .. Limit) := (others => True);
         end record;

      function Is_Prime (Object : T; Index : Natural) return Boolean;
      function Sieve (Limit : Natural) return access T;

      procedure Initialize (Object : in out T);
   end Sieve_Object;

   package body Sieve_Object is

      procedure Initialize (Object : in out T) is
         Prime : Natural := 2;
         Next : Natural;
      begin
         --  Object.Primes := (others => True);
         --  The above is simple, but causes a temporary to be built
         --  on the stack.  Moving the initializer into the record
         --  itself seems to fix it.

         Object.Primes (1) := False;

         while Prime <= Object.Limit loop
            if not Object.Primes (Prime) then
               Prime := Prime + 2;
            else
               Next := Prime + Prime;
               while Next < Object.Limit loop
                  Object.Primes (Next) := False;
                  Next := Next + Prime;
               end loop;

               if Prime = 2 then
                  Prime := 3;
               else
                  Prime := Prime + 2;
               end if;
            end if;
         end loop;
      end Initialize;

      function Is_Prime (Object : T; Index : Natural) return Boolean is
      begin
         return Object.Primes (Index);
      end Is_Prime;

      --  The shared sieve.
      type T_Access is access T;
      procedure Free is new Ada.Unchecked_Deallocation (T, T_Access);

      Current : T_Access := new T (1024);

      function Sieve (Limit : Natural) return access T is
         Size : Natural;
      begin
         if Limit > Current.Limit then
            Size := Current.Limit;
            Free (Current);

            while Size <= Limit loop
               Size := Size * 8;
            end loop;

            --  Ada.Text_IO.Put_Line ("sieve: allocate " & Size'Img);
            Current := new T (Size);
         end if;

         return Current;
      end Sieve;

   end Sieve_Object;

   use Sieve_Object;

   function Is_Prime (Index : Natural) return Boolean is
      Object : access T renames Sieve (Index);
   begin
      return Is_Prime (Object.all, Index);
   end Is_Prime;

   function Next_Prime (Index : Natural) return Natural is
      Next : Natural;
   begin
      if Index = 2 then
         return 3;
      end if;

      Next := Index + 2;
      while not Is_Prime (Next) loop
         Next := Next + 2;
      end loop;

      return Next;
   end Next_Prime;

   function Factorize (Number : Natural) return Factor_Vectors.Vector
   is
      Result : Factor_Vectors.Vector;
      P : Natural := 2;
      Count : Natural := 0;
      Temp : Natural := Number;
   begin
      while Temp > 1 loop
         if Temp mod P = 0 then
            Temp := Temp / P;
            Count := Count + 1;
         else
            if Count > 0 then
               Result.Append (Factor'(Prime => P, Power => Count));
               Count := 0;
            end if;

            P := Next_Prime (P);
         end if;
      end loop;

      if Count > 0 then
         Result.Append (Factor'(Prime => P, Power => Count));
      end if;

      return Result;
   end Factorize;

   function Spread (Factors : Factor_Vectors.Vector)
      return Natural_Vectors.Vector;

   function Divisors (Number : Natural) return Natural_Vectors.Vector
   is
   begin
      return Spread (Factorize (Number));
   end Divisors;

   --  Ugh, the vectors seem to have copying value semantics, which I guess
   --  fits with everything else in the cursed language, but is still
   --  annoying.
   function Spread (Factors : Factor_Vectors.Vector)
      return Natural_Vectors.Vector
   is
      use type Ada.Containers.Count_Type;
      Result : Natural_Vectors.Vector;
      X : Factor;
      Temp : Factor_Vectors.Vector := Factors;
      Rest : Natural_Vectors.Vector;
      Power : Natural;
   begin
      if Factors.Length = 0 then
         Result.Append (1);
         return Result;
      end if;

      X := Temp.First_Element;
      Temp.Delete_First;
      Rest := Spread (Temp);

      Power := 1;
      for I in 0 .. X.Power loop
         declare
            Children : Natural_Vectors.Vector;
         begin
            Children.Reserve_Capacity (Rest.Length);
            for B of Rest loop
               Children.Append (B * Power);
            end loop;

            Result.Append (Children);

            --  Don't multiply after the last iteration, otherwise we risk
            --  unnecessary overflow.
            if I < X.Power then
               Power := Power * X.Prime;
            end if;
         end;
      end loop;

      return Result;
   end Spread;

   function Proper_Divisor_Sum (Number : Natural) return Natural is
      Divs : constant Natural_Vectors.Vector := Divisors (Number);
      Sum : Natural := 0;
   begin
      for N of Divs loop
         if N < Number then
            Sum := Sum + N;
         end if;
      end loop;
      return Sum;
   end Proper_Divisor_Sum;

   procedure Dump_Factors (Factors : Factor_Vectors.Vector) is
      use Ada.Text_IO;
   begin
      Put_Line ("Factors:");
      for Fact of Factors loop
         Put (Natural'Image (Fact.Prime));
         Put ("**");
         Put_Line (Natural'Image (Fact.Power));
      end loop;
   end Dump_Factors;

end Prime_Sieve;
