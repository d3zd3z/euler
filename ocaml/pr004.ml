(**********************************************************************
 * Problem 4
 *
 * 16 November 2001
 *
 *
 * A palindromic number reads the same both ways. The largest
 * palindrome made from the product of two 2-digit numbers is 9009 = 91
 * × 99.
 *
 * Find the largest palindrome made from the product of two 3-digit
 * numbers.
 *
 **********************************************************************)

let reverse_digits number =
  let rec loop number result =
    if number > 0 then
      loop (number / 10) (result * 10 + (number mod 10))
    else
      result in
  loop number 0

let is_palindrome number =
  number = reverse_digits number

let euler_4 () =
  let rec outer biggest a =
    if a > 999 then biggest else begin
      let b = let rec inner biggest b =
		if b > 999 then biggest
		else if is_palindrome (a * b) then
		  inner (max (a * b) biggest) (b + 1)
		else
		  inner biggest (b + 1) in
	      inner biggest a in
      outer b (a + 1)
    end in
  outer 0 100
let run () = Printf.printf "%d\n" (euler_4 ())
