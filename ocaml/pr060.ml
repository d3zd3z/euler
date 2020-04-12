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

let cache = ref Int.Map.empty
let cached_is_prime n =
  match Int.Map.find !cache n with
    | None ->
        let is = Misc.MillerRabin.is_prime_int n in
        cache := Int.Map.add_exn !cache ~key:n ~data:is;
        is
    | Some is -> is

let goodpair a b =
  cached_is_prime (concatnum a b) &&
    cached_is_prime (concatnum b a)

module Searcher = struct
  type t = {
    sieve : Sieve.t;
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
    prime = 2;
    groups = [[]; [2]];
  }

  let print_info t =
    let groups = List.map t.groups ~f:List.length in
    let groups = List.fold groups ~init:0 ~f:(+) in
    printf "Searcher %d prime, %d group members\n%!" t.prime groups

  (* Add a new prime.  Will create new groups for any where all
   * numbers match *)
  let add_prime t =
    let prime = Sieve.next_prime t.sieve t.prime in
    let groups = List.concat_map t.groups ~f:(fun gr ->
      if List.for_all gr ~f:(fun p -> goodpair prime p) then
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
