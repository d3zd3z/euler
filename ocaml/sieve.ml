(* This is an implementaiton of a functional sieve, derived from the
   paper mentioned in
   <http://programmingpraxis.com/2011/10/14/the-first-n-primes/>.
   Instead of being lazy, we return the state each time, which makes
   things a little more complex, but not much.  It still has the
   characterist of generating the primes without bound.  The
   performance at a given prime p is roughly the log of the number of
   primes seen so far.  It performs about the same work as the normal
   Sieve of Eratosthenes, but the work has a larger overhead.

   The sieve will fail when reaching the sqrt of the numeric type
   (there is an [n*n] in the code), and will generally start producing
   incorrect results, or possibly not terminate.

   The sieve is in a functor over a general numeric type. *)

open! Core.Std

module type S = sig
  type elt
  type t
  val initial : t
  val next : t -> (elt * t)
  val to_sequence : t -> elt Sequence.t
end

module Make (Num : Int_intf.S) = struct
  type elt = Num.t

  type node = {
    next : elt;
    steps : elt list
  }

  module EltMap = Map.Make (Num)

  type t = {
    prime : elt;
    nexts : node EltMap.t
  }

  (* Given the 'nexts' return a new nexts map containing the given
   * 'next' and 'step' value.  If 'next' is not present, it will be
   * added, otherwise, the step will be added to the found node. *)
  let add_node nexts next step =
    let ch = function
      | None -> Some { next = next; steps = [step] }
      | Some node -> Some { next = next; steps = step :: node.steps } in
    EltMap.change nexts next ch

  (* Take the given 'next' node, remove it from the map, and advance
   * it''s divisor values. *)
  let update_first nexts node =
    let base = EltMap.remove nexts node.next in
    let update map step = add_node map (Num.(+) node.next step) step in
    List.fold ~f:update ~init:base node.steps

  let two = Num.(+) Num.one Num.one
  let three = Num.(+) two Num.one

  let initial = {
    prime = two;
    nexts = EltMap.empty }

  let rec next sieve =
    if Num.compare sieve.prime three <= 0 then
      if Num.compare sieve.prime two = 0 then
        (two, { sieve with prime = three })
      else
        (three, { prime = Num.(+) two three;
                  nexts = add_node EltMap.empty (Num.( * ) three three) (Num.(+) three three) })
    else
      let cur = sieve.prime in
      let bump = Num.(+) cur two in
      let (peek_next, peek) = EltMap.min_elt_exn sieve.nexts in
      if Num.compare cur peek_next < 0 then
        (cur, { prime = bump;
                nexts = add_node sieve.nexts (Num.( * ) cur cur) (Num.(+) cur cur) })
      else
        next { prime = bump; nexts = update_first sieve.nexts peek }

  let to_sequence sieve =
    let step sieve = Some (next sieve) in
    Sequence.unfold ~init:sieve ~f:step
end

module IntSieve = Make (Int)
module Int64Sieve = Make (Int64)

(* Simplistic variant that just uses int. *)
type sieve = {
  primes: bool array;
  length: int }
type t = sieve ref

let fill size =
  let vec = Array.create ~len:size true in
  let p = ref 2 in
  vec.(0) <- false;
  vec.(1) <- false;
  while !p < size do
    let n = ref (!p + !p) in
    while !n < size do
      vec.(!n) <- false;
      n := !n + !p
    done;
    p := if !p = 2 then 3 else !p + 2;
    while !p < size && not vec.(!p) do
      p := !p + 2
    done
  done;
  { primes = vec; length = size }

let create () = ref (fill 1024)

let rec new_size cur_size needed =
  if cur_size <= needed then
    new_size (cur_size * 8) needed
  else
    cur_size

let ensure_space sieve n =
  if !sieve.length <= n then begin
    sieve := fill (new_size !sieve.length n)
  end

let is_prime sieve n =
  ensure_space sieve n;
  !sieve.primes.(n)

let rec next_prime sieve p =
  let p = if p = 2 then 3 else p + 2 in
  if is_prime sieve p then p
  else next_prime sieve p

type factor = { prime : int; power : int }

let factorize sieve n =
  let add result p count =
    if count > 0 then
      { prime = p; power = count } :: result
    else result in
  let rec loop result n p count =
    if n = 1 then add result p count
    else if n mod p = 0 then
      loop result (n / p) p (count + 1)
    else
      loop (add result p count) n
        (next_prime sieve p) 0 in
  loop [] n 2 0

let divisor_count sieve n =
  let factors = factorize sieve n in
  List.fold factors ~init:1 ~f:(fun accum elt -> (elt.power + 1) * accum)

let rec spread = function
  | [] -> [1]
  | ({prime; power} :: xs) ->
      let others = spread xs in
      let rec loop result pow i =
        if i > power then result
        else loop (result @ (List.map others ~f:(fun x -> x * pow)))
          (pow * prime) (i + 1) in
      loop [] 1 0

let divisors sieve n = List.sort ~cmp:compare (spread (factorize sieve n))

let proper_divisor_sum sieve n =
  (List.fold ~init:0 ~f:(+) (divisors sieve n)) - n

let primes_upto sieve limit =
  let open Sequence.Step in
  let step p =
    if p >= limit then
      Done
    else if is_prime sieve p then
      Yield (p, if p = 2 then 3 else p + 2)
    else
      Skip (p + 2) in
  Sequence.unfold_step ~init:2 ~f:step
