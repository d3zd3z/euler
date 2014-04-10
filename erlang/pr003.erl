% Problem 3
%
% 02 November 2001
%
%
% The prime factors of 13195 are 5, 7, 13 and 29.
%
% What is the largest prime factor of the number 600851475143 ?
%
% 6857

-module(pr003).
-export([solve/0]).

solve() ->
	solve(600851475143, 3). 

solve(1, P) -> P;
solve(N, P) when (N rem P) == 0 ->
	solve(N div P, P);
solve(N, P) ->
	solve(N, P + 2).
