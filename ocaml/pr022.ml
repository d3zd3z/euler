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
 *
 * 871198282
 *)

open Core

let get_names path =
  match In_channel.read_lines path with
    | [names] ->
	let names = String.split names ~on:',' in
	List.map ~f:(String.strip ~drop:(fun ch -> Char.(ch = '"'))) names
    | _ -> failwith "Unexpected names list"

let letter_A = Char.to_int 'A'

let name_value name =
  let value = ref 0 in
  for i = 0 to String.length name - 1 do
    value := !value + Char.to_int name.[i] - letter_A + 1
  done;
  !value

let euler22 () =
  let names = get_names "../haskell/names.txt" in
  let names = List.sort ~compare:String.compare names in
  let values = List.map ~f:name_value names in
  let v = List.mapi ~f:(fun index value -> (index + 1) * value) values in
  (* List.fold ~init:0 ~f:(+) v *)
  List.sum (module Int) v ~f:ident

let run () =
  let result = euler22 () in
  printf "%d\n" result
