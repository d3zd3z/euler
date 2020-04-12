(*
 * The primes 3, 7, 109, and 673, are quite remarkable. By taking any
 * two primes and concatenating them in any order the result will
 * always be prime. For example, taking 7 and 109, both 7109 and 1097
 * are prime. The sum of these four primes, 792, represents the lowest
 * sum for a set of four primes with this property.
 *
 * Find the lowest sum for a set of five primes for which any two
 * primes concatenate to produce another prime.
 *--------------------------------------------------------------------
 * 26033
 *)

open Core

let concatnum a b =
  let digits = Misc.number_of_digits b in
  (Misc.expt 10 digits) * a + b

let goodpair sv a b =
  Sieve.is_prime sv (concatnum a b) &&
    Sieve.is_prime sv (concatnum b a)

(* Given a list of primes (descending order), add the next prime, and
 * produce a list of prime pairs with that new prime.  Returns the new
 * prime list, and a list of the pairs that are valid according to the
 * rules. *)
let next_pairs sv = function
  | [] -> ([2], [])
  | (a::_) as aa ->
      let n = Sieve.next_prime sv a in
      let pairs = List.filter_map aa ~f:(fun p ->
        if goodpair sv n p then Some (p, n) else None) in
      (n :: aa, pairs)

(* This search builds up mappings of pairs, and looks for chains
 * through that map having at least the given length.  This search
 * works, although it needs quite a bit of memory (>2GB), and seems
 * not very efficient.
 * TODO: Can we do better than this?  As a reference, the haskell
 * implementation runs in about 2.5 seconds, and seems to use about
 * 15mb of RAM.  This version takes 8.7 seconds, and uses 2.4GB of
 * RAM. *)
module Searcher = struct
  type t = {
    sieve : Sieve.t;
    primes : int list;
    pairto : Int.Set.t Int.Map.t;
  }

  type intlist = int list [@@deriving show]
  type pairlist = (int * int list) list [@@deriving show]

  let show t =
    let pairto = Int.Map.map t.pairto ~f:Int.Set.to_list in
    let pairto = Int.Map.to_alist pairto in
    sprintf "{ primes = %s; pairto = %s }"
      (show_intlist t.primes)
      (show_pairlist pairto)

  let init sieve = {
    sieve;
    primes = [];
    pairto = Int.Map.empty;
  }

  let add_prime t =
    let primes, pairs = next_pairs t.sieve t.primes in
    let add_pair m a b =
      Int.Map.change m a ~f:(function
        | None -> Some (Int.Set.singleton b)
        | Some s -> Some (Int.Set.add s b)) in
    let pairto = List.fold ~init:t.pairto pairs ~f:(fun m (a, b) ->
      let m = add_pair m a b in
      add_pair m b a) in
    { t with primes; pairto }

  (* Search the current data, looking for a chain of length 'len'. *)
  exception Scan_result of int list
  let scan t len =
    let rec subscan seen to_check =
      if Int.Set.length seen = len then
        raise (Scan_result (Int.Set.to_list seen))
      else
        let rec loop = function
          | [] -> ()
          | (p2 :: rest) ->
              (* Ensure that p2 references all of the others. *)
              let p2_set =
                match Int.Map.find t.pairto p2 with
                  | None -> Int.Set.empty
                  | Some x -> x in
              if Int.Set.for_all seen ~f:(fun x -> Int.Set.mem p2_set x) then
                subscan (Int.Set.add seen p2) rest;
              loop rest
        in loop to_check
    in
    match t.primes with
      | [] -> failwith "Cannot scan without primes"
      | (n :: rest) ->
          let start_set = Int.Set.singleton n in
          subscan start_set rest

  let scan t len =
    try (scan t len; None) with
      | Scan_result x -> Some x
end

let solve () =
  let sv = Sieve.create () in
  let rec loop sr =
    let sr = Searcher.add_prime sr in
    match Searcher.scan sr 5 with
      | Some answer -> answer
      | None -> loop sr in
  loop (Searcher.init sv)

type presult = (int list * (int * int) list) [@@deriving show]

let run () =
  let nums = solve () in
  (* printf "%s\n" (Searcher.show_intlist nums); *)
  let answer = List.reduce_exn nums ~f:(+) in
  printf "%d\n" answer
