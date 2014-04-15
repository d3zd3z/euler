:- module pr010.

% Problem 10
%
% 08 February 2002
%
% The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
%
% Find the sum of all the primes below two million.
%
% 142913828922

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list, int, string.
:- import_module sieve.

main(!IO) :-
    Primes = filter(less_than(2000000), get_primes(new_sieve(2000000))),
    Answer = foldl(plus, Primes, 0),
    io.print(Answer, !IO),
    io.nl(!IO).

% Select values less than 200000
:- pred less_than(int::in, int::in) is semidet.
less_than(V, N) :- N < V.
