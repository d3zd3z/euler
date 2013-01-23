(*
 * Problem 10
 *
 * 08 February 2002
 *
 *
 * The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million.
 *
 * 142913828922
 *)

(* Note that the result is larger than a 32-bit number.  The primes
 * are not, though. *)

structure Pr010 =
struct

structure L = LargeInt

fun solve () =
    let
      val s = Sieve.make 2000100
      fun loop (p, sum) =
	  if p >= 2000000 then sum
	  else loop (Sieve.next_prime (s, p),
		     sum + Int.toLarge p)
    in
      loop (2, Int.toLarge 0)
    end

(* val () = print (L.toString (solve ()) ^ "\n") *)
end
