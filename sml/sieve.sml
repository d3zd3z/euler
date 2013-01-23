(* Functional sieves. *)

(* TODO: Make the int type a parameter. *)
signature SIEVE =
sig
  type t
  val make : int -> t
  val is_prime : (t * int) -> bool
  val next_prime : (t * int) -> int
  type factor = { prime : int,
		  power : int }
  val factorize : (t * int) -> factor list
  val divisorCount : (t * int) -> int
  val divisors : (t * int) -> int list
  val properDivisorSum : (t * int) -> int
end

structure Sieve : SIEVE =
struct

type t = bool array ref

fun raw_make len =
    let
      val buf = Array.array (len, true)

      fun next p =
	  if p >= len orelse Array.sub (buf, p) then p
	  else next (p+2)

      fun outer p =
	  if p >= len then ()
	  else let
	    fun inner n =
		if n >= len then ()
		else (
		  Array.update (buf, n, false);
		  inner (n + p))
	  in
	    inner (p + p);
	    outer (next (if p = 2 then 3 else p + 2))
	  end
    in
      Array.update (buf, 0, false);
      Array.update (buf, 1, false);
      outer 2;
      buf
    end

fun make len = ref (raw_make len)

fun new_size (cur_size, needed) =
    if cur_size <= needed then
      new_size (cur_size * 8, needed)
    else
      cur_size

fun is_prime (sieve, n) =
    (if Array.length (!sieve) <= n then
       sieve := raw_make (new_size (Array.length (!sieve), n))
     else ();
     Array.sub (!sieve, n))

fun next_prime (sieve, p) =
    let val p = if p = 2 then 3 else p + 2
    in
      if is_prime (sieve, p) then p
      else next_prime (sieve, p)
    end

type factor = { prime : int,
		power : int }

fun factorize (sieve, n) =
    let fun addFactor (result, p, count) =
	    if count > 0 then
	      { prime = p, power = count } :: result
	    else
	      result
	fun loop (result, n, p, count) =
	    if n = 1 then addFactor (result, p, count)
	    else
	      if n mod p = 0 then
		loop (result, n div p, p, count + 1)
	      else
		loop (addFactor (result, p, count),
		      n, next_prime (sieve, p), 0)
    in
      loop ([], n, 2, 0)
    end

fun divisorCount (sieve, n) =
    foldl (fn (elt, accum) => (#power elt + 1) * accum)
	  1
	  (factorize (sieve, n))

fun spread ([]) = [1]
  | spread ({prime = xPrime, power = xPower}::xs) =
    let val others = spread xs
	fun loop (result, pow, i) =
	    if i > xPower then result
	    else
	      loop (result @ (map (fn x => x * pow) others), pow * xPrime, i + 1)
    in
      loop ([], 1, 0)
    end

fun divisors (sv, n) =
    ListMergeSort.sort (op >) (spread (factorize (sv, n)))

fun properDivisorSum (sv, n) =
    let val divs = divisors (sv, n)
	val sum = foldl (op +) 0 divs
    in
      sum - n
    end

end
