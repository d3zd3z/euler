(*
 * Problem 29
 *
 * 25 October 2002
 *
 *
 * Consider all integer combinations of a^b for 2 ≤ a ≤ 5 and 2 ≤ b ≤
 * 5:
 *
 *     2^2=4, 2^3=8, 2^4=16, 2^5=32
 *     3^2=9, 3^3=27, 3^4=81, 3^5=243
 *     4^2=16, 4^3=64, 4^4=256, 4^5=1024
 *     5^2=25, 5^3=125, 5^4=625, 5^5=3125
 *
 * If they are then placed in numerical order, with any repeats
 * removed, we get the following sequence of 15 distinct terms:
 *
 * 4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125
 *
 * How many distinct terms are in the sequence generated by a^b for 2 ≤
 * a ≤ 100 and 2 ≤ b ≤ 100?
 *
 * 9183
 *)

structure Pr029 = struct

structure L = IntInf
structure S = BinarySetFn(struct type ord_key = L.int  val compare = L.compare end)

fun solve () = let
  fun outer a set =
    if a = 101 then set
    else inner a 2 set
  and inner a b set =
    if b = 101 then outer (a+1) set
    else
      let
        val num = L.pow (L.fromInt a, b)
        val set' = S.add (set, num)
      in
        inner a (b+1) set'
      end
  val endSet = outer 2 S.empty
in
  S.numItems endSet
end

end
