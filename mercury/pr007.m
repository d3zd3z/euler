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
:- import_module int.
:- import_module list.
:- import_module string.

:- import_module sieve.

main(!IO) :-
    Primes = reverse(atleast(10001, 1024)),
    Answer = det_index1(Primes, 10001) : int,
    io.print(Answer, !IO),
    io.nl(!IO).

% Get at least 'N' primes, with Try as the current attempt.
:- func atleast(int, int) = list(int).
atleast(N, Try) = P :-
    % trace [io(!IO)] (io.format("Try: %d\n", [i(Try)], !IO)),
    Primes = get_primes(new_sieve(Try)),
    ( if length(Primes) < N then
        P = atleast(N, Try * 8)
    else
        P = Primes
    ).
