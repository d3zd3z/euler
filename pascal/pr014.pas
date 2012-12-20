(*
 * Problem 14
 *
 * 05 April 2002
 *
 * The following iterative sequence is defined for the set of positive
 * integers:
 *
 * n → n/2 (n is even)
 * n → 3n + 1 (n is odd)
 *
 * Using the rule above and starting with 13, we generate the following
 * sequence:
 *
 * 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
 *
 * It can be seen that this sequence (starting at 13 and finishing at 1)
 * contains 10 terms. Although it has not been proved yet (Collatz Problem),
 * it is thought that all starting numbers finish at 1.
 *
 * Which starting number, under one million, produces the longest chain?
 *
 * NOTE: Once the chain starts the terms are allowed to go above one million.
 *
 * 837799
 *)

{ Important, the intermediate results are larger than a 32-bit signed. }

{ Two steps here.  Implement a simple solution.  Make general with an
  interface.  Use that to cache. }

{$mode objfpc}
program pr014;

uses sysutils;

type
  baseint = int64;

type
  ILengther = interface
    function chainLen(n : baseint) : longint;
  end;

  TSimpleLengther = class(TInterfacedObject, ILengther)
    function chainLen(n : baseint) : longint;
  end;

  function TSimpleLengther.chainLen(n : baseint) : longint;
  begin
    if n = 1 then
      chainLen := 1
    else if (n and 1) = 0 then
      chainLen := 1 + chainLen(n >> 1)
    else
      chainLen := 1 + chainLen(3 * n + 1)
  end;

type
  TCachedLengther = class(TInterfacedObject, ILengther)
  private
    cache : array of longint;
    function chain2(n : baseint) : longint;
  public
    constructor create(size : baseint);
    function chainLen(n : baseint) : longint;
  end;

  constructor TCachedLengther.create(size : baseint);
  var
    i: longint;
  begin
    inherited create;
    setlength(cache, size);
    for i := 0 to size-1 do
      cache[i] := -1;
  end;

  function TCachedLengther.chainLen(n : baseint) : longint;
  begin
    if n < 0 then
      raise exception.create('Negative chain scan');
    if n < length(cache) then
      begin
	chainLen := cache[n];
	if chainLen < 0 then
	  begin
	    chainLen := chain2(n);
	    cache[n] := chainLen
	  end;
      end
    else
      chainLen := chain2(n)
  end;

  function TCachedLengther.chain2(n : baseint) : longint;
  begin
    if n = 1 then
      chain2 := 1
    else if (n and 1) = 0 then
      chain2 := 1 + chainLen(n >> 1)
    else
      chain2 := 1 + chainLen(3 * n + 1)
  end;

  function compute(lengther: ILengther) : longint;
  var
    max : baseint = 0;
    i : longint;
    len : baseint;
  begin
    compute := 0;
    for i := 1 to 999999 do
      begin
	len := lengther.chainLen(i);
	if len > max then
	  begin
	    max := len;
	    compute := i;
	  end;
      end;
  end;

var
  lengther: ILengther;
begin
  { lengther := TSimpleLengther.create; }
  lengther := TCachedLengther.create(10000);
  writeln(compute(lengther))
end.
