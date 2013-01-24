(**********************************************************************
 * Problem 7
 *
 * 28 December 2001
 *
 *
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
 * can see that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 *
 **********************************************************************)

let pr7 () =
  let rec loop s count =
    let (next, s') = Sieve.Int64Sieve.next s in
    if count = 10001 then next else
      loop s' (count + 1) in
  Printf.printf "%Ld\n" (loop Sieve.Int64Sieve.initial 1)
let run () = pr7 ()
