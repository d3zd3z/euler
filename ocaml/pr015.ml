(**********************************************************************
 * Problem 15
 *
 * 19 April 2002
 *
 *
 * Starting in the top left corner of a 2×2 grid, there are 6 routes
 * (without backtracking) to the bottom right corner.
 *
 * [p_015]
 *
 * How many routes are there through a 20×20 grid?
 **********************************************************************)

open! Batteries
open Printf

(* Answer needs to be in an int64 so that the result fits. *)

let (++) = Int64.add

(* An imperative solution. *)
let base n = Array.make (n+1) 1L

let bump vec =
  for i = 0 to Array.length vec - 2 do
    vec.(i+1) <- vec.(i) ++ vec.(i+1)
  done

let routes n =
  let vec = base n in
  for _i = 1 to n do
    bump vec
  done;
  vec.(n)

(* A functional solution. *)
module Func = struct
  let base n = List.of_enum (Enum.repeat ~times:(n+1) 1L)

  let rec reduce = function
    | [a] -> [a]
    | (a::b::rest) ->
	let sum = a ++ b in
	a :: reduce (sum :: rest)
    | [] -> failwith "Empty"

  (* This seems to be slightly slower. *)
  let reduce' elts =
    let rec loop result = function
      | [a] -> List.rev (a :: result)
      | (a::b::rest) ->
	  let sum = a ++ b in
	  loop (a :: result) (sum :: rest)
      | [] -> failwith "Empty" in
    loop [] elts

  let routes n =
    let rec loop x count =
      if count = n then List.last x
      else loop (reduce x) (count + 1) in
    loop (base n) 0
end

let euler15 () = routes 20
(* let () = printf "%Ld\n" (euler15 ())
let () = printf "%Ld\n" (Func.routes 20)

let () = Bench.bench (fun () -> let _ = routes 20 in ())
let () = Bench.bench (fun () -> let _ = Func.routes 20 in ()) *)
let run () = printf "%Ld\n" (Func.routes 20)
