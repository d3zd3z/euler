(* Numeric sieve, based on Core *)

open! Core.Std

(* Pure, immutable primes. *)
module type S = sig
  type elt
  type t
  val initial : t
  val next : t -> (elt * t)

  (* Run a sequence of the primes starting with the given state.  Note
   * that the sequence is not bounded. *)
  val to_sequence : t -> elt Sequence.t
end

module Make (Num : Int_intf.S) : S with type elt = Num.t
module IntSieve : S with type elt = int
module Int64Sieve : S with type elt = int64

(* Top-level traditionally used sieve. *)
type t
val create : unit -> t
val is_prime : t -> int -> bool
val next_prime : t -> int -> int
type factor = { prime : int; power : int }
val factorize : t -> int -> factor list
val divisor_count : t -> int -> int
val proper_divisor_sum : t -> int -> int
(* val all_primes : t -> int Sequence.t *)
val primes_upto : t -> int -> int Sequence.t
