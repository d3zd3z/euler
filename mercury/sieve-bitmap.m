:- module sieve.

:- interface.
:- import_module list.

:- type sieve.

% Generate a new sieve with the given limit.  It will be valid for detecting
% primes up to, but not including this limit.
:- func new_sieve(int) = sieve.

% New sieve with a default size.
:- func new_sieve = sieve.

% Possibly regenerate a sieve, to make sure it can compute primes up to, and
% not including Size.
:- pred ensure_size(int::in, sieve::in, sieve::out) is det.

% Given a sieve, return the primes contained in it.
:- func get_primes(sieve) = list(int).

% Return the next prime.  Will cause an error if the sieve is not large enough.
:- func next_prime(sieve, int) = int.

% Is this number prime, causes an error if the sieve is not large enough.
:- pred is_prime(sieve::in, int::in) is semidet.

%------------------------------------------------------------%

:- implementation.
:- import_module bool.
:- import_module int.
:- import_module list.
:- import_module bitmap.
:- import_module io.
:- import_module string.

% The fastest type to use is just an array of bools.  Sets work, but are about
% an order of magnitude slower.

% A sieve is a set of the composites, and the limit for which those composites
% were computed to.
:- type sieve
    --->    sieve(
                sieve_primes      :: bitmap,
                sieve_size        :: int
            ).

new_sieve = new_sieve(1024).

new_sieve(Size) = sieve(!:C, Size) :-
    !:C = init(Size, yes),
    clear(0, !C),
    clear(1, !C),
    update(4, 2, Size, !C),
    walk(3, Size, !C).

ensure_size(Size, !S) :-
    ( if Size < !.S ^ sieve_size then
        true
    else
        trace [ io(!IO) ] (
            io.format("Computing %d seive...", [i(Size)], !IO),
            io.flush_output(!IO)
        ),
        Size2 = next_size(Size, Size),
        !:S = new_sieve(Size2),
        trace [ io(!IO) ] (
            io.format("done\n", [], !IO)
        )
    ).

is_prime(S, N) :-
    is_set(S ^ sieve_primes, N).

next_prime(S, N) = R :-
    N2 = (if N = 2 then 3 else N + 2),
    ( if is_prime(S, N2) then
        R = N2
    else
        R = next_prime(S, N2)
    ).

% To make sure this grows reasonably, compute the better size.
:- func next_size(int, int) = int.
next_size(Need, Cur) = Next :-
    ( if Need < Cur then
        Next = Cur
    else
        Next = next_size(Need, Cur * 8)
    ).

% Get all of the primes out of the sieve.
get_primes(sieve(C, Size)) = L :-
    L = int.fold_up(getp(C), 2, Size-1, []).

:- func getp(bitmap, int, list(int)) = list(int).
getp(C, N, L) = L2 :-
    ( if is_clear(C, N) then
        L2 = L
    else
        L2 = [N | L]
    ).

% Walk through the primes, marking all of the composites generated by them.
:- pred walk(int::in, int::in,
    bitmap::bitmap_di, bitmap::bitmap_uo).
walk(Pos, Limit, !C) :-
    ( if Pos >= Limit then
        true
    else if is_clear(!.C, Pos) then
        walk(Pos + 2, Limit, !C)
    else
        update(Pos + Pos, Pos, Limit, !C),
        walk(Pos + 2, Limit, !C)
    ).

% Update the sieve to include all composite from prime P.
:- pred update(int::in, int::in, int::in,
    bitmap::bitmap_di, bitmap::bitmap_uo).
update(Pos, Inc, Limit, !C) :-
    ( if Pos < Limit then
        clear(Pos, !C),
        update(Pos+Inc, Inc, Limit, !C)
    else
        true).
