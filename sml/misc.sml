(* Miscellaneous utilities. *)

(* A general permuter. *)

(* First write specifically for strings, and then make into a functor. *)

signature PERMUTE =
sig
  type state
  val init : string -> state
  val get : state -> string
  val next : state -> bool

  val forall : (string -> unit) -> string -> unit
end

structure StringPermuter : PERMUTE = struct

  structure A = CharArray

  type state = A.array

  fun init text =
    A.tabulate (String.size text,
      fn x => CharVector.sub (text, x))

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
        if A.sub (st, x) < A.sub (st, x+1) then
          k := x
        else ();
        kloop (x+1)
      end
    fun lloop x =
      if x = len then ()
      else let in
        if A.sub (st, !k) < A.sub (st, x) then
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
