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

open Batteries_uni

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

type node = {
  next: int;
  steps: int list
}

module IntSieve = Make(Int)
module Int64Sieve = Make(Int64)

let testing_dump () =
  let rec loop s count =
    if count < 100 then begin
      let (p, s') = IntSieve.next s in
      Printf.printf "%d\n" p;
      loop s' (count + 1)
    end in
  loop IntSieve.initial 1
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
    ensure_upto (isqrt num);
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
  let rec divides_out n factor =
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
    let (left, factors) = Enum.fold each (num, []) (primes_upto num) in
    if Num.compare left Num.one = 0 then factors
    else { prime=left; power=1 } :: factors

  let divisor_count num =
    List.fold_left (fun x { power } -> x * (power + 1)) 1 (factorize num)

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
