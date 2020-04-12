(*
 * Problem 34
 *
 * 03 January 2003
 *
 *
 * 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
 *
 * Find the sum of all numbers which are equal to the sum of the
 * factorial of their digits.
 *
 * Note: as 1! = 1 and 2! = 2 are not sums they are not included.
 *
 * 40730
 *)

open Core

let factorial =
  let facts = Array.create ~len:10 1 in
  for i = 2 to 9 do
    facts.(i) <- i * facts.(i-1)
  done;
  fun x -> facts.(x)

let euler34 () =
  let total = ref (-3) in
  let last_fact = factorial 9 in
  let rec chain number fact_sum =
    if number > 0 && number = fact_sum then
      total := !total + number;
    if number * 10 <= fact_sum + last_fact then begin
      for i = (if number > 0 then 0 else 1) to 9 do
	chain (number * 10 + i) (fact_sum + factorial i)
      done
    end in
  chain 0 0;
  !total

let run () = printf "%d\n" (euler34 ())
