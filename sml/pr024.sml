(*
 * Problem 24
 *
 * 16 August 2002
 *
 *
 * A permutation is an ordered arrangement of objects. For example,
 * 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all
 * of the permutations are listed numerically or alphabetically, we
 * call it lexicographic order. The lexicographic permutations of 0, 1
 * and 2 are:
 *
 * 012   021   102   120   201   210
 *
 * What is the millionth lexicographic permutation of the digits 0, 1,
 * 2, 3, 4, 5, 6, 7, 8 and 9?
 *
 * 2783915460
 *)

structure Pr024 =
struct

fun base () = Array.tabulate (10, (fn x => Char.chr (x + Char.ord #"0")))

fun nextPermutation text =
    let val length = Array.length text
	val k = ref 1
	val l = ref ~1;
	fun loop1 x = if x = length - 1 then ()
		      else (if Char.< (Array.sub (text, x), Array.sub (text, x+1))
			    then k := x else ();
			    loop1 (x+1))
	fun loop2 x = if x = length then ()
		      else (if Char.< (Array.sub (text, !k), Array.sub (text, x))
			    then l := x else ();
			    loop2 (x + 1))
	fun swap (a, b) =
	    let val tmp = Array.sub (text, a)
	    in Array.update (text, a, Array.sub (text, b));
	       Array.update (text, b, tmp)
	    end
	fun reverse (a, b) =
	    if a < b then (swap (a, b);
			   reverse (a + 1, b - 1))
	    else ()
    in
      loop1 0;
      if !k < 0 then NONE
      else (loop2 (!k + 1);
	    swap (!k, !l);
	    reverse (!k + 1, length - 1);
	    SOME text)
    end

(* fun show text = (Array.app (fn x => print (Char.toString x)) text; print "\n") *)
fun show text = String.implode (Array.foldr (op ::) [] text)

fun solve () =
    let fun loop (1000000, (SOME text)) = show text
	  | loop (n, (SOME text)) = loop (n+1, nextPermutation text)
	  | loop (_, NONE) = raise Fail "Out of permutations"
    in loop (1, SOME (base ()))
    end

(* val () = solve () *)
end
