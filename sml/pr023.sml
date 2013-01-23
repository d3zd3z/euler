(*
 * Problem 23
 *
 * 02 August 2002
 *
 *
 * A perfect number is a number for which the sum of its proper
 * divisors is exactly equal to the number. For example, the sum of the
 * proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means
 * that 28 is a perfect number.
 *
 * A number n is called deficient if the sum of its proper divisors is
 * less than n and it is called abundant if this sum exceeds n.
 *
 * As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
 * smallest number that can be written as the sum of two abundant
 * numbers is 24. By mathematical analysis, it can be shown that all
 * integers greater than 28123 can be written as the sum of two
 * abundant numbers. However, this upper limit cannot be reduced any
 * further by analysis even though it is known that the greatest number
 * that cannot be expressed as the sum of two abundant numbers is less
 * than this limit.
 *
 * Find the sum of all the positive integers which cannot be written as
 * the sum of two abundant numbers.
 *
 * 4179871
 *)

structure Pr023 =
struct

structure Set = IntBinarySet

fun isAbundant (sv, n) =
    Sieve.properDivisorSum (sv, n) > n

fun abundants (sv, limit) =
    let val ints = List.tabulate (limit, fn x => x + 1)
    in
      List.filter (fn x => isAbundant (sv, x)) ints
    end

fun euler23 () =
    let val sv = Sieve.make 1024
	val limit = 28123
	val abundantList = abundants (sv, limit)

	fun innerLoop (_, [], acc) = acc
	  | innerLoop (a, b::xs, acc) =
	    let val ab = a + b in
	      if ab <= limit then
		innerLoop (a, xs, Set.add (acc, ab))
	      else
		innerLoop (a, xs, acc)
	    end

	fun outerLoop ([], acc) = acc
	  | outerLoop (xall as (a::xs), acc) = outerLoop (xs, innerLoop (a, xall, acc))

	val summable = outerLoop (abundantList, Set.empty)
	val allInts = Set.addList (Set.empty, List.tabulate (limit, fn x => x + 1))
	val notSummable = Set.difference (allInts, summable)
    in
      Set.foldl (op +) 0 notSummable
    end

(* Alternate algorithm, should be closer in operations to what the
 * Haskell version is doing. *)
fun solve () =
    let val sv = Sieve.make 1024
	val limit = 28123
	val abundantList = abundants (sv, limit)
	val abundantSet = Set.addList (Set.empty, abundantList)
	val allInts = List.tabulate (limit, fn x => x + 1)
	fun asSumP num =
	    List.exists (fn x => Set.member (abundantSet, num - x)) abundantList

	val reduced = List.filter (fn x => not (asSumP x)) allInts
    in
      List.foldl (op +) 0 reduced
    end

(* val () = print (Int.toString (solve()) ^ "\n") *)
end
