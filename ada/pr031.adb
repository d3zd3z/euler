----------------------------------------------------------------------
--  Problem 31

--
--  22 November 2002
--
--  In England the currency is made up of pound, -L-, and pence, p, and
--  there are eight coins in general circulation:
--
--      1p, 2p, 5p, 10p, 20p, 50p, -L-1 (100p) and -L-2 (200p).
--
--  It is possible to make -L-2 in the following way:
--
--      1x-L-1 + 1x50p + 2x20p + 1x5p + 1x2p + 3x1p
--
--  How many different ways can -L-2 be made using any number of coins?
--
----------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
--  with Euler; use Euler;

procedure Pr031 is

   type Coin_Array is array (Positive range <>) of Natural;

   Coins : constant Coin_Array := (200, 100, 50, 20, 10, 5, 2, 1);

   function Find_Ways (Remaining : Natural; Coins_Left : Coin_Array)
      return Natural;
   --  Compute the number of ways of using the denominations of coins in
   --  Coins_Left to make up Remaining.

   function Find_Ways (Remaining : Natural; Coins_Left : Coin_Array)
      return Natural
   is
   begin
      if Coins_Left'Length = 0 then
         if Remaining = 0 then
            return 1;
         else
            return 0;
         end if;
      end if;

      declare
         Coin : constant Natural := Coins_Left (Coins_Left'First);
         Rest : Coin_Array renames
            Coins_Left (Coins_Left'First + 1 .. Coins_Left'Last);
         Sum : Natural := 0;
         Left : Integer := Remaining;
      begin
         while Left >= 0 loop
            Sum := Sum + Find_Ways (Left, Rest);
            Left := Left - Coin;
         end loop;

         return Sum;
      end;
   end Find_Ways;

begin
   Put_Line (Natural'Image (Find_Ways (200, Coins)));
end Pr031;

