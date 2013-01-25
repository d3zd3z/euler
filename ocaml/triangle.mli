(* Triangle utilities. *)

(* TODO: Make this a functional API instead of imperative. *)

type triple = { a : int; b : int; c : int }
type t = triple
val generate_triples : int -> (triple -> int -> unit) -> unit
val compare : t -> t -> int
