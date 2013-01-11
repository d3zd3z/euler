:- module pr004.

% Problem 4
%
% 16 November 2001
%
% A palindromic number reads the same both ways. The largest palindrome made
% from the product of two 2-digit numbers is 9009 = 91 x 99.
%
% Find the largest palindrome made from the product of two 3-digit numbers.
%

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is cc_multi.

:- implementation.
:- import_module list, int, string.
:- import_module solutions.

main(!IO) :-
    unsorted_aggregate(products, int.max, 0, Best),
    io.print(Best, !IO),
    io.nl(!IO).

:- pred products(int::out) is nondet.
products(N) :-
    int.nondet_int_in_range(100, 999, A),
    int.nondet_int_in_range(A, 999, B),
    N = A * B,
    palindrome(N).

% Manual loops, rather than using backtracking to generate the loops.
% main(!IO) :-
%     int.fold_up(outer_loop, 100, 999, 0, Answer),
%     io.format("%d\n", [i(Answer)], !IO).
% :- pred outer_loop(int::in, int::in, int::out) is det.
% outer_loop(A, Max, Result) :-
%     int.fold_up(inner_loop(A), A, 999, Max, Result).
% 
% :- pred inner_loop(int::in, int::in, int::in, int::out) is det.
% inner_loop(A, B, Max, Result) :-
%     C = A * B,
%     (
% 	if (C > Max, palindrome(C)) then
% 	    Result = C
% 	else
% 	    Result = Max
%     ).

:- pred palindrome(int::in) is semidet.
palindrome(A) :-
    reverse(A, 0, RevA),
    A = RevA.

:- pred reverse(int::in, int::in, int::out) is det.
reverse(N, Accum, Result) :- (
    if N =< 0 then
	Accum = Result
    else
	reverse(N div 10, Accum * 10 + N mod 10, Result)
    ).
