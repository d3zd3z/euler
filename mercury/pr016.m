:- module pr016.

% Problem 16
%
% 03 May 2002
%
% 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
%
% What is the sum of the digits of the number 2^1000?
%
% 1366

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.
:- import_module integer.
:- import_module list.
:- import_module string.

main(!IO) :-
    Big = pow(integer(2), integer(1000)),
    Answer = digitsum(Big, 0),
    io.print(Answer, !IO),
    io.nl(!IO).

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
