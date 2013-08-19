(*
 * Problem 42
 *
 * 25 April 2003
 *
 *
 * The n^th term of the sequence of triangle numbers is given by, t[n]
 * = 1/2n(n+1); so the first ten triangle numbers are:
 *
 * 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
 *
 * By converting each letter in a word to a number corresponding to its
 * alphabetical position and adding these values we form a word value.
 * For example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If
 * the word value is a triangle number then we shall call the word a
 * triangle word.
 *
 * Using words.txt (right click and 'Save Link/Target As...'), a 16K
 * text file containing nearly two-thousand common English words, how
 * many are triangle words?
 *
 * 162
 *)

structure Pr042 =
struct

  fun isTriangle number =
    let
      val square = 1 + number * 8
      val root = Misc.isqrt square
    in
      root * root = square
    end

  fun solve () =
    let
      val words = Misc.readWords "../haskell/words.txt"
      val twords = List.filter (fn w => isTriangle (Misc.nameValue w)) words
    in
      List.length twords
    end

end
