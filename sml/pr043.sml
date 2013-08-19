(*
 * Problem 43
 *
 * 09 May 2003
 *
 *
 * The number, 1406357289, is a 0 to 9 pandigital number because it is
 * made up of each of the digits 0 to 9 in some order, but it also has
 * a rather interesting sub-string divisibility property.
 *
 * Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In
 * this way, we note the following:
 *
 *   • d[2]d[3]d[4]=406 is divisible by 2
 *   • d[3]d[4]d[5]=063 is divisible by 3
 *   • d[4]d[5]d[6]=635 is divisible by 5
 *   • d[5]d[6]d[7]=357 is divisible by 7
 *   • d[6]d[7]d[8]=572 is divisible by 11
 *   • d[7]d[8]d[9]=728 is divisible by 13
 *   • d[8]d[9]d[10]=289 is divisible by 17
 *
 * Find the sum of all 0 to 9 pandigital numbers with this property.
 *
 * 16695334890
 *)

structure Pr043 =
struct

  val lowPrimes = [2, 3, 5, 7, 11, 13, 17]

  fun allDivides text =
    let
      fun loop (_, []) = true
        | loop (pos, (p::ps)) =
            let
              val piece = substring (text, pos, 3)
              val n =
                case Int.fromString piece of
                     NONE => raise Fail "Invalid digits"
                   | SOME n => n
            in
              n mod p = 0 andalso loop (pos+1, ps)
            end
    in
      loop (1, lowPrimes)
    end

  (* SMLNJ 110.75 seems to have a broken Int64.fromString, in that it only works
   * for 32-bit values.  To work around this, use IntInf instead.  Slower, but
   * we're only adding 6 numbers. *)
  structure I64 = IntInf

  fun get64 text =
    case I64.fromString text of
         NONE => raise Fail "Invalid number"
       | SOME n => n

  fun solve () =
    let
      val count = ref (I64.fromInt 0)
      fun check text =
        if allDivides text then
          count := !count + get64 text
        else ()
    in
      StringPermuter.forall check "0123456789";
      !count
    end

end
