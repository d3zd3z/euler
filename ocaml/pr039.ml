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

open! Core.Std

let all_triples limit =
  let result = ref Int.Map.empty in
  let add _triple p =
    result := Int.Map.change !result p (function
      | None -> Some 1
      | Some x -> Some (x + 1)) in
  Triangle.generate_triples limit add;
  !result

let run () =
  let triples = all_triples 1000 in
  let update ~key ~data (largest_p, largest_count) =
    let p = key in
    let count = data in
    if count > largest_count
    then (p, count)
    else (largest_p, largest_count) in
  let (largest, _count) = Int.Map.fold triples ~init:(0, 0) ~f:update in
  printf "%d\n" largest
