(*
 * Problem 33
 *
 * 20 December 2002
 *
 *
 * The fraction ^49/[98] is a curious fraction, as an inexperienced
 * mathematician in attempting to simplify it may incorrectly believe
 * that ^49/[98] = ^4/[8], which is correct, is obtained by cancelling
 * the 9s.
 *
 * We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
 * examples.
 *
 * There are exactly four non-trivial examples of this type of
 * fraction, less than one in value, and containing two digits in the
 * numerator and denominator.
 *
 * If the product of these four fractions is given in its lowest common
 * terms, find the value of the denominator.
 *
 * 100
 *)

open Core

let is_frac a b =
  let an = a / 10 in
  let am = a mod 10 in
  let bn = b / 10 in
  let bm = b mod 10 in
  (an = bm && bn > 0 && am*b = bn*a) ||
    (am = bn && bm > 0 && an*b = bm*a)

let euler33 () =
  let prod = ref Num.(num_of_int 1) in
  for a = 10 to 99 do
    for b = a+1 to 99 do
      if is_frac a b then
        let open! Num in
	prod := !prod */ (num_of_int a // num_of_int b)
    done
  done;
  Big_int.int_of_big_int (Ratio.denominator_ratio Num.(ratio_of_num !prod))

let run () = printf "%d\n" (euler33 ())
