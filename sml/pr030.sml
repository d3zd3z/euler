(*
 * Problem 30
 *
 * 08 November 2002
 *
 *
 * Surprisingly there are only three numbers that can be written as the
 * sum of fourth powers of their digits:
 *
 *     1634 = 1^4 + 6^4 + 3^4 + 4^4
 *     8208 = 8^4 + 2^4 + 0^4 + 8^4
 *     9474 = 9^4 + 4^4 + 7^4 + 4^4
 *
 * As 1 = 1^4 is not a sum it is not included.
 *
 * The sum of these numbers is 1634 + 8208 + 9474 = 19316.
 *
 * Find the sum of all the numbers that can be written as the sum of
 * fifth powers of their digits.
 *
 * 443839
 *)

structure Pr030 = struct

  (* Handy exponent that doesn't require large numbers. *)
  fun expt (base, power) = let
    fun loop (result, base, power) =
      if power = 0 then result else
        let
          val result =
            if power mod 2 <> 0 then
              result * base
            else
              result
          val base = base * base
        in
          loop (result, base, power div 2)
        end
  in
    loop (1, base, power)
  end

  (* Return the sum of the digits each raised to power. *)
  fun digitPowerSum (number, power) =
  let
    fun loop (number, sum) =
      if number = 0 then sum else
        let
          val n = number div 10
          val m = number mod 10
        in
          loop (n, sum + expt (m, power))
        end
  in
    loop (number, 0)
  end

  (* What is the largest number this power could possibly be? *)
  fun largestNumber power = let
    fun loop num = let
      val sum = digitPowerSum (num, power)
    in
      if num > sum then sum
      else loop (num * 10 + 9)
    end
  in
    loop 9
  end

  (* Count the summables in the given power. *)
  fun countSummable power = let
    val stop = largestNumber power
    fun loop (i, sum) =
      if i > stop then sum
      else
        if digitPowerSum (i, power) = i then
          loop (i + 1, sum + i)
        else
          loop (i + 1, sum)
  in
    loop (2, 0)
  end

  fun solve () = countSummable 5

end
