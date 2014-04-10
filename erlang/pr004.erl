% Problem 4
%
% 16 November 2001
%
%
% A palindromic number reads the same both ways. The largest palindrome made
% from the product of two 2-digit numbers is 9009 = 91 × 99.
%
% Find the largest palindrome made from the product of two 3-digit numbers.
%
% 906609

-module(pr004).
-export([solve/0]).

solve() ->
	outer(100, 0).

outer(1000, Max) -> Max;
outer(A, Max) ->
	Max2 = inner(A, A, Max),
	outer(A+1, Max2).

inner(_, 1000, Max) -> Max;
inner(A, B, Max) ->
	Prod = A * B,
	IsP = is_palindrome(Prod),
	if
		IsP ->
			inner(A, B+1, max(Prod, Max));
		true ->
			inner(A, B+1, Max)
	end.

% Is this number a palindrome.
is_palindrome(X) -> X == reverse_digits(X).

% Reverse the digits of the given number (in base 10).
reverse_digits(N) -> reverse_digits(N, 0).
reverse_digits(0, R) -> R;
reverse_digits(N, R) ->
	reverse_digits(N div 10, R * 10 + N rem 10).
