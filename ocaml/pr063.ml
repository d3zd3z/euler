(*
 * The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the
 * 9-digit number, 134217728=8^9, is a ninth power.
 *
 * How many n-digit positive integers exist which are also an nth
 * power?
 *
 * Answer: 49
 *)

open Core

(*
 * A couple of things to note that will make all of this easier.  The
 * solutions will all be of the form 10^(n-1) <= x^n < 10^n.  x will
 * always be < 10 (somewhat obviously).
 *)

(* 
 * From a given 'x', return how many of the powers of that number have
 * that power digits.  In other words, how many of x^n have exactly n
 * digits.  For a given single digit number, x^1 will always have one
 * digit, sufficiently large numbers will have x^2, and so on.  So, it
 * is sufficient to just count the number of numbers where the problem
 * definition is true.
 *
 * At this point, some simple algebra could give us the solution, but
 * since this is a programming challenge, lets at least implement
 * this.  We definitely need big numbers.
 *
 * As this is newer code, it will use zarith instead of num.
 *
 * The easiest, and likely fastest way to determine the length of a Z
 * number is to convert it to a string, and measure the length of the
 * string.
 *)

(* For a give number 'x', determine the largest power 'n' that
 * produces a 'n'-digit number. *)
let scan x =
  let x = Z.of_int x in
  let rec loop n =
    let res = Z.(x ** n) in
    let digits = String.length (Z.to_string res) in
    if n > digits then n - 1
    else loop (n + 1) in
  loop 1

let solve () =
  List.init 9 ~f:succ
  |> List.map ~f:scan
  |> List.fold ~init:0 ~f:(+)

let run () =
  printf "%d\n" (solve ())
