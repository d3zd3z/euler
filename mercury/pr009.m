:- module pr009.

% Problem 9
%
% 25 January 2002
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

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list, int, string.
:- import_module maybe.
:- import_module solutions.

main(!IO) :-
    solutions(solve, Answer),
    io.print(Answer, !IO),
    io.nl(!IO).

:- pred solve(int::out) is nondet.
solve(N) :-
    nondet_int_in_range(1, 1000, A),
    nondet_int_in_range(A, 1000, B),
    C = 1000 - A - B,
    C > B,
    A*A + B*B = C*C,
    N = A * B * C.
