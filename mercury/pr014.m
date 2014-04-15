:- module pr014.

% Problem 14
%
% 05 April 2002
%
% The following iterative sequence is defined for the set of positive
% integers:
%
% n → n/2 (n is even)
% n → 3n + 1 (n is odd)
%
% Using the rule above and starting with 13, we generate the following
% sequence:
%
% 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
%
% It can be seen that this sequence (starting at 13 and finishing at 1)
% contains 10 terms. Although it has not been proved yet (Collatz Problem),
% it is thought that all starting numbers finish at 1.
%
% Which starting number, under one million, produces the longest chain?
%
% NOTE: Once the chain starts the terms are allowed to go above one million.
%
% 837799

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.
:- import_module list.
:- import_module string.

main(!IO) :-
    fold_up(piece, 1, 1000000, {0, 0}, {Answer, _}),
    io.print(Answer, !IO),
    io.nl(!IO).

:- pred piece(int::in, {int, int}::in, {int, int}::out) is det.
piece(N, {MaxN, MaxVal}, {NewN, NewVal}) :-
    collatz(1, N, Count),
    ( if Count > MaxVal then
        NewN = N,
        NewVal = Count
    else
        NewN = MaxN,
        NewVal = MaxVal
    ).

:- pred collatz(int::in, int::in, int::out) is det.
collatz(Count, N, Result) :-
    ( if N = 1 then
        Result = Count
    else if N mod 2 = 0 then
        collatz(Count + 1, N // 2, Result)
    else
        collatz(Count + 1, N * 3 + 1, Result)
    ).
