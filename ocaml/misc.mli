(* Utilities for project euler problems. *)

open Batteries

module type VEC = sig
  type elt
  type t
  val length : t -> int
  val get : t -> int -> elt
  val set : t -> int -> elt -> unit
end

module type PERM = sig
  type t
  val next_permutation : t -> t
end

module MakePermuter (Vec: VEC) (Cmp: Interfaces.OrderedType with type t = Vec.elt)
  : PERM with type t = Vec.t

val bytes_next_permutation : bytes -> bytes

val expt : int -> int -> int
val reverse_number : ?base:int -> int -> int
val number_of_digits : int -> int

module MillerRabin : sig
  val is_prime : ?k:int -> Num.num -> bool
  val is_prime_int : ?k:int -> int -> bool
end

val isqrt : int -> int
