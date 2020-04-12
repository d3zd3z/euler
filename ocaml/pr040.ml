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

open Core

let digits n =
  let rec loop accum = function
    | 0 -> accum
    | n -> loop (n mod 10 :: accum) (n / 10) in
  loop [] n

let sequence () =
  let numbers = Sequence.range 1 1_000_000 in
  Sequence.concat_map numbers ~f:(fun x ->
    digits x |> Sequence.of_list)

let run () =
  let seq = sequence () in
  let rec loop seq sum drops =
    if drops > 999_999 then sum
    else begin
      let head, seq = uw (Sequence.next seq) in
      let seq = Sequence.drop_eagerly seq (drops - 1) in
      loop seq (sum * head) (drops * 10)
    end in
  let result = loop seq 1 9 in
  printf "%d\n" result
