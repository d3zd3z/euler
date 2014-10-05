(* Invoke the project euler problems. *)

open! Batteries
open Printf

let problems = Problems.problems

module IntMap = Map.Make(struct
  type t = int
  let compare = compare
end)

let run (num, thunk) =
  printf "%d: " num;
  flush stdout;
  thunk ()

let run_all problems =
  List.iter (fun prob -> run prob) problems

let lookup_problems problems =
  let m = IntMap.of_enum (List.enum problems) in
  fun probname ->
    let pnum = int_of_string probname in
    (pnum, IntMap.find pnum m)

let () =
  let args = Array.to_list (Sys.argv) in
  match args with
      [_; "all"] -> run_all problems
    | [_] -> failwith "Usage: ./euler all  or ./euler 2 5"
    | _ :: probs ->
      let lookup = lookup_problems problems in
      run_all (List.map lookup probs)
    | [] -> failwith "Not reached"
