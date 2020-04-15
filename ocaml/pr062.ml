(*
 * The cube, 41063625 (3453), can be permuted to produce two other
 * cubes: 56623104 (3843) and 66430125 (4053). In fact, 41063625 is
 * the smallest cube which has exactly three permutations of its
 * digits which are also cube.
 *
 * Find the smallest cube for which exactly five permutations of its
 * digits are cube.
 *
 * Answer: 127035954683
 *)

open Core

(* Given a number n, gather the digits, sort them, and then turn them
 * back into a number.  The result is an int64, because the working
 * value may overflow a 31 bit integer on 32-bit platforms. *)
let identity n =
  let digits =
    let rec loop result = function
      | n when Int64.(n > 0L) ->
          loop (Int64.to_int_exn Int64.(n % 10L) :: result) Int64.(n / 10L)
      | _ -> result in
    loop [] n in
  (* Sort in reverse so that the 0 values don't get dropped. *)
  let digits = List.sort digits ~compare:(Comparable.reverse Int.compare) in
  let num = List.fold digits ~init:0L ~f:(fun n x -> Int64.(n * 10L + Int64.of_int x)) in
  num

module IM = Map.Make (Int64)

(* The not-necessarily obvious consequence of the wording of the
 * question is that we need to always consider all of the numbers of a
 * given number of digits before we can look for those that have 5
 * permutations that are cubes.  We do this with nested loops, with
 * the outer loop being a stopping point.  Instead of trying to keep
 * state between, just run the inner loop afresh. *)
let solve () =
  (* Outloop number of digits to try for the result. *)
  let rec oloop stop =
    let rec loop mm n =
      let n64 = Int64.of_int n in
      let n3 = Int64.(n64 * n64 * n64) in
      let key = identity n3 in
      let mm = IM.change mm key ~f:(fun data ->
        let data = Option.value data ~default:[] in
        Some (n3 :: data)) in
      if Int64.(n3 < stop) then
        loop mm (n+1)
      else mm
    in
    let mm = loop IM.empty 1 in
    let mm = IM.filter mm ~f:(fun l -> List.length l = 5) in
    if IM.is_empty mm then oloop Int64.(stop * 10L)
    else mm
  in
  let mm = oloop 1000L in
  let nums = List.concat (IM.data mm) in
  Option.value_exn (List.min_elt nums ~compare:Int64.compare)

let run () =
  printf "%Ld\n" (solve ())
