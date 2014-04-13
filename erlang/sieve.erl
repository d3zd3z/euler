% A prime sieve, and some utilities.

-module(sieve).
-export([start/0,
	 stop/1,
	 is_prime/2,
	 primes_to/2,
	 n_primes/2,
	 next_prime/2]).

-record(state, {n, primes, set}).

start() -> spawn(fun loop/0).
stop(Pid) -> Pid ! stop.

% is X prime?
is_prime(Pid, X) ->
	Pid ! {self(), isPrime, X},
	receive {Pid, T} -> T end.

% Return primes at least to X (can return more).
primes_to(Pid, X) ->
	Pid ! {self(), primesTo, X},
	receive {Pid, P} -> P end.

% Return at least N primes.
n_primes(S, N) -> n_primes(S, N, N).

n_primes(S, N, X) ->
	P = primes_to(S, X),
	if
		length(P) >= N ->
			P;
		true ->
			n_primes(S, N, X * 2)
	end.

% Given a prime P, return the next prime.
next_prime(_S, 2) -> 3;
next_prime(S, P) -> next2(S, P + 2).

next2(S, P) ->
	Is = is_prime(S, P),
	if
		Is ->
			P;
		true ->
			next2(S, P + 2)
	end.

loop() -> loop(init_state()).

loop(S) ->
	receive
		stop ->
			true;
		% Is this value prime?
		{Pid, isPrime, X} ->
			S2 = ensure(S, X),
			Is = sets:is_element(X, S2#state.set),
			Pid ! {self(), Is},
			loop(S2);
		{Pid, primesTo, X} ->
			S2 = ensure(S, X),
			Pid ! {self(), S2#state.primes},
			loop(S2);
		Msg ->
			io:format("Unknown sieve request: ~w~n", [Msg])
	end.

init_state() ->
	N = 1024,
	Primes = primes(N),
	#state{n = N, primes = Primes, set = sets:from_list(Primes)}.

% Ensure the computed primes are sufficient for X.  The resulting
% state will contains primes at least up to X.
ensure(State, X) when X =< State#state.n -> State;
ensure(State, X) ->
	NewN = next_size(X, State#state.n),
	Primes = primes(NewN),
	#state{n=NewN, primes=Primes, set=sets:from_list(Primes)}.

% Compute a reasonable size for a new, larger, sieve.
next_size(Need, Cur) when Need =< Cur -> Cur;
next_size(Need, Cur) -> next_size(Need, Cur*8).

% Taken from
% http://stackoverflow.com/questions/146622/sieve-of-eratosthenes-in-erlang
% but modified to use the integer square root.
primes(N) ->
	primes(2, isqrt(N), [], lists:seq(3, N, 2)).

primes(Prime, Max, Primes, Integers) when Prime > Max ->
	lists:reverse([Prime|Primes], Integers);
primes(Prime, Max, Primes, Integers) ->
	[NewPrime|NewIntegers] = [ X || X <- Integers, X rem Prime =/= 0 ],
	primes(NewPrime, Max, [Prime|Primes], NewIntegers).

% Integer square root.
isqrt(Num) ->
	isqrt(0, find_bit(Num, 1), Num).

isqrt(Result, Bit, _Num) when Bit =:= 0 -> Result;
isqrt(Result, Bit, Num) ->
	Rb = Result + Bit,
	RlSr1 = Result bsr 1,
	BitLsr2 = Bit bsr 2,
	if
		Num >= Rb ->
			isqrt(RlSr1 + Bit, BitLsr2, Num - Rb);
		true ->
			isqrt(RlSr1, BitLsr2, Num)
	end.

% Find the higest even bit that is larger than the value.
find_bit(Num, Bit) when Bit =< Num ->
	find_bit(Num, Bit bsl 2);
find_bit(_Num, Bit) -> Bit.
