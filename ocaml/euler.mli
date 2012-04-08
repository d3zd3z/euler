(* Utilities for project euler problems. *)

open Batteries_uni

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

val string_next_permutation : string -> string
