(*
 * Triangle, square, pentagonal, hexagonal, heptagonal, and octagonal
 * numbers are all figurate (polygonal) numbers and are generated by
 * the following formulae:
 * Triangle             P3,n=n(n+1)/2           1, 3, 6, 10, 15, ...
 * Square               P4,n=n2                 1, 4, 9, 16, 25, ...
 * Pentagonal           P5,n=n(3n−1)/2          1, 5, 12, 22, 35, ...
 * Hexagonal            P6,n=n(2n−1)            1, 6, 15, 28, 45, ...
 * Heptagonal           P7,n=n(5n−3)/2          1, 7, 18, 34, 55, ...
 * Octagonal            P8,n=n(3n−2)            1, 8, 21, 40, 65, ...
 *
 * The ordered set of three 4-digit numbers: 8128, 2882, 8281, has
 * three interesting properties.
 *
 * 1. The set is cyclic, in that the last two digits of each number
 *    is the first two digits of the next number (including the last
 *    number with the first).
 * 2. Each polygonal type: triangle (P3,127=8128), square
 *    (P4,91=8281), and pentagonal (P5,44=2882), is represented
 *    by a different number in the set.
 * 3. This is the only set of 4-digit numbers with this
 *    property.
 *
 * Find the sum of the only ordered set of six cyclic 4-digit numbers
 * for which each polygonal type: triangle, square, pentagonal,
 * hexagonal, heptagonal, and octagonal, is represented by a
 * different number in the set.
 *
 * 28684
 *)

open Core

type p = int array array [@@deriving show]
type ia = int array [@@deriving show]

let generators = [
  (fun n -> n * (n + 1) / 2);
  (fun n -> n * n);
  (fun n -> n * (3*n - 1) / 2);
  (fun n -> n * (2*n - 1));
  (fun n -> n * (5*n - 3) / 2);
  (fun n -> n * (3*n - 2)) ]

(* Given a function that takes integers starting from 1, and produces
 * increasing values, return all of the values that are 4 digit
 * numbers. *)
let generate f =
  let rec loop accum n =
    let v = f n in
    if v < 10_000 then
      loop (v::accum) (n + 1)
    else accum in
  let nums = loop [] 1 in
  List.rev_filter nums ~f:(fun x -> x >= 1000)
  |> Array.of_list

(* With two arrays as args, return a new array which is a subset of
 * the first, which eliminates any elements that can't "reach" an
 * element of the second array. *)
let reduce aa bb =
  (* This copy of bb, already divided, makes the number of division
   * linear to aa rather than the product. *)
  let bb = Array.map bb ~f:(fun belt -> belt / 100) in
  Array.filter aa ~f:(fun aelt ->
    let div = aelt mod 100 in
    Array.exists bb ~f:(fun belt -> div = belt))

(* Reduce in the other direction.  This returns a copy of the elements
 * of bb that can be reached by some element of aa. *)
let revreduce aa bb =
  let aa = Array.map aa ~f:(fun aelt -> aelt mod 100) in
  Array.filter bb ~f:(fun belt ->
    let div = belt / 100 in
    Array.exists aa ~f:(fun aelt -> div = aelt))

(* A full reduction runs the reduction cycled through all of the
 * values, until all of the sets either contain a single value, or
 * one of them becomes empty. *)
let full_reduce ary =
  let size = Array.length ary in
  let rec loop pos ones =
    if ones = size then `Solved
    else begin
      let pos2 = (pos + 1) mod size in
      (* if pos = 0 then
        printf "%s\n%!" (show_p ary); *)
      let newelt = reduce ary.(pos) ary.(pos2) in
      ary.(pos) <- newelt;
      let newbb = revreduce ary.(pos) ary.(pos2) in
      ary.(pos2) <- newbb;
      match Array.length newelt with
        | 0 -> `No_solution
        | 1 -> loop pos2 (ones+1)
        | _ -> loop pos2 0
    end in
  loop 0 0

(* Build the problem array. *)
let get_probs () =
  List.map generators ~f:(fun f -> generate f)
  |> Array.of_list

module Int_array : Misc.VEC with type elt = int and type t = int array = struct
  type t = int array
  type elt = int
  let length = Array.length
  let get = Array.get
  let set = Array.set
end

module Int_permuter = Misc.Make_permuter (Int_array) (Int)

(* Build a new problem solution attempt from probs, the original data,
 * and perm a permutation array. *)
let build_trial perm prob =
  Array.map perm ~f:(fun x -> prob.(x))

let extract_solution sol =
  Array.map sol ~f:(function
    | [|x|] -> x
    | _ -> failwith "Expecting only a single element")

let solve () =
  let prob = get_probs () in
  let perm = Array.init (Array.length prob) ~f:Fun.id in
  let rec loop () =
    let pprob = build_trial perm prob in
    (* printf "trying: %s\n%!" (show_ia perm); *)
    match full_reduce pprob with
      | `Solved ->
          (* printf "Solved\n%s\n" (show_p pprob); *)
          extract_solution pprob
      | `No_solution ->
          ignore (Int_permuter.next_permutation perm);
          loop ()
  in loop ()

let run () =
  let ary = solve () in
  printf "%d\n" (Array.fold ary ~init:0 ~f:(+))
