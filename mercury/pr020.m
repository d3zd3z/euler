:- module pr020.

% Problem 20
%
% 21 June 2002
%
% n! means n × (n − 1) × ... × 3 × 2 × 1
%
% For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
% and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
% 27.
%
% Find the sum of the digits in the number 100!
%
% 648

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.
:- import_module integer.
:- import_module list.
:- import_module string.

main(!IO) :-
    Answer = digitsum(fact(100), 0),
    io.print(Answer, !IO),
    io.nl(!IO).

:- func fact(int) = integer.
:- func fact(int, integer) = integer.

fact(N) = fact(N, one).

fact(N, Accum) = Res :-
    ( if N = 1 then
        Res = Accum
    else
        Res = fact(N-1, Accum*integer(N))
    ).

:- func digitsum(integer, int) = int.
digitsum(N, Accum) = Result :-
    ( if N = zero then
        Result = Accum
    else
        Ten = integer(10),
        N2 = N div Ten,
        Tmp = int(N mod Ten),
        Result = digitsum(N2, Accum + Tmp)
    ).
