(* Triangle utilities. *)

open Batteries

type box = { p1 : int; p2 : int; q1 : int; q2 : int }

let make_box p1 p2 q1 q2 = { p1; p2; q1; q2 }

let initial_box = make_box 1 1 2 3

let children box =
  let x = box.p2 in
  let y = box.q2 in
  [ make_box (y-x) x y     (y*2 - x);
    make_box x     y (x+y) (x*2 + y);
    make_box y     x (y+x) (y*2 + x) ]

type triple = { a : int; b : int; c : int }
type t = triple

let compare = compare

let circumference triangle = triangle.a + triangle.b + triangle.c

(* Return the three sides of the pythagorean triple described by the
   given box. *)
let box_triangle box =
  { a = box.q1 * box.p1 * 2;
    b = box.q2 * box.p2;
    c = box.p1 * box.q2 + box.p2 * box.q1 }

let multiply_triple tri k =
  { a = tri.a * k; b = tri.b * k; c = tri.c * k }

(* Generate all of the primitive Pythagorean triples with a
   circumference <= limit.  Calls 'act triple circumference' for each
   possible triple. *)
let generate_fibonacci_triples limit act =
  let rec loop work = match work with
      [] -> ()
    | (box :: nextWork) ->
      let triple = box_triangle box in
      let size = circumference triple in
      if size <= limit then begin
	act triple size;
	loop (nextWork @ children box)
      end in
  loop [initial_box]

let generate_triples limit act =
  let sub_generate triple _size =
    let rec loop k =
      let k_triple = multiply_triple triple k in
      let k_size = circumference k_triple in
      if k_size <= limit then begin
	act k_triple k_size;
	loop (k + 1)
      end in
    loop 1 in
  generate_fibonacci_triples limit sub_generate
