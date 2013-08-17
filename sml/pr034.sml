(*
 * Problem 34
 *
 * 03 January 2003
 *
 *
 * 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
 *
 * Find the sum of all numbers which are equal to the sum of the
 * factorial of their digits.
 *
 * Note: as 1! = 1 and 2! = 2 are not sums they are not included.
 *
 * 40730
 *)

structure Pr034 = struct

  val factorial =
    let
      val facts = Array.array (10, 1)
      fun loop 10 = ()
        | loop i =
            let
              val prior = Array.sub (facts, i-1)
            in
              Array.update (facts, i, i * prior);
              loop (i+1)
            end
      val facts = (loop 2; Array.vector facts)
      fun get x = Vector.sub (facts, x)
    in
      get
    end

  fun solve () =
  let
    val total = ref ~3
    val lastFact = factorial 9
    fun chain (number, factSum) =
      let
        fun loop 10 = ()
          | loop i =
              (chain (number * 10 + i, factSum + factorial i);
               loop (i+1))
      in
        if number > 0 andalso number = factSum then
          total := !total + number
        else ();
        if number * 10 <= factSum + lastFact then
          loop (if number > 0 then 0 else 1)
        else ()
      end
  in
    chain (0, 0);
    !total
  end

end
