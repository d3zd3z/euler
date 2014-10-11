(* Prime number sieve. *)

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

(* open! Batteries_uni *)
(* module Enum = BatEnum *)
open! Batteries

module type SimpleNumeric = sig
  type t
  val compare: t -> t -> int
  val add: t -> t -> t
  val mul: t -> t -> t
  val zero: t
  val one: t
end

module type S = sig
  type elt
  type t
  val initial: t
  val next: t -> (elt * t)
end

module Make(Num: SimpleNumeric) = struct

  type elt = Num.t

  type node = {
    next: elt;
    steps: elt list
  }

  module EltMap = Map.Make(struct type t = elt let compare = Num.compare end)

  type t = {
    prime: elt;				(* The next potential prime. *)
    nexts: node EltMap.t		(* Nodes for next-to-see composites. *)
  }

  (* Given the 'nexts' return a new nexts map containing the given
     'next' and 'step' value.  If the 'next' is not present, it will be
     added, otherwise, the step will be added to the found node. *)
  let add_node nexts next step =
    try
      let node = EltMap.find next nexts in
      EltMap.add next { next = next; steps = step :: node.steps } nexts
    with Not_found ->
      EltMap.add next { next = next; steps = [step] } nexts

  (* Take the given 'next' node, remove it from the map, and advance
     it's divisor values *)
  let update_first nexts node =
    let base = EltMap.remove node.next nexts in
    let update map step = add_node map (Num.add node.next step) step in
    List.fold_left update base node.steps

  let two = Num.add Num.one Num.one
  let three = Num.add two Num.one

  (* Make the initial sieve. *)
  let initial = {
    prime = two;
    nexts = EltMap.empty }

  (* Return the next prime number, and a new sieve ready to generate
     more.  2 is kind of handled specially, so we don't need a node for
     the even numbers, and can just advance by two. *)
  let rec next sieve =
    if Num.compare sieve.prime three <= 0 then
      if Num.compare sieve.prime two = 0 then
	(two, { sieve with prime = three })
      else
	(three, { prime = Num.add two three;
		  nexts = add_node EltMap.empty (Num.mul three three) (Num.add three three) })
    else
      let cur = sieve.prime in
      let bump = Num.add cur two in
      let (peek_next, peek) = EltMap.min_binding sieve.nexts in
      if Num.compare cur peek_next < 0 then
	(cur, { prime = bump;
		nexts = add_node sieve.nexts (Num.mul cur cur) (Num.add cur cur) })
      else
	next { prime = bump; nexts = update_first sieve.nexts peek }
end

(* Sigh, this is not in the stdlib. *)
module Int = struct
  type t = int
  let one = 1
  let zero = 0
  let mul = ( * )
  let add = (+)
  let compare = compare
  let modulo = (mod)
  let div = (/)
  let sub = (-)
end

module IntSieve = Make(Int)
module Int64Sieve = Make(Int64)

(*
let testing_dump () =
  let rec loop s count =
    if count < 100 then begin
      let (p, s') = IntSieve.next s in
      Printf.printf "%d\n" p;
      loop s' (count + 1)
    end in
  loop IntSieve.initial 1
*)
(* let _ = testing_dump () *)

(* Factory. *)
module type FACTORY = sig
  type t
  val isqrt : t -> t
  val primes_upto : t -> t Enum.t
  val is_prime : t -> bool
  type factor = { prime: t; power: int }
  val factorize : t -> factor list
  val divisor_count : t -> int
  val divisors : t -> t list
end

module type RICH_NUMERIC = sig
  include SimpleNumeric
  val sub : t -> t -> t
  val div : t -> t -> t
  val modulo : t -> t -> t
  val shift_left : t -> int -> t
  val shift_right : t -> int -> t
end

(*
module DynArray = BatDynArray
module XDynArray = struct
  type 'a t = { mutable elts: 'a array; mutable used: int; place: 'a }
  let create place = { elts = Array.make 1024 place; used = 0; place = place }
  let empty ary = ary.used == 0
  let last ary = ary.elts.(ary.used - 1)
  let add ary elt =
    if ary.used >= Array.length ary.elts then begin
      let tmp = Array.make (Array.length ary.elts) ary.place in
      ary.elts <- Array.append ary.elts tmp
    end;
    ary.elts.(ary.used) <- elt;
    ary.used <- ary.used + 1
  let get ary pos = ary.elts.(pos)
  let length ary = ary.used
end
*)

module MakeFactory(Num : RICH_NUMERIC) : FACTORY with type t = Num.t = struct
  type t = Num.t

  let isqrt num =
    let num = ref num in
    let bit = ref Num.one in
    while Num.compare (Num.shift_left !bit 2) !num < 0 do
      bit := Num.shift_left !bit 2
    done;
    let result = ref Num.zero in
    while Num.compare !bit Num.zero <> 0 do
      if !num > Num.add !result !bit then begin
	num := Num.sub !num (Num.add !result !bit);
	result := Num.add (Num.shift_right !result 1) !bit
      end else
	result := Num.shift_right !result 1;
      bit := Num.shift_right !bit 2
    done;
    !result

  module S = Make(Num)
  let primes = DynArray.create ()
  let sieve = ref S.initial
  let ensure_upto num =
    while DynArray.empty primes || Num.compare (DynArray.last primes) num < 0 do
      let (next, sieve') = S.next !sieve in
      sieve := sieve';
      DynArray.add primes next
    done

  (* Return an enumerator of the primes up to, but not including num. *)
  let primes_upto num =
    ensure_upto num;
    Enum.take_while (fun x -> x < num) (DynArray.enum primes)

  let is_prime num =
    ensure_upto num;
    let rec bsearch low high =
      if high < low then false
      else begin
	let mid = low + ((high - low) lsr 1) in
	let mid_elt = DynArray.get primes mid in
	match Num.compare mid_elt num with
	  | x when x > 0 -> bsearch low (mid-1)
	  | x when x < 0 -> bsearch (mid+1) high
	  | _ -> true
      end in
    bsearch 0 (DynArray.length primes - 1)

  (* This answer fits well within an 'int'. *)
  type factor = { prime: t; power: int }

(* Compute how many times [factor] divides into [n].  Returns the
   count and the result of dividing [n] by the factor. *)
  let divides_out n factor =
    let rec loop count n =
      if Num.compare (Num.modulo n factor) Num.zero = 0 then
	loop (count + 1) (Num.div n factor)
      else
	(count, n) in
    loop 0 n

  let factorize num =
    let each ((n, factors) as src) x =
      let (count, n') = divides_out n x in
      if count > 0 then (n', { prime=x; power=count } :: factors)
      else src in
    let (left, factors) = BatEnum.fold each (num, []) (primes_upto num) in
    if Num.compare left Num.one = 0 then factors
    else { prime=left; power=1 } :: factors

  let divisor_count num =
    List.fold_left (fun x { power; _ } -> x * (power + 1)) 1 (factorize num)

  (* Spread out the factors and powers to produce all of the divisors. *)
  let rec spread = function
    | [] -> [Num.one]
    | (x::xs) ->
	let rest = spread xs in
	let rec loop power count result =
	  if count > x.power then List.concat result
	  else begin
	    let nodes = List.map (fun n -> Num.mul n power) rest in
	    loop (Num.mul power x.prime) (count + 1) (nodes :: result)
	  end in
	loop Num.one 0 []

  let divisors num = spread (factorize num)
end

module IntFactory = MakeFactory(struct
  include Int
  let shift_left = (lsl)
  let shift_right = (asr)
end)

module Int64Factory = MakeFactory(struct
  include Int64
  let modulo = rem
end)

(* Simplistic variant that just uses int. *)
type sieve = { primes: BitSet.t;
	       length: int }
type t = sieve ref

let fill size =
  let vec = BitSet.create_full size in
  let p = ref 2 in
  BitSet.unset vec 0;
  BitSet.unset vec 1;
  while !p < size do
    let n = ref (!p + !p) in
    while !n < size do
      BitSet.unset vec !n;
      n := !n + !p
    done;
    p := if !p = 2 then 3 else !p + 2;
    while !p < size && not (BitSet.mem vec !p) do
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
  BitSet.mem !sieve.primes n

(* TODO: This could be more efficient with next_set_bit from the bitset code. *)
let rec next_prime sieve p =
  let p = if p = 2 then 3 else p + 2 in
  if is_prime sieve p then p
  else next_prime sieve p

type factor = { prime: int; power: int }

let factorize sieve n =
  let add result p count =
    if count > 0 then
      { prime = p; power = count } :: result
    else
      result in
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
  List.fold_left (fun accum elt -> (elt.power + 1) * accum) 1 factors

let rec spread =
  function [] -> [1]
    | ({prime; power} :: xs) ->
      let others = spread xs in
      let rec loop result pow i =
	if i > power then result
	else loop (result @ (List.map (fun x -> x * pow) others))
	  (pow * prime) (i + 1) in
      loop [] 1 0

let divisors sieve n = List.sort compare (spread (factorize sieve n))

let proper_divisor_sum sieve n =
  List.fold_left (+) 0 (divisors sieve n) - n

let all_primes sieve =
  let next p =
    let p2 = next_prime sieve p in
    (p, p2) in
  Enum.from_loop 2 next

