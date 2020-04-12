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

open Core

let expt base power =
  let rec loop result base power =
    if power = 0 then result else begin
      let result = if (power land 1) <> 0
	then result * base else result in
      let base = base * base in
      loop result base (power lsr 1)
    end in
  loop 1 base power

(* Return the sum of the digits each raised to power. *)
let digit_power_sum number power =
  let rec loop number sum =
    if number = 0 then sum
    else begin
      let n = number / 10 in
      let m = number mod 10 in
      loop n (sum + expt m power)
    end in
  loop number 0

(* Calculate the largest number this power could possibly be. *)
let largest_number power =
  let rec loop num =
    let sum = digit_power_sum num power in
    if num > sum then sum
    else loop (num * 10 + 9) in
  loop 9

let count_summable power =
  let sum = ref 0 in
  for i = 2 to largest_number power do
    if digit_power_sum i power = i then
      sum := !sum + i
  done;
  !sum

let euler30 () =
  count_summable 5

let run () = printf "%d\n" (euler30 ())
