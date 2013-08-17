(*
 * Problem 87
 *
 * 21 January 2005
 *
 *
 * The smallest number expressible as the sum of a prime square, prime
 * cube, and prime fourth power is 28. In fact, there are exactly four
 * numbers below fifty that can be expressed in such a way:
 *
 * 28 = 2^2 + 2^3 + 2^4
 * 33 = 3^2 + 2^3 + 2^4
 * 49 = 5^2 + 2^3 + 2^4
 * 47 = 2^2 + 3^3 + 2^4
 *
 * How many numbers below fifty million can be expressed as the sum of
 * a prime square, prime cube, and prime fourth power?
 *
 * 1097343
 *)

structure Pr087 =
struct

  structure Set = IntBinarySet

  fun primesUpto n =
  let
    val sieve = Sieve.make n
    fun loop (i, accum) =
      if i >= n then rev accum
      else loop (Sieve.next_prime (sieve, i), i :: accum)
  in
    loop (2, [])
  end

  fun solve () =
  let
    val limit = 50000000
    val primes = primesUpto 7071
    fun quadLoop ([], set) = set
      | quadLoop (q::qr, set) =
        let
          val q2 = q * q
          val q4 = q2 * q2
        in
          if q4 < limit then
            quadLoop (qr, tripLoop (q4, primes, set))
          else
            set
        end
    and tripLoop (q4, [], set) = set
      | tripLoop (q4, t::tr, set) =
        let
          val t3 = t*t*t + q4
        in
          if t3 < limit then
            tripLoop (q4, tr, doubLoop (t3, primes, set))
          else
            set
        end
    and doubLoop (t3, [], set) = set
      | doubLoop (t3, d::dr, set) =
        let
          val d2 = d*d + t3
        in
          if d2 < limit then
            doubLoop (t3, dr, Set.add (set, d2))
          else
            set
        end
  in
    Set.numItems (quadLoop (primes, Set.empty))
  end

end
