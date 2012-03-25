(**********************************************************************
 * Problem 3
 *
 * 02 November 2001
 *
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 *
 **********************************************************************)

let testing_dump () =
  let rec loop s count =
    if count < 100 then begin
      let (p, s') = Sieve.Int64Sieve.next s in
      Printf.printf "%Ld\n" p;
      loop s' (count + 1)
    end in
  loop Sieve.Int64Sieve.initial 1
(* let _ = testing_dump () *)

let factors number =
  let rec loop s number so_far =
    if number = 1L then so_far else
      (* TODO: We recompute s' for each factor, which is inefficient
	 for large powers. *)
      let (next, s') = Sieve.Int64Sieve.next s in
      if Int64.rem number next = 0L then
	loop s (Int64.div number next) (next :: so_far)
      else
	loop s' number so_far in
  loop Sieve.Int64Sieve.initial number []

let pr3 () =
  Printf.printf "%Ld\n" (List.hd (factors 600851475143L))
let _ = pr3 ()
