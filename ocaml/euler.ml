(* Utilities for project euler. *)

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

module MakePermuter (Vec : VEC) (Cmp: Interfaces.OrderedType with type t = Vec.elt)
  : PERM with type t = Vec.t =
struct
  module Array = Vec
  type t = Vec.t

  let swap text a b =
    let tmp = text.(a) in
    text.(a) <- text.(b);
    text.(b) <- tmp

  let reverse_subvec text a b =
    let rec loop a b =
      if a < b then begin
	swap text a b;
	loop (a+1) (b-1)
      end in
    loop a b

  (* Modify the vector in place, to generate the next lexical
     permutation.  Raises Not_found if given the last permutation. *)
  let next_permutation text =
    let len = Array.length text in
    let k = ref (-1) in
    for x = 0 to len-2 do
      if Cmp.compare text.(x) text.(x+1) < 0 then
	k := x
    done;
    if !k < 0 then raise Not_found;
    let l = ref (-1) in
    for x = !k+1 to len-1 do
      if Cmp.compare text.(!k) text.(x) < 0 then
	l := x
    done;
    swap text !k !l;
    reverse_subvec text (!k+1) (len-1);
    text

end

module StringPermuter = MakePermuter (struct
  type elt = char
  include String
end) (Char)

let string_next_permutation = StringPermuter.next_permutation
