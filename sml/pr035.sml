(*
 * Problem 35
 *
 * 17 January 2003
 *
 *
 * The number, 197, is called a circular prime because all rotations of
 * the digits: 197, 971, and 719, are themselves prime.
 *
 * There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17,
 * 31, 37, 71, 73, 79, and 97.
 *
 * How many circular primes are there below one million?
 *
 * 55
 *)

structure Pr035 = struct

  (* Returns all of the rotations of a number, not including the original. *)
  fun numberRotations num =
    let
      val len = Misc.numberOfDigits num
      val highestOne = Misc.expt (10, len-1)
      fun loop (right, left, accum, n, result) =
        if left >= highestOne then result else
          let
            val nQuotient = n div 10
            val nRemainder = n mod 10
            val newAccum = accum + left * nRemainder
            val next = nQuotient + right * newAccum
          in
            loop (right div 10, left * 10, newAccum, nQuotient, next::result)
          end
    in
      loop (highestOne, 1, 0, num, [])
    end

  fun solve () =
    let
      val limit = 1000000
      val sieve = Sieve.make limit
      fun loop (count, prime) =
        if prime > limit then count else
          let
            val prime' = Sieve.nextPrime (sieve, prime)
            fun isPrime x = Sieve.isPrime (sieve, x)
          in
            if List.all isPrime (numberRotations prime) then
              loop (count+1, prime')
            else
              loop (count, prime')
          end
    in
      loop (0, 2)
    end

end
