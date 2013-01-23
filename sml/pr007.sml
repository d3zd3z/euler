(*
 * Problem 7
 *
 * 28 December 2001
 *
 *
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
 * can see that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 *
 * 104743
 *)

structure Pr007 =
struct

fun solve () =
    let
      val sieve = Sieve.make 1024
      fun loop (n, count) =
	  if count = 10001 then n
	  else loop (Sieve.next_prime (sieve, n), count + 1)
    in
      loop (2, 1)
    end

(* val () = print (Int.toString (solve ()) ^ "\n") *)
end
