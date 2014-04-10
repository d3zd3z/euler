% Problem 1
%
% 05 October 2001
%
%
% If we list all the natural numbers below 10 that are multiples of 3 or 5,
% we get 3, 5, 6 and 9. The sum of these multiples is 23.
%
% Find the sum of all the multiples of 3 or 5 below 1000.
%
% 233168

-module(pr001).
-export([solve/0]).

solve() ->
	Stop = 999,
	All = lists:filter(fun divable/1, lists:seq(1, Stop)),
	lists:sum(All). 

divable(X) -> X rem 3 == 0 orelse X rem 5 == 0.
