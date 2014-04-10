% Problem 7
%
% 28 December 2001
%
%
% By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
% that the 6th prime is 13.
%
% What is the 10 001st prime number?

-module(pr007).
-export([solve/0]).

solve() ->
	Primes = sieve:n_primes(10001),
	lists:nth(10001, Primes).
