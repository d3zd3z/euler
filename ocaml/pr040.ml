(*
 * Problem 40
 *
 * 28 March 2003
 *
 *
 * An irrational decimal fraction is created by concatenating the
 * positive integers:
 *
 * 0.123456789101112131415161718192021...
 *
 * It can be seen that the 12^th digit of the fractional part is 1.
 *
 * If d[n] represents the n^th digit of the fractional part, find the
 * value of the following expression.
 *
 * d[1] x d[10] x d[100] x d[1000] x d[10000] x d[100000] x d[1000000]
 *
 * 210
 *)

open! Batteries
open Printf

let sequence () =
  let numbers = 1 -- 1000000 in
  let textual = Enum.map (List.enum % String.explode % string_of_int) numbers in
  Enum.concat textual

let eget seq =
  match Enum.get seq with
      Some x -> x
    | None   -> failwith "Out of elements"

let run () =
  let seq = sequence () in
  let rec loop sum drops =
    if drops > 999999 then sum
    else begin
      let head = eget seq in
      let head = Char.code head - Char.code '0' in
      Enum.drop (drops - 1) seq;
      loop (sum * head) (drops * 10)
    end in
  let result = loop 1 9 in
  printf "%d\n" result
