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

(*
(* A factory can generate prime numbers, remembering them from prior uses. *)
module type FACTORY = sig
  type t
  val primes_upto : t -> t Enum.t
end

module MakeFactory(Num: SimpleNumeric): S with type elt = Num.t
*)
