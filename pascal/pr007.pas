program pr007;

(*
 * Problem 7
 *
 * 28 December 2001
 *
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
 * that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 *
 * 104743
**)

{$mode objfpc}

uses sysutils;

type
  sieve = class
  private
    primes : array of boolean;
    procedure fill;
    procedure newLength(need : longint);
  public
    constructor create;
    function isPrime(n : longint) : boolean;
    function nextPrime(n : longint) : longint;
  end;

  constructor sieve.create;
  begin
    { I don't know if this reliably initializes them. }
    SetLength(primes, 1024);
    fill
  end;

  procedure sieve.newLength(need : longint);
  var
    cur : longint;
  begin
    cur := length(primes);
    while need >= cur do
      cur := cur * 8;
    setlength(primes, cur);
    fill
  end;

  procedure sieve.fill;
  var
    i : longint;
    pos, n : longint;
    limit : longint;
  begin
    limit := length(primes);
    for i := 0 to limit-1 do
      primes[i] := true;

    primes[0] := false;
    primes[1] := false;
    pos := 2;
    while pos < limit do
      begin
	if primes[pos] then
	  begin
	    n := pos + pos;
	    while n < limit do
	      begin
		primes[n] := false;
		n := n + pos
	      end;
	      if pos = 2 then
		pos := pos + 1
	      else
		pos := pos + 2
	  end
	else
	  pos := pos + 2
      end;
  end;

  function sieve.isPrime(n : longint) : boolean;
  begin
    if n >= length(primes) then
      newLength(n);

    isPrime := primes[n]
  end;

  function sieve.nextPrime(n : longint) : longint;
  begin
    if n = 2 then
      nextPrime := 3
    else begin
      nextPrime := n + 2;
      while not isPrime(nextPrime) do
	nextPrime := nextPrime + 2
    end;
  end;

var
  blort : sieve;
  p, count : longint;

begin
  blort := sieve.create;
  count := 1;
  p := 2;
  while count < 10001 do
    begin
      p := blort.nextPrime(p);
      count := count + 1;
    end;
  writeln(p)
end.
