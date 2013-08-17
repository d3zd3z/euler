(*
 * Problem 37
 *
 * 14 February 2003
 *
 *
 * The number 3797 has an interesting property. Being prime itself, it
 * is possible to continuously remove digits from left to right, and
 * remain prime at each stage: 3797, 797, 97, and 7. Similarly we can
 * work from right to left: 3797, 379, 37, and 3.
 *
 * Find the sum of the only eleven primes that are both truncatable
 * from left to right and right to left.
 *
 * NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
 *
 * 748317
 *)

structure Pr037 =
struct

  fun rightTruncable (_, 0) = true
    | rightTruncable (sieve, num) =
        Sieve.isPrime (sieve, num) andalso rightTruncable (sieve, num div 10)

  fun leftChop num =
    Misc.reverseDigits (Misc.reverseDigits (num, 10) div 10, 10)

  fun leftTruncable (_, 0) = true
    | leftTruncable (sieve, num) =
        Sieve.isPrime (sieve, num) andalso leftTruncable (sieve, leftChop num)

  (* Conveniently, the problem statement tells us how many there are. *)
  fun solve () =
    let
      val sieve = Sieve.make 1024
      fun loop (_, sum, 11) = sum
        | loop (p, sum, count) =
            let
              val p' = Sieve.nextPrime (sieve, p)
            in
              if rightTruncable (sieve, p) andalso leftTruncable (sieve, p) then
                loop (p', sum + p, count + 1)
              else
                loop (p', sum, count)
            end
    in
      loop (11, 0, 0)
    end

end
