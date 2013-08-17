(*
 * Problem 36
 *
 * 31 January 2003
 *
 *
 * The decimal number, 585 = 1001001001[2] (binary), is palindromic in
 * both bases.
 *
 * Find the sum of all numbers, less than one million, which are
 * palindromic in base 10 and base 2.
 *
 * (Please note that the palindromic number, in either base, may not
 * include leading zeros.)
 *
 * 872187
 *)

structure Pr036 =
struct

  fun solve () =
    let
      fun loop (1000000, sum) = sum
        | loop (i, sum) =
            if Misc.isPalindrome (i, 10) andalso Misc.isPalindrome (i, 2) then
              loop (i+1, sum+i)
            else
              loop (i+1, sum)
    in
      loop (1, 0)
    end

end
