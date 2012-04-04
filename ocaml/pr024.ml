(*
 * Problem 24
 *
 * 16 August 2002
 *
 *
 * A permutation is an ordered arrangement of objects. For example,
 * 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all
 * of the permutations are listed numerically or alphabetically, we
 * call it lexicographic order. The lexicographic permutations of 0, 1
 * and 2 are:
 *
 * 012   021   102   120   201   210
 *
 * What is the millionth lexicographic permutation of the digits 0, 1,
 * 2, 3, 4, 5, 6, 7, 8 and 9?
 *)

open Printf

let swap text a b =
  let tmp = text.[a] in
  text.[a] <- text.[b];
  text.[b] <- tmp

let reverse_substring text a b =
  let rec loop a b =
    if a < b then begin
      swap text a b;
      loop (a+1) (b-1)
    end in
  loop a b

(* Modify the string, in place, to generate the next lexical
   permutation. *)
let next_permutation text =
  let len = String.length text in
  let k = ref (-1) in
  for x = 0 to len-2 do
    if text.[x] < text.[x+1] then
      k := x
  done;
  if !k < 0 then raise Not_found;
  let l = ref (-1) in
  for x = !k+1 to len-1 do
    if text.[!k] < text.[x] then
      l := x
  done;
  swap text !k !l;
  reverse_substring text (!k+1) (len-1);
  text

let euler24 () =
  let rec loop text count =
    if count = 1_000_000 then text
    else loop (next_permutation text) (count+1) in
  loop (String.copy "0123456789") 1

let () = printf "%s\n" (euler24 ())
