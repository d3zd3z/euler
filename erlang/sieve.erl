% A prime sieve, and some utilities.

-module(sieve).
-export([primes/1,
	 n_primes/1]).

% Taken from
% http://stackoverflow.com/questions/146622/sieve-of-eratosthenes-in-erlang
% but modified to use the integer square root.
primes(N) ->
	primes(2, isqrt(N), [], lists:seq(3, N, 2)).

primes(Prime, Max, Primes, Integers) when Prime > Max ->
	lists:reverse([Prime|Primes], Integers);
primes(Prime, Max, Primes, Integers) ->
	[NewPrime|NewIntegers] = [ X || X <- Integers, X rem Prime =/= 0 ],
	primes(NewPrime, Max, [Prime|Primes], NewIntegers).

% Integer square root.
isqrt(Num) ->
	isqrt(0, find_bit(Num, 1), Num).

isqrt(Result, Bit, _Num) when Bit =:= 0 -> Result;
isqrt(Result, Bit, Num) ->
	Rb = Result + Bit,
	RlSr1 = Result bsr 1,
	BitLsr2 = Bit bsr 2,
	if
		Num >= Rb ->
			isqrt(RlSr1 + Bit, BitLsr2, Num - Rb);
		true ->
			isqrt(RlSr1, BitLsr2, Num)
	end.

% Find the higest even bit that is larger than the value.
find_bit(Num, Bit) when Bit =< Num ->
	find_bit(Num, Bit bsl 2);
find_bit(_Num, Bit) -> Bit.

% Build up at least 'N' primes.
% TODO: We could actually do a lot better for an initial guess than
% just N.
n_primes(N) -> n_primes(N, N, primes(N)).

n_primes(N, _T, Primes) when length(Primes) >= N -> Primes;
n_primes(N, T, _Primes) ->
	T2 = T * 2,
	n_primes(N, T2, primes(T2)).

% This is absolutely terrible, but interesting.
% Build a prime sieve with the given limit.  We do this by collecting
% all of the composites.
%% build(Limit) -> build(2, Limit, ordsets:new(), []).
%% 
%% build(P, Limit, _, Primes) when P > Limit -> lists:reverse(Primes);
%% build(P, Limit, Comps, Primes) ->
%% 	IsComp = sets:is_element(P, Comps),
%% 	if
%% 		IsComp ->
%% 			build(next(P), Limit, Comps, Primes);
%% 		true ->
%% 			Adds = sets:from_list(lists:seq(P+P, Limit, P)),
%% 			C2 = sets:union(Comps, Adds),
%% 			build(next(P), Limit, C2, [P|Primes])
%% 	end.
%% 
%% % This little cheat skips the obviously non-prime values.
%% next(2) -> 3;
%% next(N) -> N + 2.
