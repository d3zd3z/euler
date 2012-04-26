(* Functional sieves. *)

(* Prime number sieve, based on arbitrary precision integers. *)

structure Sieve =
struct

type elt = IntInf.int

type node = {
     next: elt,
     steps: elt list
}

end
