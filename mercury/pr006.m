:- module pr006.

% Problem 6
%
% 14 December 2001
%
% The sum of the squares of the first ten natural numbers is,
%
% 1^2 + 2^2 + ... + 10^2 = 385
%
% The square of the sum of the first ten natural numbers is,
%
% (1 + 2 + ... + 10)^2 = 55^2 = 3025
%
% Hence the difference between the sum of the squares of the first ten
% natural numbers and the square of the sum is 3025 − 385 = 2640.
%
% Find the difference between the sum of the squares of the first one
% hundred natural numbers and the square of the sum.
%
% 25164150

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list, int, string.

main(!IO) :-
    int.fold_up(plus, 1, 100, 0, Sum),
    int.fold_up(plussq, 1, 100, 0, Sumsq),
    Answer = Sum * Sum - Sumsq,
    io.format("%d\n", [i(Answer)], !IO).

:- pred plus(int::in, int::in, int::out) is det.
plus(A, B, C) :- C = A + B.

:- pred plussq(int::in, int::in, int::out) is det.
plussq(A, B, C) :- C = A*A + B.
