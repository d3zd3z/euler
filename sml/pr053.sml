(*
 * Problem 53
 *
 * 26 September 2003
 *
 *
 * There are exactly ten ways of selecting three from five, 12345:
 *
 * 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
 *
 * In combinatorics, we use the notation, ^5C[3] = 10.
 *
 * In general,
 *
 * ^nC[r] = n!       ,where r ≤ n, n! = nx(n−1)x...x3x2x1, and 0! = 1.
 *          r!(n−r)!
 *
 * It is not until n = 23, that a value exceeds one-million: ^23C[10] =
 * 1144066.
 *
 * How many, not necessarily distinct, values of  ^nC[r], for 1 ≤ n ≤
 * 100, are greater than one-million?
 *
 *)

structure Pr053 =
struct

datatype satnum = OVERFLOW | NORMAL of int

fun satAdd (OVERFLOW, _) = OVERFLOW
  | satAdd (_, OVERFLOW) = OVERFLOW
  | satAdd (NORMAL a, NORMAL b) =
    let val ab = a + b in
      if ab <= 1000000 then
	NORMAL ab
      else
	OVERFLOW
    end

fun pascalNext (xs as (x :: _)) =
    let fun next (a :: (bs as (b :: _))) = satAdd (a, b) :: next bs
	  | next x = x
    in
      x :: next xs
    end
  | pascalNext [] = [NORMAL 1]

fun solve () =
    let val count = ref 0
	fun update items =
	    let val only = List.filter (fn x => x = OVERFLOW) items in
	      count := !count + List.length only
	    end
	fun loop (0, _) = ()
	  | loop (count, item) =
	    let val item' = pascalNext item in
	      update item';
	      loop (count - 1, item')
	    end
    in
      loop (101, []);
      !count
    end

end
