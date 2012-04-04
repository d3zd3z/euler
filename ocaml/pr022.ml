(*
 * Problem 22
 *
 * 19 July 2002
 *
 *
 * Using names.txt (right click and 'Save Link/Target As...'), a 46K
 * text file containing over five-thousand first names, begin by
 * sorting it into alphabetical order. Then working out the
 * alphabetical value for each name, multiply this value by its
 * alphabetical position in the list to obtain a name score.
 *
 * For example, when the list is sorted into alphabetical order, COLIN,
 * which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the
 * list. So, COLIN would obtain a score of 938 × 53 = 49714.
 *
 * What is the total of all the name scores in the file?
 *)

open Batteries_uni
open Printf

let get_names path =
  match List.of_enum (File.lines_of path) with
    | [names] ->
	let names = String.nsplit names "," in
	List.map (String.strip ~chars:"\"") names
    | _ -> failwith "Unexpected names list"

let letter_A = Char.code 'A'

let name_value name =
  let value = ref 0 in
  for i = 0 to String.length name - 1 do
    value := !value + Char.code name.[i] - letter_A + 1
  done;
  !value

let euler22 () =
  let names = get_names "../haskell/names.txt" in
  let names = List.sort names in
  let values = List.map name_value names in
  let values = List.enum values in
  Enum.sum (Enum.mapi (fun index value -> (index + 1) * value) values)

let () =
  let result = euler22 () in
  printf "%d\n" result
