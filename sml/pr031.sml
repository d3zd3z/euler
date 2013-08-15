(*
 * Problem 31
 *
 * 22 November 2002
 *
 *
 * In England the currency is made up of pound, -L-, and pence, p, and
 * there are eight coins in general circulation:
 *
 *     1p, 2p, 5p, 10p, 20p, 50p, -L-1 (100p) and -L-2 (200p).
 *
 * It is possible to make -L-2 in the following way:
 *
 *     1x-L-1 + 1x50p + 2x20p + 1x5p + 1x2p + 3x1p
 *
 * How many different ways can -L-2 be made using any number of coins?
 *
 * 73682
 *)

structure Pr031 = struct

  val coins = [200, 100, 50, 20, 10, 5, 2, 1]

  fun rways (remaining, []) = if remaining = 0 then 1 else 0
    | rways (remaining, (coin::others)) =
        let
          fun loop (sum, remaining) =
            if remaining >= 0 then
              loop (sum + rways (remaining, others), remaining - coin)
            else
              sum
        in
          loop (0, remaining)
        end

  fun solve () = rways (200, coins)

end
