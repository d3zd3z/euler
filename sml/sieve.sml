(* Functional sieves. *)

(* TODO: Make the int type a parameter. *)
signature SIEVE =
sig
  type t
  val make : int -> t
  val is_prime : (t * int) -> bool
  val next_prime : (t * int) -> int
end

structure Sieve : SIEVE =
struct

type t = bool array ref

fun raw_make len =
    let
      val buf = Array.array (len, true)

      fun next p =
	  if p >= len orelse Array.sub (buf, p) then p
	  else next (p+2)

      fun outer p =
	  if p >= len then ()
	  else let
	    fun inner n =
		if n >= len then ()
		else (
		  Array.update (buf, n, false);
		  inner (n + p))
	  in
	    inner (p + p);
	    outer (next (if p = 2 then 3 else p + 2))
	  end
    in
      Array.update (buf, 0, false);
      Array.update (buf, 1, false);
      outer 2;
      buf
    end

fun make len = ref (raw_make len)

fun new_size (cur_size, needed) =
    if cur_size <= needed then
      new_size (cur_size * 8, needed)
    else
      cur_size

fun is_prime (sieve, n) =
    (if Array.length (!sieve) <= n then
       sieve := raw_make (new_size (Array.length (!sieve), n))
     else ();
     Array.sub (!sieve, n))

fun next_prime (sieve, p) =
    let val p = if p = 2 then 3 else p + 2
    in
      if is_prime (sieve, p) then p
      else next_prime (sieve, p)
    end

end
