% Problem 5
%
% 30 November 2001
%
%
% 2520 is the smallest number that can be divided by each of the numbers
% from 1 to 10 without any remainder.
%
% What is the smallest positive number that is evenly divisible by all of
% the numbers from 1 to 20?
%
% 232792560

-module(pr005).
-export([solve/0]).

solve() ->
	lists:foldl(fun lcm/2, 1, lists:seq(2, 20)).

gcd(A, 0) -> A;
gcd(A, B) ->
	gcd(B, A rem B).

lcm(A, B) ->
	abs((A div gcd(A, B)) * B).
