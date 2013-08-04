// The sieve.

module Sieve

type Factor = { Prime : int; Power : int }

type Sieve =
  new : unit -> Sieve
  member IsPrime : n:int -> bool
  member NextPrime : n:int -> int
  member PrimesFrom : n:int -> int seq
  member DivisorCount : n:int -> int

  member Factors : n:int -> Factor list

  member Divisors : n:int -> int list

  member ProperDivisorSum : n:int -> int
