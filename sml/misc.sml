(* Miscellaneous utilities. *)

signature MISC =
sig
  val expt : int * int -> int
  val largeExpt : IntInf.int * IntInf.int -> IntInf.int

  val isqrt : int -> int

  val reverseDigits : int * int -> int
  val isPalindrome : int * int -> bool
  val numberOfDigits : int -> int
  val largeNumberOfDigits : IntInf.int -> int

  val digitsOf : int -> int list

  (* Read the file, containing a list of quoted, comma separated words. and
   * return those words. *)
  val readWords : string -> string list

  (* Convert a name into it's numeric value by adding the characters as numbers,
   * with A=1, B=2, etc. *)
  val nameValue : string -> int
end

structure Misc : MISC =
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

  fun largeExpt (base, power) : IntInf.int =
    let
      fun loop (result, base, power) =
        if power = 0 then result else
          let
            val result =
              if IntInf.andb (power, 1) <> 0 then
                result * base
              else
                result
            val base = base * base
          in
            loop (result, base, IntInf.~>> (power, 0w1))
          end
    in
      loop (1, base, power)
    end

  fun isqrt num =
    let
      val num = Word.fromInt num
      fun findBit (num, bit) =
        let
          val bit2 = Word.<< (bit, 0w2)
        in
          if bit <= num then
            findBit (num, bit2)
          else bit
        end
      fun loop (result, bit, num) =
        if bit = 0w0 then Word.toInt result
        else
          let
            val rb = result + bit
            val rlsr1 = Word.>> (result, 0w1)
            val bitlsr2 = Word.>> (bit, 0w2)
          in
            if num >= rb then
              loop (rlsr1 + bit, bitlsr2, num - rb)
            else
              loop (rlsr1, bitlsr2, num)
          end
    in
      loop (0w0, findBit (num, 0w1), num)
    end

  fun reverseDigits (n, base) =
    let
      fun loop (n, result) =
        if n > 0 then
          loop (n div base, result * base + n mod base)
        else
          result
    in loop (n, 0)
    end

  fun isPalindrome (n, base) = n = reverseDigits (n, base)

  (* How many digits are in this number? *)
  fun numberOfDigits num =
    let
      fun loop (count, 0) = count
        | loop (count, n) = loop (count+1, n div 10)
    in
      loop (0, num)
    end

  fun largeNumberOfDigits num =
    let
      fun loop (count, n) =
        if n = 0 then count else
          loop (count+1, IntInf.div (n, 10))
    in
      loop (0, num)
    end

  (* What are the digits of the given number, as a list *)
  fun digitsOf digits =
    let
      fun loop (0, accum) = accum
        | loop (n, accum) = loop (n div 10, n mod 10 :: accum)
    in
      loop (digits, [])
    end

  fun finally (first, cleanup) =
    first () before cleanup ()
    handle e => (cleanup (); raise e)

  fun readWords path =
    let
      val strm = TextIO.openIn path
      fun openQuot result =
        case TextIO.input1 strm of
             NONE => raise Fail "Empty input"
           | SOME #"\"" => name (result, [])
           | SOME x => raise Fail "Illegal character"
      and name (result, buf) =
        case TextIO.input1 strm of
             NONE => raise Fail "unexpected EOF"
           | SOME #"\"" => comma (String.implode (rev buf) :: result)
           | SOME ch =>
               if Char.isUpper ch then
                 name (result, ch :: buf)
               else
                 raise Fail "Invalid character"
      and comma result =
        case TextIO.input1 strm of
             NONE => rev result
           | SOME #"," => openQuot result
           | SOME x => raise Fail "Illegal character"
    in
      finally (fn () => openQuot [], fn () => TextIO.closeIn strm)
    end

  fun nameValue name =
    let
      val len = size name
      fun loop (pos, sum) =
        if pos = len then
          sum
        else
          loop (pos+1, sum + Char.ord (String.sub (name, pos)) - Char.ord #"A" + 1)
    in
      loop (0, 0)
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
