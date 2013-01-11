unit sieve;

(* A simple, self-scaling prime sieve *)

{$mode objfpc}

interface

type

   factor = record
      prime, power : longint;
   end;
   Tfactors = array of factor;
   Tdivisors = array of longint;

   TSieve = class
   private
      primes : packed array of boolean;
      procedure fill;
      procedure newLength(need : longint);
   public
      constructor create;
      function isPrime(n : longint) : boolean;
      function nextPrime(n : longint) : longint;
      function factorize(n : longint) : Tfactors;
      function divisors(n : longint) : Tdivisors;
      function divisorCount(n : longint) : longint;
   end;

implementation

constructor TSieve.create;
begin
   { I don't know if this reliably initializes them. }
   SetLength(primes, 1024);
   fill
end;

procedure TSieve.newLength(need : longint);
var
   cur : longint;
begin
   cur := length(primes);
   while need >= cur do
      cur := cur * 8;
   setlength(primes, cur);
   fill
end;

procedure TSieve.fill;
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

function TSieve.isPrime(n : longint) : boolean;
begin
   if n >= length(primes) then
      newLength(n);

   isPrime := primes[n]
end;

function TSieve.nextPrime(n : longint) : longint;
begin
   if n = 2 then
      nextPrime := 3
   else begin
      nextPrime := n + 2;
      while not isPrime(nextPrime) do
	 nextPrime := nextPrime + 2
   end;
end;

function TSieve.factorize(n : longint) : Tfactors;
var
   prime : longint = 2;
   count : longint = 0;

   procedure push;
   var
      pos : longint;
   begin
      pos := length(result);
      setlength(result, pos+1);
      result[pos].prime := prime;
      result[pos].power := count;
      count := 0;
   end;
begin
   setlength(result, 0);

   while n > 1 do
   begin
      if (n mod prime) = 0 then begin
	 n := n div prime;
	 count := count + 1;
      end else begin
	 if count > 0 then
	    push;

	 if n > 1 then
	    prime := nextPrime(prime);
      end;
   end;

   if count > 0 then
      push;
end;

procedure spread(factors : Tfactors;
		 base : longint;
		 var answer : Tdivisors);
var
   len : longint;
   i : longint;
   rest : Tdivisors;
   elt, power : longint;

   procedure push(item : longint);
   var
      pos : longint;
   begin
      pos := length(answer);
      setlength(answer, pos+1);
      answer[pos] := item;
   end;
begin
   len := length(factors);

   if base >= len then
      push(1)
   else begin
      setlength(rest, 0);
      spread(factors, base+1, rest);
      power := 1;
      for i := 0 to factors[base].power do begin
         for elt in rest do
            push(elt * power);
         if i < factors[base].power then
            power := power * factors[base].prime;
      end;
   end;
end;

function TSieve.divisors(n : longint) : Tdivisors;
var
   factors : Tfactors;
begin
   factors := factorize(n);
   setlength(result, 0);
   spread(factors, 0, result);
   // TODO: Need to sort here.
end;

function TSieve.divisorCount(n : longint) : longint;
var
   factors : Tfactors;
   f : factor;
begin
   { TODO: This is probably not right. }
   factors := factorize(n);
   result := 1;
   for f in factors do begin
      result := result * (f.power + 1);
   end;
end;

end.
