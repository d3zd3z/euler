(*
 * Problem 43
 *
 * 09 May 2003
 *
 *
 * The number, 1406357289, is a 0 to 9 pandigital number because it is
 * made up of each of the digits 0 to 9 in some order, but it also has
 * a rather interesting sub-string divisibility property.
 *
 * Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In
 * this way, we note the following:
 *
 *   • d[2]d[3]d[4]=406 is divisible by 2
 *   • d[3]d[4]d[5]=063 is divisible by 3
 *   • d[4]d[5]d[6]=635 is divisible by 5
 *   • d[5]d[6]d[7]=357 is divisible by 7
 *   • d[6]d[7]d[8]=572 is divisible by 11
 *   • d[7]d[8]d[9]=728 is divisible by 13
 *   • d[8]d[9]d[10]=289 is divisible by 17
 *
 * Find the sum of all 0 to 9 pandigital numbers with this property.
 *
 * 16695334890
 *)

open Core

let low_primes = [ 2; 3; 5; 7; 11; 13; 17 ]

let valid digits =
  let rec loop offset primes =
    match primes with
	[] -> true
      | (p::ps) ->
	let num = int_of_string (Bytes.To_string.sub digits ~pos:offset ~len:3) in
	if num mod p = 0 then
	  loop (offset + 1) ps
	else
	  false in
  loop 1 low_primes

let run () =
  let base = Bytes.of_string "0123456789" in
  let next s =
    let s' = Bytes.copy s in
    try Some (s, (Misc.bytes_next_permutation s'))
    with Misc.Last_permutation -> None in
  let numbers = Sequence.unfold ~init:base ~f:next in
  let nifty = Sequence.filteri numbers ~f:(fun _ x -> valid x) in
  let nifty = Sequence.map nifty ~f:(fun x -> Int64.of_string (Bytes.to_string x)) in
  let result = Sequence.sum (module Int64) nifty ~f:ident in
  printf "%Ld\n" result
