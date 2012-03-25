(**********************************************************************
 * Problem 5
 *
 * 30 November 2001
 *
 *
 * 2520 is the smallest number that can be divided by each of the
 * numbers from 1 to 10 without any remainder.
 *
 * What is the smallest positive number that is evenly divisible by all
 * of the numbers from 1 to 20?
 **********************************************************************)

module LL = BatLazyList

let rec gcd a b =
  if b = 0 then a
  else gcd b (a mod b)

let lcm a b = (a / gcd a b) * b

let pr5 () =
  let nums = LL.range 2 20 in
  let result = LL.fold_left lcm 1 nums in
  Printf.printf "%d\n" result

let _ = pr5 ()
