(*
 * Problem 17
 *
 * 17 May 2002
 *
 *
 * If the numbers 1 to 5 are written out in words: one, two, three,
 * four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in
 * total.
 *
 * If all the numbers from 1 to 1000 (one thousand) inclusive were
 * written out in words, how many letters would be used?
 *
 *
 * NOTE: Do not count spaces or hyphens. For example, 342 (three
 * hundred and forty-two) contains 23 letters and 115 (one hundred and
 * fifteen) contains 20 letters. The use of "and" when writing out
 * numbers is in compliance with British usage.
 *
 * 21124
 *)

structure Pr017 =
struct

fun countLetters text =
    let val len = String.size text
	fun check (pos) = if Char.isAlpha (String.sub (text, pos)) then 1 else 0
	fun loop (count, pos) =
	    if pos = len then count
	    else loop (count + check pos, pos + 1)
    in
      loop (0, 0)
    end

fun getName nameList n = Array.sub (nameList, n-1)

val oneNames = Array.fromList [ "one", "two", "three", "four", "five",
				"six", "seven", "eight", "nine",
				"ten", "eleven", "twelve", "thirteen",
				"fourteen", "fifteen", "sixteen",
				"seventeen", "eighteen", "nineteen" ]
val ones = getName oneNames

val tenNames = Array.fromList [ "ten", "twenty", "thirty", "forty",
				"fifty", "sixty", "seventy", "eighty",
				"ninety" ]
val tens = getName tenNames

fun textify n =
    if n > 1000 then
      raise Fail "Number out of range."
    else if n = 1000 then
      "one thousand"
    else if n >= 100 then
      let val num = n mod 100
	  val andText = if num > 0 then "and " else ""
      in
	ones (n div 100) ^ " hundred " ^ andText ^ textify num
      end
    else if n >= 20 then
      let val num = n mod 10
	  val hyphen = if num > 0 then "-" else " "
      in
	tens (n div 10) ^ hyphen ^ textify num
      end
    else if n >= 1 then
      ones n
    else
      ""

fun solve () =
    let fun loop (n, count) =
	    if n > 1000 then count
	    else
	      loop (n+1, count + countLetters (textify n))
    in
      loop (1, 0)
    end

(* val () = print (Int.toString (solve ()) ^ "\n") *)
end
