:- module pr007.

% Problem 7
%
% 28 December 2001
%
% By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
% that the 6th prime is 13.
%
% What is the 10 001st prime number?
%
% 104743

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list, int, string.
:- import_module bool.
:- import_module array.
% :- import_module pretty_printer.

main(!IO) :-
    Primes = atleast(10001, 1024),
    Answer = det_index1(Primes, 10001),
    % Answer = 0,
    % Ary = sieve(250),
    % Primes = get_primes(Ary),
    % write_doc(format(Primes), !IO),
    io.format("%d\n", [i(Answer)], !IO).

% Get at least 'N' primes, with Try as the current attempt.
:- func atleast(int, int) = list(int).
atleast(N, Try) = P :-
    Primes = get_primes(sieve(Try)),
    ( if length(Primes) < N then
        P = atleast(N, Try * 8)
    else
        P = Primes
    ).

% Create the prime array.
:- func sieve(int) = array(bool).
sieve(Size) = !:A :-
    !:A = array.init(Size, yes),
    set(0, no, !A),
    set(1, no, !A),
    update(4, 2, size(!.A), !A),
    walk(3, size(!.A), !A).

% Get all of the primes out of the sieve.
:- func get_primes(array(bool)) = list(int).
get_primes(A) = L :-
    Size = size(A),
    L1 = int.fold_up(getp(A), 2, Size-1, []),
    list.reverse(L1, L).

:- func getp(array(bool), int, list(int)) = list(int).
getp(A, N, L) = L2 :-
    ( if lookup(A, N) = yes then
        L2 = [N | L]
    else
        L2 = L
    ).

:- pred walk(int::in, int::in,
    array(bool)::array_di, array(bool)::array_uo).
walk(Pos, Limit, !A) :-
    ( if Pos >= Limit then
        true
    else if lookup(!.A, Pos) = no then
        walk(Pos + 2, Limit, !A)
    else
        update(Pos + Pos, Pos, Limit, !A),
        walk(Pos + 2, Limit, !A)
    ).

:- pred update(int::in, int::in, int::in,
    array(bool)::array_di, array(bool)::array_uo).
update(Pos, Inc, Limit, !A) :-
    ( if Pos < Limit then
        set(Pos, no, !A),
        update(Pos + Inc, Inc, Limit, !A)
    else
        true).
