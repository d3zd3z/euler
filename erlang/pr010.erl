% Problem 10
%
% 08 February 2002
%
%
% The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
%
% Find the sum of all the primes below two million.
%
% 142913828922

-module(pr010).
-export([solve/0]).

solve() ->
	Sieve = sieve:start(),
	Primes = sieve:primes_to(Sieve, 2000000),
	P2 = [ P || P <- Primes, P < 2000000 ],
	sieve:stop(Sieve),
	lists:sum(P2). 
