(*
 * Problem 26
 *
 * 13 September 2002
 *
 *
 * A unit fraction contains 1 in the numerator. The decimal
 * representation of the unit fractions with denominators 2 to 10 are
 * given:
 *
 *     ^1/[2]  =  0.5
 *     ^1/[3]  =  0.(3)
 *     ^1/[4]  =  0.25
 *     ^1/[5]  =  0.2
 *     ^1/[6]  =  0.1(6)
 *     ^1/[7]  =  0.(142857)
 *     ^1/[8]  =  0.125
 *     ^1/[9]  =  0.(1)
 *     ^1/[10] =  0.1
 *
 * Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle.
 * It can be seen that ^1/[7] has a 6-digit recurring cycle.
 *
 * Find the value of d < 1000 for which ^1/[d] contains the longest
 * recurring cycle in its decimal fraction part.
 *
 * 983
 *)

structure Pr026 =
struct

(* Solve 10^k for 1 (mod n).  Don't call for a value that has a factor
 * of 10 in it, or this will not terminate. *)
fun dlog n =
    let fun loop (k, tmp) =
	    if tmp <= 1 then
	      k
	    else
	      loop (k+1, (tmp * 10) mod n)
    in
      loop (1, 10 mod n)
    end

fun solve () =
    let val sieve = Sieve.make 1024
	fun loop (index, longest, d) =
	    if d >= 1000 then index
	    else
	      let val length = dlog d
		  val next_d = Sieve.next_prime (sieve, d)
	      in
		if length > longest then
		  loop (d, length, next_d)
		else
		  loop (index, longest, next_d)
	      end
    in
      loop (0, ~1, 7)
    end

(* val () = print (Int.toString (solve ()) ^ "\n") *)
end
