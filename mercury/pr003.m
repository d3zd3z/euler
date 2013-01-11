:- module pr003.

% Problem 3
%
% 02 November 2001
%
% The prime factors of 13195 are 5, 7, 13 and 29.
%
% What is the largest prime factor of the number 600851475143 ?
%
% 6857
%
% Note that this solution assumes a 64-bit platform.

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list, int, string.

main(!IO) :-
    solve(600851475143, 2, Answer),
    io.format("%d\n", [i(Answer)], !IO).

% solve(number, factor, answer)
:- pred solve(int::in, int::in, int::out) is det.
solve(N, P, Answer) :-
    ( if
	N =< 1
    then
	Answer = P
    else if
	(N mod P) = 0
    then
	solve(N // P, P, Answer)
    else
	solve(N, next(P), Answer)
    ).

:- func next(int::in) = (int::out) is det.
next(N) = (N = 2 -> 3 ; N + 2).
