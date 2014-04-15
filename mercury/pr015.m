:- module pr015.

% Problem 15
%
% 19 April 2002
%
% Starting in the top left corner of a 2×2 grid, there are 6 routes (without
% backtracking) to the bottom right corner.
%
% [p_015]
%
% How many routes are there through a 20×20 grid?
%
% 137846528820

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.
:- import_module list.
:- import_module std_util.
:- import_module string.

main(!IO) :-
    Answer = det_last(pow(bump, 20, duplicate(21, 1))) : int,
    io.print(Answer, !IO),
    io.nl(!IO).

:- func bump(list(int)) = list(int).
bump(L) = R :-
    (
        L = [],
        R = []
    ;
        L = [A],
        R = [A]
    ;
        L = [A, B | As],
        R = [A | bump([A+B | As])]
    ).
