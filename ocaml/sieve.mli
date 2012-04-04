(* Numeric sieve. *)

open Batteries_uni

module type SimpleNumeric = sig
  type t
  val compare: t -> t -> int
  val add: t -> t -> t
  val mul: t -> t -> t
  val zero: t
  val one: t
end

module type S = sig
  type elt
  type t
  val initial: t
  val next: t -> (elt * t)
end

module Make(Num: SimpleNumeric): S with type elt = Num.t
module IntSieve: S with type elt = int
module Int64Sieve: S with type elt = int64

(* A factory can generate prime numbers, remembering them from prior uses. *)
module type FACTORY = sig
  type t
  val isqrt : t -> t
  val primes_upto : t -> t Enum.t
  val is_prime : t -> bool

  type factor = { prime: t; power: int }
  val factorize : t -> factor list
  val divisor_count : t -> int
  val divisors : t -> t list
end

(* The factory needs a few more operations from numbers. *)
module type RICH_NUMERIC = sig
  include SimpleNumeric
  val sub : t -> t -> t
  val div : t -> t -> t
  val modulo : t -> t -> t
  val shift_left : t -> int -> t
  val shift_right : t -> int -> t
end

module MakeFactory(Num: RICH_NUMERIC): FACTORY with type t = Num.t
module IntFactory: FACTORY with type t = int
