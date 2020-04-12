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

module SimpleSearcher = struct
  type t = {
    sieve : Sieve.t;
    cache : bool Int.Map.t ref;
    prime : int;
    groups : int list list;
  }

  type intlist = int list [@@deriving show]
  type intlistlist = int list list [@@deriving show]

  let show t =
    sprintf "{ prime = %s; groups = %s }"
      (Int.to_string t.prime)
      (show_intlistlist t.groups)

  let init sieve = {
    sieve;
    cache = ref Int.Map.empty;
    prime = 2;
    groups = [[]; [2]];
  }

  let is_prime t n =
    match Int.Map.find !(t.cache) n with
      | None ->
          let is = Misc.MillerRabin.is_prime_int n in
          t.cache := Int.Map.add_exn !(t.cache) ~key:n ~data:is;
          is
      | Some is -> is

  let goodpair t a b =
    is_prime t (concatnum a b) && is_prime t (concatnum b a)

  let print_info t =
    let groups = List.map t.groups ~f:List.length in
    let groups = List.fold groups ~init:0 ~f:(+) in
    printf "Searcher %d prime, %d group members\n%!" t.prime groups

  (* Add a new prime.  Will create new groups for any where all
   * numbers match *)
  let add_prime t =
    let prime = Sieve.next_prime t.sieve t.prime in
    let groups = List.concat_map t.groups ~f:(fun gr ->
      if List.for_all gr ~f:(fun p -> goodpair t prime p) then
        [(prime :: gr); gr]
      else
        [gr]) in
    { t with prime; groups }

  let scan t len =
    let groups = List.filter t.groups ~f:(fun g -> List.length g = len) in
    match groups with
      | [g] -> Some g
      | [] -> None
      | _ -> failwith "Found multiple groups, need to select smallest"
end

(* A much more complicated search that stores the pairs instead of
 * just the groups.  It uses less memory than the primality cache of
 * the SimpleSearcher, but the search code is much more complex. *)
module Searcher = struct
  let goodpair a b =
    Misc.MillerRabin.is_prime_int (concatnum a b) &&
    Misc.MillerRabin.is_prime_int (concatnum b a)

  (* Given a list of primes (descending order), add the next prime, and
   * produce a list of prime pairs with that new prime.  Returns the new
   * prime list, and a list of the pairs that are valid according to the
   * rules. *)
  let next_pairs sv = function
    | [] -> (2, [2], [])
    | (a::_) as aa ->
        let n = Sieve.next_prime sv a in
        let pairs = List.filter_map aa ~f:(fun p ->
          if goodpair n p then Some p else None) in
        (n, n :: aa, pairs)

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

  let print_info t =
    let primes = List.length t.primes in
    let pairs = Int.Map.data t.pairto in
    let pairs = List.map pairs ~f:Int.Set.length in
    let pairs = List.fold pairs ~init:0 ~f:(+) in
    printf "Searcher %d primes, %d pairs\n%!" primes pairs

  let add_prime t =
    let new_prime, primes, pairs = next_pairs t.sieve t.primes in
    let add_pair m a b =
      Int.Map.change m a ~f:(function
        | None -> Some (Int.Set.singleton b)
        | Some s -> Some (Int.Set.add s b)) in
    let pairto = List.fold ~init:t.pairto pairs ~f:(fun m a ->
      add_pair m a new_prime) in
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
    (*Searcher.print_info sr; *)
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
