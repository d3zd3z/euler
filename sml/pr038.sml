(*
 * Problem 38
 *
 * 28 February 2003
 *
 *
 * Take the number 192 and multiply it by each of 1, 2, and 3:
 *
 *     192 x 1 = 192
 *     192 x 2 = 384
 *     192 x 3 = 576
 *
 * By concatenating each product we get the 1 to 9 pandigital,
 * 192384576. We will call 192384576 the concatenated product of 192
 * and (1,2,3)
 *
 * The same can be achieved by starting with 9 and multiplying by 1, 2,
 * 3, 4, and 5, giving the pandigital, 918273645, which is the
 * concatenated product of 9 and (1,2,3,4,5).
 *
 * What is the largest 1 to 9 pandigital 9-digit number that can be
 * formed as the concatenated product of an integer with (1,2, ... , n)
 * where n > 1?
 *
 * 932718654
 *)

structure Pr038 =
struct

  (* Is this number a full 9-element pandigital number.  Uses a bit-mask to
   * track the digits seen. *)
  fun isPandigital number =
    let
      fun loop (bits, 0) = bits = 0w1022 (* 1-9 without the zero *)
        | loop (bits, number) =
            let
              val n = number div 10
              val m = number mod 10
              val bit = Word.<< (0w1, Word.fromInt m)
            in
              if Word.andb (bits, bit) = 0w0 then
                loop (Word.orb (bits, bit), n)
              else false
            end
    in
      loop (0w0, number)
    end

  (* Given a numeric base, return a resulting number by successively
   * multiplying by the integers starting with 1. *)
  local
    val ten = IntInf.fromInt 10
  in
    fun largeSum base =
      let
        val base = IntInf.fromInt base
        fun loop (digits, result, i) =
          if digits >= 9 then result else
            let
              val piece = base * i
              val pieceDigits = IntInf.fromInt (Misc.largeNumberOfDigits piece)
            in
              loop (digits + pieceDigits,
                    result * Misc.largeExpt (ten, pieceDigits + piece),
                    i+1)
            end
      in
        loop (0, IntInf.fromInt 0, 1)
      end
  end

  fun solve () = 42

end
