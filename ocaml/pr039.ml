(*
 * Problem 39
 *
 * 14 March 2003
 *
 *
 * If p is the perimeter of a right angle triangle with integral length
 * sides, {a,b,c}, there are exactly three solutions for p = 120.
 *
 * {20,48,52}, {24,45,51}, {30,40,50}
 *
 * For which value of p ≤ 1000, is the number of solutions maximised?
 *
 * 840
 *)

open Batteries
open Printf

module IntMap = Map.Make(Int)

let all_triples limit =
  let result = ref IntMap.empty in
  let add _triple p =
    result := IntMap.modify_def 0 p (fun x -> x + 1) !result in
  Triangle.generate_triples limit add;
  !result

let run () =
  let triples = all_triples 1000 in
  let update p count (largest_p, largest_count) =
    if count > largest_count
    then (p, count)
    else (largest_p, largest_count) in
  let (largest, _count) = IntMap.fold update triples (0, 0) in
  printf "%d\n" largest
