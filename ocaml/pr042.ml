(*
 * Problem 42
 *
 * 25 April 2003
 *
 *
 * The n^th term of the sequence of triangle numbers is given by, t[n]
 * = 1/2n(n+1); so the first ten triangle numbers are:
 *
 * 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
 *
 * By converting each letter in a word to a number corresponding to its
 * alphabetical position and adding these values we form a word value.
 * For example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If
 * the word value is a triangle number then we shall call the word a
 * triangle word.
 *
 * Using words.txt (right click and 'Save Link/Target As...'), a 16K
 * text file containing nearly two-thousand common English words, how
 * many are triangle words?
 *
 * 162
 *)

open Core

(* Read the contents of a single line file. *)
let get_file_line path =
  let lines = In_channel.read_lines path in
  List.hd_exn lines

let get_words () =
  let line = get_file_line "../haskell/words.txt" in
  let names = String.split line ~on:',' in
  List.map names ~f:(String.strip ~drop:(fun ch -> Char.(ch = '"')))

let name_value name =
  let chval sum ch = sum + Char.to_int ch - Char.to_int 'A' + 1 in
  String.fold name ~init:0 ~f:chval

let is_triangle number =
  let square = 1 + number * 8 in
  let root = Misc.isqrt square in
  root * root = square

let run () =
  let words = get_words () in
  let values = List.map words ~f:name_value in
  let values = List.filter values ~f:is_triangle in
  let result = List.length values in
  printf "%d\n" result
