(*
 * Problem 41
 *
 * 11 April 2003
 *
 *
 * We shall say that an n-digit number is pandigital if it makes use of
 * all the digits 1 to n exactly once. For example, 2143 is a 4-digit
 * pandigital and is also prime.
 *
 * What is the largest n-digit pandigital prime that exists?
 *
 * 7652413
 *)

open Core

let run () =
  let base = Bytes.of_string "1234567" in
  let sieve = Sieve.create () in
  let rec loop perm largest =
    match perm with
	None -> largest
      | Some perm ->
	let num = Int.of_string (Bytes.to_string perm) in
	let next =
	  try Some (Misc.bytes_next_permutation perm)
	  with Misc.Last_permutation -> None in
	if Sieve.is_prime sieve num && num > largest then
	  loop next num
	else
	  loop next largest in
  let result = loop (Some base) 0 in
  printf "%d\n" result
