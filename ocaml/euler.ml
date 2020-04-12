(* Invoke the project euler problems. *)

open! Core

let problems = Problems.problems

let run (num, thunk) =
  printf "%d: %!" num;
  thunk ()

let run_all problems =
  List.iter ~f:(fun prob -> run prob) problems

let lookup_problems problems =
  let m = Int.Map.of_alist_exn problems in
  fun probname ->
    let pnum = int_of_string probname in
    (pnum, Int.Map.find_exn m pnum)

let () =
  let args = Array.to_list (Sys.get_argv ()) in
  match args with
      [_; "all"] -> run_all problems
    | [_] -> failwith "Usage: ./euler all  or ./euler 2 5"
    | _ :: probs ->
      let lookup = lookup_problems problems in
      run_all (List.map probs ~f:lookup)
    | [] -> failwith "Not reached"
