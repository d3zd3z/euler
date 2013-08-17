(*
 * Problem 33
 *
 * 20 December 2002
 *
 *
 * The fraction ^49/[98] is a curious fraction, as an inexperienced
 * mathematician in attempting to simplify it may incorrectly believe
 * that ^49/[98] = ^4/[8], which is correct, is obtained by cancelling
 * the 9s.
 *
 * We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
 * examples.
 *
 * There are exactly four non-trivial examples of this type of
 * fraction, less than one in value, and containing two digits in the
 * numerator and denominator.
 *
 * If the product of these four fractions is given in its lowest common
 * terms, find the value of the denominator.
 *
 * 100
 *)

structure Pr033 = struct

  fun isFrac (a, b) = let
    val an = a div 10
    val am = a mod 10
    val bn = b div 10
    val bm = b mod 10
  in
    (an = bn andalso bn > 0 andalso am*b = bn*a) orelse
      (am = bn andalso bm > 0 andalso an*b = bm*a)
  end

  fun gcd (a, b) =
    if b = 0 then a
    else gcd (b, a mod b)

  (* Rational multiplication that reduces the fraction. *)
  fun ratMult ((a, b), (c, d)) = let
    val n = a * c
    val m = b * d
    val common = gcd (m, n)
  in
    (n div common, m div common)
  end

  fun solve () = let
    fun outer (a, total) =
      if a = 100 then total
      else inner (a, a+1, total)
    and inner (a, b, total) =
      if b = 100 then outer (a+1, total)
      else
        if isFrac (a, b) then
          inner (a, b+1, ratMult (total, (a, b)))
        else
          inner (a, b+1, total)
  in
    #2(outer (10, (1, 1)))
  end

end
