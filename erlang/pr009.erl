% Problem 9
%
% 25 January 2002
%
%
% A Pythagorean triplet is a set of three natural numbers, a < b < c, for
% which,
%
% a^2 + b^2 = c^2
%
% For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
%
% There exists exactly one Pythagorean triplet for which a + b + c = 1000.
% Find the product abc.
%
% 31875000

-module(pr009).
-export([solve/0]).

solve() ->
	outer(1).

outer(1000) -> unknown;
outer(A) -> inner(A, A).

inner(A, 1000) -> outer(A + 1);
inner(A, B) ->
	C = 1000 - A - B,
	if
		C > B andalso A * A + B * B =:= C * C ->
			A * B * C;
		true ->
			inner(A, B+1)
	end.
