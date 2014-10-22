(*
 * Problem 32
 *
 * 06 December 2002
 *
 *
 * We shall say that an n-digit number is pandigital if it makes use of
 * all the digits 1 to n exactly once; for example, the 5-digit number,
 * 15234, is 1 through 5 pandigital.
 *
 * The product 7254 is unusual, as the identity, 39 × 186 = 7254,
 * containing multiplicand, multiplier, and product is 1 through 9
 * pandigital.
 *
 * Find the sum of all products whose multiplicand/multiplier/product
 * identity can be written as a 1 through 9 pandigital.
 *
 * HINT: Some products can be obtained in more than one way so be sure
 * to only include it once in your sum.
 *
 * 45228
 *)

open! Core.Std

(* Return all groupings (as a list) that can be built out of this
   group of digits. *)
let make_groupings digits =
  let len = String.length digits in
  let result = ref [] in
  for i = 1 to len-3 do
    for j = i+1 to len-1 do
      let piece a b = int_of_string (String.sub digits ~pos:a ~len:(b-a)) in
      let a = piece 0 i in
      let b = piece i j in
      let c = piece j len in
      if a*b = c then
	result := c :: !result
    done
  done;
  !result

let euler32 () =
  let products = ref [] in
  let rec loop text =
    products := (make_groupings text) :: !products;
    loop (Misc.bytes_next_permutation text) in
  (try loop (String.copy "123456789")
   with Not_found -> ());
  List.sum (module Int) ~f:ident (List.dedup ~compare:Int.compare (List.concat !products))

let run () = printf "%d\n" (euler32 ())
