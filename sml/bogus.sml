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

(* First thing is to see if we can use the SML/NJ map. *)

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
      (print (II.toString n ^ ", " ^ II.toString d ^ "\n");
       if n = 1 then d
       else let
	 val (num, den) = II.divMod (n, d) in
	 if den = 0 then
	   loop (num, d)
	 else
	   loop (n, next d)
       end)
in
  loop (number "600851475143", II.fromInt 2)
end

val () = print (II.toString (solve ()) ^ "\n")

structure M = BinaryMapFn(struct type ord_key = IntInf.int  val compare = IntInf.compare end)

type elt = IntInf.int

type node = {
     next: elt,
     steps: elt list
}

(* Given the 'nexts' return a new nexts map containing the given
   'next' and 'step' value.  If the 'next' is not present, it will be
   added, otherwise, the step will be added to the found node. *)
fun add_node (nexts, next, step) =
    case M.find (nexts, next)
     of SOME(node) => M.insert (nexts, next, { next = next, steps = step :: #steps node })
      | NONE => M.insert (nexts, next, { next = next, steps = [step] })

(* Take the given 'next' node, remove it from the map, and advance
   its divisor values. *)
fun update_first (nexts, node : node) = let
  val (base, _) = M.remove (nexts, #next node)
  fun update (step, map) = add_node (map, #next node, step)
in
  List.foldl update base (#steps node)
end

type sieve = {
     prime: elt,
     nexts: node M.map
}

val (initial : sieve) = { prime = 2, nexts = M.empty }

(* Return the next prime number, and a new sieve ready to generate
   more.  2 is handled specially, so we don't need a node for the even
   numbers, and can just advance by two. *)
fun next (sieve : sieve) =
    case sieve
     of { prime = 2, ... } => (2, { prime = 3, nexts = #nexts sieve })
      | { prime = 3, ... } => let
	  val n = add_node (M.empty, 3*3, 3+3)
	in
	  (3, { prime = 5, nexts = n })
	end
      | sieve => let
	  val cur = #prime sieve
	  val bump = cur + 2
	  val SOME(peek_next, peek) = M.firsti (#nexts sieve)
	in
	  if cur < peek_next then
	    (cur, { prime = bump,
		    nexts = add_node (#nexts sieve, cur*cur, cur+cur) })
	  else
	    next { prime = bump, nexts = update_first (#nexts sieve, peek) }
	end

val (a1, x1) = next initial
val (a2, x2) = next x1
val (a3, x3) = next x2
val (a4, x4) = next x3

fun fill () = let
  val tmp = ref M.empty
  fun add (key, value) = tmp := M.insert (!tmp, key, value)
in
  add (3, "three");
  add (2, "two");
  add (2, "TWO");
  add (1, "one");
  !tmp
end

fun show map = let
  fun single (key, value) =
      print ("key: " ^ IntInf.toString key ^ ", " ^ value ^ "\n")
in
  M.appi single map
end

val () = show (fill ())
