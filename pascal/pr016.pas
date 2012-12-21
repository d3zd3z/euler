(*
 * Problem 16
 *
 * 03 May 2002
 *
 * 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
 *
 * What is the sum of the digits of the number 2^1000?
 *
 * 1366
 *)

{ There are two obvious approaches to this.  We can do the arithmetic
  ourselves, using an array, or we can use the gmp binding in
  FreePascal.  Might as well try both. }

{$mode objfpc}
program pr016;

uses sysutils, gmp;

  function brute : longint;
  var
    values : array[1 .. 700] of longint;

    procedure init;
    var
      i : longint;
    begin
      values[1] := 1;
      for i := 2 to high(values) do
	values[i] := 0;
    end;

    procedure double;
    var
      carry : longint = 0;
      temp, i : longint;
    begin
      for i := low(values) to high(values) do begin
	temp := values[i] * 2 + carry;
	values[i] := temp mod 10;
	carry := temp div 10;
      end;

      if carry <> 0 then
	raise exception.create('Numeric overflow');
    end;

  var
    i : longint;

  begin
    init;
    for i := 1 to 1000 do
      double;

    brute := 0;
    for i := low(values) to high(values) do
      brute := brute + values[i];
  end;

  function withGmp : longint;
  var
    value, tmp : mpz_t;
  begin
    withGmp := 0;
    mpz_init_set_ui(value, 2);
    mpz_init(tmp);
    mpz_pow_ui(value, value, 1000);
    while mpz_cmp_si(value, 0) > 0 do begin
      mpz_tdiv_qr_ui(value, tmp, value, 10);
      withGmp := withGmp + mpz_get_ui(tmp);
    end;
  end;

begin
  writeln(brute);
  writeln(withGmp);
end.
