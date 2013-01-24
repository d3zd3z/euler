(*
 * Problem 31
 *
 * 22 November 2002
 *
 *
 * In England the currency is made up of pound, £, and pence, p, and
 * there are eight coins in general circulation:
 *
 *     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
 *
 * It is possible to make £2 in the following way:
 *
 *     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
 *
 * How many different ways can £2 be made using any number of coins?
 *)

open Printf

let coins = [200; 100; 50; 20; 10; 5; 2; 1]

(* This function recurses a lot, but it is still plenty fast.  Would
   need to memoize for larger problem spaces. *)

let rec rways remaining = function
  | [] -> if remaining = 0 then 1 else 0
  | (coin::others) ->
      let rec loop sum remaining =
	if remaining >= 0 then loop (sum + rways remaining others) (remaining - coin)
	else sum in
      loop 0 remaining

let euler31 () =
  rways 200 coins

let run () = printf "%d\n" (euler31 ())
