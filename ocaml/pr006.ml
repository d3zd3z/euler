(**********************************************************************
 * Problem 6
 *
 * 14 December 2001
 *
 *
 * The sum of the squares of the first ten natural numbers is,
 *
 * 1^2 + 2^2 + ... + 10^2 = 385
 *
 * The square of the sum of the first ten natural numbers is,
 *
 * (1 + 2 + ... + 10)^2 = 55^2 = 3025
 *
 * Hence the difference between the sum of the squares of the first ten
 * natural numbers and the square of the sum is 3025 − 385 = 2640.
 *
 * Find the difference between the sum of the squares of the first one
 * hundred natural numbers and the square of the sum.
 *
 * 25164150
 **********************************************************************)

open! Core.Std

let solve' count =
  let nums = List.init count ~f:(fun x -> x + 1) in
  let sumsq = List.fold ~f:(+) ~init:0 nums in
  let sumsq = sumsq * sumsq in
  let sq = List.map ~f:(fun x -> x * x) nums in
  let sq = List.fold ~f:(+) ~init:0 sq in
  sumsq - sq

let solve () = solve' 100

let run () = printf "%d\n" (solve ())
