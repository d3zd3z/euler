/**********************************************************************
 * Problem 14
 *
 * 05 April 2002
 *
 *
 * The following iterative sequence is defined for the set of positive
 * integers:
 *
 * n → n/2 (n is even)
 * n → 3n + 1 (n is odd)
 *
 * Using the rule above and starting with 13, we generate the following
 * sequence:
 *
 * 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
 *
 * It can be seen that this sequence (starting at 13 and finishing at
 * 1) contains 10 terms. Although it has not been proved yet (Collatz
 * Problem), it is thought that all starting numbers finish at 1.
 *
 * Which starting number, under one million, produces the longest
 * chain?
 *
 * NOTE: Once the chain starts the terms are allowed to go above one
 * million.
 **********************************************************************/

import std.stdio;

void main() {
    uint largestLen = 0;
    uint largest = 0;
    foreach (i; 1 .. 1_000_000) {
	auto len = chainLen(i);
	if (len > largestLen) {
	    largestLen = len;
	    largest = i;
	}
    }
    writeln(largest);
}

uint chainLen(uint num) {
    if (num == 1) return 1;
    else if (num % 2 == 0)
	return 1 + chainLen(num/2);
    else
	return 1 + chainLen(3*num + 1);
}

// TODO: Use more advanced caches, but use templates to do it efficiently.

/+
open Batteries_uni
open Printf

let even n = (n land 1) = 0

module type CHAIN = sig
  val chain_len : int -> int
end

module Brute_force : CHAIN = struct
  let rec chain_len = function
    | 1 -> 1
    | n when even n -> 1 + chain_len (n / 2)
    | n -> 1 + chain_len (3*n + 1)
end

(* Search a given solution. *)
let search chain_len =
  let largest_len = ref 0 in
  let largest = ref 0 in
  for i = 1 to 999_999 do
    let len = chain_len i in
    if len > !largest_len then begin
      largest_len := len;
      largest := i
    end
  done;
  !largest

(* Even this simple case, in byte code, is only 6.3 seconds, and is
   just over 1 second when byte_coded.  However, as a comparison,
   let's try some other solutions. *)

(* We can use a map to cache the results (note that this is slower) *)
module Map_cache : CHAIN = struct
  module IM = Map.IntMap
  let known = ref IM.empty
  let rec chain_len = function
    | 1 -> 1
    | n ->
	try IM.find n !known
	with Not_found ->
	  let answer = if even n then chain_len (n/2)
	    else chain_len (3*n + 1) in
	  known := IM.add n answer !known;
	  answer
end

(* With a bit of carefulness, we can cache only some solutions and get
   a little bit faster.  It has to be cached in an array to keep it
   from being slower. *)
module type SIZED = sig
  val size : int
end
module Make_array_cache(Sized : SIZED) : CHAIN = struct
  let small_known = Array.make Sized.size None
  let rec chain_len = function
    | 1 -> 1
    | n ->
	if n < Sized.size then begin
	  match small_known.(n) with
	    | None ->
		let answer = chain n in
		small_known.(n) <- Some answer;
		answer
	    | Some answer -> answer
	end else chain n
  and chain = function
    | 1 -> 1
    | n when even n -> 1 + chain_len (n/2)
    | n -> 1 + chain_len (3*n + 1)
end

module Array_cache3 = Make_array_cache(struct let size = 1000 end)
module Array_cache7 = Make_array_cache(struct let size = 100000 end)


let () = printf "%d\n" (search Array_cache7.chain_len)
+/
