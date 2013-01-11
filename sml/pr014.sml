(*
 * Problem 14
 *
 * 05 April 2002
 *
 *
 * The following iterative sequence is defined for the set of positive
 * integers:
 *
 * n → n/2 (n is even)
 * n → 3n + 1 (n is odd)
 *
 * Using the rule above and starting with 13, we generate the following
 * sequence:
 *
 * 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
 *
 * It can be seen that this sequence (starting at 13 and finishing at
 * 1) contains 10 terms. Although it has not been proved yet (Collatz
 * Problem), it is thought that all starting numbers finish at 1.
 *
 * Which starting number, under one million, produces the longest
 * chain?
 *
 * NOTE: Once the chain starts the terms are allowed to go above one
 * million.
 *
 * 837799
 *)

(* structure Elt = Int *)
structure Elt = Int64

(* First, a simple, non-memoized version. *)
fun chainLength 1 = 1
  | chainLength n =
    if n mod 2 = 0 then
      1 + chainLength (n div 2)
    else
      1 + chainLength (n * 3 + 1)

(* The larger this is, the faster the end result (but the more memory that is used). *)
val cacheSize = 10000 : Elt.int

fun makeCache () = Array.array (Elt.toInt cacheSize, NONE : int option)

fun cachedChainLength _ 1 = 1
  | cachedChainLength cache (n : Elt.int) =
    let fun subLen n =
	    if n mod 2 = 0 then
	      1 + (cachedChainLength cache (n div 2))
	    else
	      1 + (cachedChainLength cache (n * 3 + 1))
    in
      if n >= cacheSize then
	subLen n
      else
	case Array.sub (cache, Elt.toInt n) of
	    NONE => let val result = subLen n in
		      Array.update (cache, Elt.toInt n, SOME result);
		      result
		    end
	  | SOME x => x
    end

fun solve (lengther : Elt.int -> int) =
    let fun loop (largest, largestVal, n) =
	    if n = 1000000 then
	      largestVal
	    else
	      let val temp = lengther n in
		if temp > largest then
		  loop (temp, n, n+1)
		else
		  loop (largest, largestVal, n+1)
	      end
    in
      loop (0, 0, 1)
    end

val () = print (Elt.toString (solve (cachedChainLength (makeCache ()))) ^ "\n")
