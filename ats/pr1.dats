(*
 *   • About
 *   • Register
 *   • Problems
 *   • Login
 *
 * RSS FeedUse secure connection
 * Project Euler .net
 * projecteuler.net
 *
 * Problem 1
 *
 * 05 October 2001
 *
 *
 * If we list all the natural numbers below 10 that are
 * multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these
 * multiples is 23.
 *
 * Find the sum of all the multiples of 3 or 5 below 1000.
 *)

implement
main () = let
  val LIMIT = 1000
  fun loop (n: int, res: int): int =
    if n = LIMIT then res else begin
      loop (n + 1, if (n mod 3 = 0 orelse n mod 5 = 0) then res + n else res)
    end
  val answer = loop (1, 0)
in
  printf ("Sum = %d\n", @(answer))
end
