:- module pr001.

% If we list all the natural numbers below 10 that are multiples of
% 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
%
% Find the sum of all the multiples of 3 or 5 below 1000.
%
% 233168

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.


:- implementation.
:- import_module list, int, string.

main(!IO) :-
    int.fold_up(each_mod, 1, 999, 0, Answer),
    io.format("%d\n", [i(Answer)], !IO).

:- pred each_mod(int::in, int::in, int::out) is det.

each_mod(N, Sofar, Answer) :-
    Piece = (if ((N mod 5) = 0 ; (N mod 3) = 0) then N else 0),
    Answer = Sofar + Piece.
