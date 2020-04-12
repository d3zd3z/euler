(* Simple benchmarks. *)

let repeat thunk n =
  let start = Unix.gettimeofday () in
  for _ = 1 to n do
    thunk ()
  done;
  (Unix.gettimeofday ()) -. start

let bench thunk =
  let rec loop count =
    let time = repeat thunk count in
    if time < 1.0 then loop (count*2)
    else (float_of_int count) /. time in
  let time = loop 1 in
  Printf.printf "%.3f ops/sec\n%!" time
