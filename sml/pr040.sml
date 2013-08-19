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

structure Pr040 =
struct

  fun special 1 = true
    | special 10 = true
    | special 100 = true
    | special 1000 = true
    | special 10000 = true
    | special 100000 = true
    | special 1000000 = true
    | special _ = false

  (* This is a bit more imperative, but seems to be a cleaner solution. *)
  fun solve () =
    let
      val product = ref 1
      val count = ref 0
      fun addDigit dig =
        (count := !count + 1;
        if special (!count) then
          product := !product * dig
        else ())
      fun loop i =
        if !count > 1000000 then !product
        else
          (List.app addDigit (Misc.digitsOf i);
           loop (i+1))
    in
      loop 1
    end

end
