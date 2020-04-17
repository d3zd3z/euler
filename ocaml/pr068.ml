(*
 * The 5-gon ring.
 * The description has some diagrams, which don't translate all that
 * well.
 * Represent the input as a list of the values in the inner and outer
 * rings.
 * Conveniently, we don't have to worry about the 16/17 digit
 * difference, since when sorted lexicographically, the solutions with
 * two 10s all start with 1 or 2, and the solution will be larger.
 *--------------------------------------------------------------------
 * 6531031914842725
 *)

open Core

module Int_array : Misc.VEC with type elt = int and type t = int array = struct
  type t = int array
  type elt = int
  let length = Array.length
  let get = Array.get
  let set = Array.set
end
module Int_permuter = Misc.Make_permuter (Int_array) (Int)

type iarray = int array [@@deriving show]

let valid = function
  | [|a;b;c;d;e; f;g;h;i;j|] ->
      let total = a + f + g in
      total = b + g + h &&
      total = c + h + i &&
      total = d + i + j &&
      total = e + j + f &&
      a < b && a < b && a < d && a < e
  | _ -> false

let concat sol =
  let buf = Buffer.create 16 in
  Array.iter sol ~f:(fun x -> bprintf buf "%d" x);
  Buffer.contents buf

let assemble = function
  | [|a;b;c;d;e; f;g;h;i;j|] ->
      [|a;f;g; b;g;h; c;h;i; d;i;j; e;j;f|]
  | _ -> failwith "Invalid solution"

let run () =
  let nums = Array.init 10 ~f:succ in
  let rec loop nums best =
    let res = try Some (Int_permuter.next_permutation nums) with
      | Misc.Last_permutation -> None in
    match res with
      | Some nums ->
          if valid nums then
            loop nums (Array.copy nums)
          else
            loop nums best
      | None -> best
  in
  let result = loop nums [||] in
  let result = concat (assemble result) in
  printf "%s\n" result
