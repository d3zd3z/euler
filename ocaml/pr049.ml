(*
 * Problem 49
 *
 * 01 August 2003
 *
 *
 * The arithmetic sequence, 1487, 4817, 8147, in which each of the
 * terms increases by 3330, is unusual in two ways: (i) each of the
 * three terms are prime, and, (ii) each of the 4-digit numbers are
 * permutations of one another.
 *
 * There are no arithmetic sequences made up of three 1-, 2-, or
 * 3-digit primes, exhibiting this property, but there is one other
 * 4-digit increasing sequence.
 *
 * What 12-digit number do you form by concatenating the three terms in
 * this sequence?
 *
 * 296962999629
 *)

(* The first 10 primes. *)
let early_primes =
  let buf = Array.make 10 0 in
  let sieve = Sieve.create () in
  let rec loop p i =
    if i < 10 then begin
      buf.(i) <- p;
      loop (Sieve.next_prime sieve p) (i+1)
    end else
      buf
  in loop 2 0

(* Generate a unique identifier for a given (small) number that
 * doesn't account for the position of the digits, just which digits
 * and how many of each, using the first 10 primes for the digits 0-9.
 *)
let number_value num =
  let rec loop num total =
    if num > 0 then
      loop (num / 10) (total * early_primes.(num mod 10))
    else
      total
  in loop num 1

(* Return all of the 4 digit primes. *)
let gen_primes () =
  let sieve = Sieve.create () in
  let rec loop accum p =
    if p > 9999 then accum else
      let a2 = if p >= 1000 then p::accum else accum in
      loop a2 (Sieve.next_prime sieve p)
  in loop [] 2

(* Group the numbers by their values. *)
module IntMap = BatMap.Make(BatInt)
let value_group nums =
  let add m num =
    let value = number_value num in
    IntMap.modify_def [] value (fun l -> num :: l) m in
  BatList.fold_left add IntMap.empty nums

(* Evaluate 'thunk' on each subgroup of 'items'.  Note that the items
 * are reversed. *)
let rec raw_combos accum thunk = function
  | [] -> thunk accum
  | (a::ar) -> begin
    raw_combos accum thunk ar;
    raw_combos (a::accum) thunk ar
  end;
  ()

let combos_len len thunk =
  let act items =
    if List.length items = len then
      thunk items
  in raw_combos [] act

let run () =
  let p = gen_primes () in
  let m = value_group p in
  let m = IntMap.values m in
  let act1 = function
    | [a;b;c] ->
        if c <> 1487 && c-b = b-a then
          Printf.printf "%d%d%d\n" c b a
    | _ -> failwith "Internal error, expecting 3 elements"
  in
  let act l = combos_len 3 act1 l in
  BatEnum.iter act m
