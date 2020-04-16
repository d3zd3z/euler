(* Core-based utilities for euler problems. *)

(* open Core *)

exception Last_permutation

(* This module contains fixes for Z and Q from zarith that provide a
 * non-polymorphic equal, to fit better with Core. *)
module Fix_zarith : sig
  module Z : sig
    include (module type of Z)
    val (=) : Z.t -> Z.t -> bool
    val (<>) : Z.t -> Z.t -> bool
  end
  with type t = Z.t

  module Q : sig
    include (module type of Q)
    val (=) : Q.t -> Q.t -> bool
    val (<>) : Q.t -> Q.t -> bool
  end
  with type t = Q.t
end

(* A general vector type. *)
module type VEC = sig
  type t
  type elt
  val length : t -> int
  val get : t -> int -> elt
  val set : t -> int -> elt -> unit
end

(* TODO: Can we leverage the comparison found in Core? *)
module type CMP = sig
  type t
  val compare : t -> t -> int
end

module type PERM = sig
  type t
  val next_permutation : t -> t
end

module Make_permuter (Vec : VEC) (Cmp : CMP with type t = Vec.elt) : PERM with type t = Vec.t

val bytes_next_permutation : bytes -> bytes

val expt : int -> int -> int
val reverse_number : ?base:int -> int -> int
val number_of_digits : int -> int

module MillerRabin : sig
  val is_prime : ?k:int -> Num.num -> bool
  val is_prime_int : ?k:int -> int -> bool
end

(* Integer-only primarlity test. Currently broken, do not use. *)
val int_is_prime : ?k:int -> int -> bool

val isqrt : int -> int

(* A simple result container.  It can hold a single result, and makes sure
 * there isn't more than one result.  It doesn't stop the computation early. *)
module Result :
  sig
    type 'a t
    val make : unit -> 'a t
    val save : 'a t -> 'a -> unit
    val get : 'a t -> 'a
  end
