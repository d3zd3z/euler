(* Miscellaneous utilities. *)

signature MISC =
sig
  val expt : int * int -> int
end

structure Misc =
struct
  (* A simple integer exponentiation. *)
  fun expt (base, power) =
    let
      fun loop (result, base, power) =
        if power = 0 then result else
          let
            val result =
              if power mod 2 <> 0 then
                result * base
              else
                result
            val base = base * base
          in
            loop (result, base, power div 2)
          end
    in
      loop (1, base, power)
    end
end

(* A general permuter. *)

(* A vector useful for permutation. *)
signature PERM_VECTOR =
sig
  type vector
  type elem

  val length : vector -> int
  val sub : vector * int -> elem
end

(* An array, used internally to manipulate this. *)
signature PERM_ARRAY =
sig
  eqtype array
  type elem
  type vector

  val array : int * elem -> array
  val length : array -> int
  val sub : array * int -> elem
  val tabulate : int * (int -> elem) -> array
  val update : array * int * elem -> unit
  val vector : array -> vector
end

signature PERM_KIND =
sig
  type elem
  structure A : PERM_ARRAY
  structure V : PERM_VECTOR
  val lt : elem * elem -> bool
  sharing type elem = A.elem
  sharing type elem = V.elem
  sharing type A.vector = V.vector
end

signature PERMUTE =
sig
  type state
  type vector
  val init : vector -> state
  val get : state -> vector
  val next : state -> bool

  val forall : (vector -> unit) -> vector -> unit
end

(* structure StringPermuter : PERMUTE = struct *)
functor PermuterFn (Arg : PERM_KIND) :> PERMUTE
  where type vector = Arg.V.vector =
struct

  open Arg

  type state = A.array
  type vector = V.vector

  fun init text =
    A.tabulate (V.length text,
      fn x => V.sub (text, x))

  fun get st =
    A.vector st

  fun swap (st, a, b) =
  let
    val tmp = A.sub (st, a)
  in
    A.update (st, a, A.sub (st, b));
    A.update (st, b, tmp)
  end

  fun revPart (st, a, b) =
    if a < b then
      (swap (st, a, b);
      revPart (st, a+1, b-1))
    else ()

  (* Advance the state to the next permutation, returning true if there is
   * another permutation. *)
  fun next st =
  let
    val len = A.length st
    val k = ref ~1
    val l = ref ~1
    fun kloop x =
      if x = len-1 then ()
      else let in
        if lt (A.sub (st, x), A.sub (st, x+1)) then
          k := x
        else ();
        kloop (x+1)
      end
    fun lloop x =
      if x = len then ()
      else let in
        if lt (A.sub (st, !k), A.sub (st, x)) then
          l := x
        else ();
        lloop (x+1)
      end
  in
    kloop 0;
    if !k < 0 then false else
      let in
        lloop (!k+1);
        swap (st, !k, !l);
        revPart (st, !k+1, len-1);
        true
      end
  end

  fun forall act text = let
    val state = init text
    fun loop () =
      if next state then
        (act (get state); loop ())
      else ()
  in
    loop ()
  end

end

structure StringKind : PERM_KIND =
struct
  type elem = char
  structure A = CharArray
  structure V = CharVector
  val lt = Char.<
end

structure StringPermuter = PermuterFn (StringKind)
