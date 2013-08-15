(*
 * Problem 32
 *
 * 06 December 2002
 *
 *
 * We shall say that an n-digit number is pandigital if it makes use of
 * all the digits 1 to n exactly once; for example, the 5-digit number,
 * 15234, is 1 through 5 pandigital.
 *
 * The product 7254 is unusual, as the identity, 39 x 186 = 7254,
 * containing multiplicand, multiplier, and product is 1 through 9
 * pandigital.
 *
 * Find the sum of all products whose multiplicand/multiplier/product
 * identity can be written as a 1 through 9 pandigital.
 *
 * HINT: Some products can be obtained in more than one way so be sure
 * to only include it once in your sum.
 *
 * 45228
 *)

structure Pr032 = struct

  structure Set = IntBinarySet

  fun getNum (str, pos, len) =
    case Int.fromString (substring (str, pos, len)) of
         SOME n => n
       | NONE   => raise Fail "Invalid number"

  fun isSum text =
  let
    val aa = getNum (text, 0, 2)
    val bb = getNum (text, 2, 3)
    val cc = getNum (text, 5, 4)
    val a2 = getNum (text, 0, 1)
    val b2 = getNum (text, 1, 4)
  in
    if aa * bb = cc orelse a2 * b2 = cc then
      SOME cc
    else
      NONE
  end

  fun solve () =
  let
    val result = ref Set.empty
    fun act text =
      case isSum text of
           NONE   => ()
         | SOME x =>
             result := Set.add (!result, x)
  in
    StringPermuter.forall act "123456789";
    Set.foldl (op +) 0 (!result)
  end

end
