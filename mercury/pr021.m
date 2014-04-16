:- module pr021.

% Problem 21
%
% 05 July 2002
%
% Let d(n) be defined as the sum of proper divisors of n (numbers less than
% n which divide evenly into n).
% If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
% and each of a and b are called amicable numbers.
%
% For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
% 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
% 2, 4, 71 and 142; so d(284) = 220.
%
% Evaluate the sum of all the amicable numbers under 10000.
%
% 31626

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module array.
:- import_module int.
:- import_module list.
:- import_module string.

main(!IO) :-
    Divs = make_divisors(10000),
    fold_up(sum_amicable(Divs), 1, 10000, 0, Answer),
    io.print(Answer, !IO),
    io.nl(!IO).

:- type divs == array(int).

:- pred sum_amicable(divs::in, int::in, int::in, int::out) is det.
sum_amicable(Divs, A, !Sum) :-
    ( if amicable(Divs, A) then
        !:Sum = !.Sum + A
    else
        true
    ).

% Is this number part of an amicable pair.
:- pred amicable(divs::in, int::in) is semidet.
amicable(Divs, A) :-
    A < size(Divs),
    lookup(Divs, A, B),
    B < size(Divs),
    B \= A,
    lookup(Divs, B, C),
    A = C.

:- func make_divisors(int) = divs.
make_divisors(Size) = !:Divs :-
    !:Divs = init(Size, 1),
    set(0, 0, !Divs),
    fold_up(outer(Size-1), 2, Size-1, !Divs).

:- pred outer(int::in, int::in, divs::array_di, divs::array_uo) is det.
outer(Limit, I, !Divs) :-
    fold_up_by(inner(I), I + I, Limit, I, !Divs).

:- pred inner(int::in, int::in, divs::array_di, divs::array_uo) is det.
inner(I, J, !Divs) :-
    lookup(!.Divs, J, Value),
    set(J, Value + I, !Divs).

:- pred fold_up_by(pred(int, T, T), int, int, int, T, T).
:- mode fold_up_by(pred(in, in, out) is det, in, in, in, in, out) is det.
:- mode fold_up_by(pred(in, array_di, array_uo) is det, in, in, in, array_di, array_uo) is det.
fold_up_by(P, Lo, Hi, Inc, !A) :-
    ( if Lo =< Hi then
        P(Lo, !A),
        fold_up_by(P, Lo + Inc, Hi, Inc, !A)
    else
        true
    ).
