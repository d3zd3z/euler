(*
 * Problem 20
 *
 * 21 June 2002
 *
 * n! means n x (n − 1) x ... x 3 x 2 x 1
 *
 * For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
 * and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
 * 27.
 *
 * Find the sum of the digits in the number 100!
 *
 * 648
 *)

{$mode objfpc}
program pr020;

uses sysutils;

const
   base = 10000;

var
   { Represent the number in base 10000. }
   accumulator : array[1..40] of longint;

procedure init;
var
   i : integer;
begin
   accumulator[1] := 1;
   for i := 2 to high(accumulator) do
      accumulator[i] := 0;
end;

procedure multiply(by : longint);
var
   temp, i : longint;
   carry : longint = 0;
begin
   for i := low(accumulator) to high(accumulator) do
   begin
      temp := accumulator[i] * by + carry;
      accumulator[i] := temp mod base;
      carry := temp div base;
   end;
   if carry <> 0 then
      raise exception.create('Accumulator overflow');
end;

var
   sum : longint = 0;
   temp, i : longint;

begin
   init;

   for i := 2 to 100 do
      multiply(i);

   for i in accumulator do begin
      temp := i;
      while temp <> 0 do begin
	 sum := sum + temp mod 10;
	 temp := temp div 10;
      end;
   end;

   writeln(sum);
end.
