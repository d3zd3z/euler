(*
 * Problem 37
 *
 * 14 February 2003
 *
 *
 * The number 3797 has an interesting property. Being prime itself, it
 * is possible to continuously remove digits from left to right, and
 * remain prime at each stage: 3797, 797, 97, and 7. Similarly we can
 * work from right to left: 3797, 379, 37, and 3.
 *
 * Find the sum of the only eleven primes that are both truncatable
 * from left to right and right to left.
 *
 * NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
 *)

open! Batteries
open Printf

(*
module P = Sieve.Int64Factory

(* This prime function takes way too long.  Need to implement MR or
   something like that.  (This program is taking about 21 minutes) *)
let is_prime x = P.is_prime (Int64.of_int x)
*)
let is_prime = Misc.MillerRabin.is_prime_int

(* Given the list of numbers, return a list of numbers that are prime
   when a single digit is appended to the right. *)
let add_primes numbers =
  let result = ref [] in
  List.iter (fun number ->
    List.iter (fun extra ->
      let n = number * 10 + extra in
      if is_prime n then
	result := n :: !result
    ) [1; 3; 7; 9]
  ) numbers;
  !result

(* Generate a list of all right-truncatable primes. *)
let right_truncatable_primes () =
  let rec loop set result =
    (* printf "%s\n%!" (Show.show<int list> set); *)
    if set = [] then result else begin
      loop (add_primes set) (List.append set result)
    end in
  loop [2; 3; 5; 7] []

(* Is this number left truncatable? *)
let is_left_truncatable number =
  let rec loop number =
    if number = 0 then true
    else if number > 1 && is_prime number then
      loop (Misc.reverse_number (Misc.reverse_number number / 10))
    else false in
  loop number

let euler37 () =
  List.sum (List.filter (fun x -> x > 9 && is_left_truncatable x)
	      (right_truncatable_primes ()))

let run () = printf "%d\n" (euler37 ())
