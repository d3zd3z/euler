--  Prime number sieve

with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Prime_Sieve is

   procedure Initialize (Object : in out T) is
      Prime : Natural := 2;
      Next : Natural;
   begin
      --  Object.Primes := (others => True);
      --  The above is simple, but causes a temporary to be built on the stack.
      --  Moving the initializer into the record itself seems to fix it.

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

   function Next_Prime (Object : T; Index : Natural) return Natural is
      Next : Natural;
   begin
      if Index = 2 then
         return 3;
      end if;

      Next := Index + 2;
      while not Is_Prime (Object, Next) loop
         Next := Next + 2;
      end loop;

      return Next;
   end Next_Prime;

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
            Size := Size * 2;
         end loop;

         Ada.Text_IO.Put_Line ("sieve: allocate " & Size'Img);
         Current := new T (Size);
      end if;

      return Current;
   end Sieve;

end Prime_Sieve;
