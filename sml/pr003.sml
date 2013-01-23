(*
 * Problem 3
 *
 * 02 November 2001
 *
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 *)

structure Pr003 =
struct

structure II = IntInf

fun number text =
    case II.fromString text
     of SOME(v) => v
      | NONE => raise Fail "Invalid number"

(* We don't really need a sieve for this, since filling the sieve will
   take longer than doing trial divisions. *)
fun solve () = let
  fun next n =
      if n = 2 then 3 else n + 2
  fun loop (n, d) =
      if n = 1 then d
      else let
	val (num, den) = II.divMod (n, d) in
	if den = 0 then
	  loop (num, d)
	else
	  loop (n, next d)
      end
in
  loop (number "600851475143", II.fromInt 2)
end

(* val () = print (II.toString (solve ()) ^ "\n") *)

end
