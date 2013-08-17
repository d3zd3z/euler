(*
 * Problem 39
 *
 * 14 March 2003
 *
 *
 * If p is the perimeter of a right angle triangle with integral length
 * sides, {a,b,c}, there are exactly three solutions for p = 120.
 *
 * {20,48,52}, {24,45,51}, {30,40,50}
 *
 * For which value of p ≤ 1000, is the number of solutions maximised?
 *
 * 840
 *)

structure Pr039 =
struct

  structure IM = BinaryMapFn(struct type ord_key = int  val compare = Int.compare end)

  fun updateTriple (set, size) =
    case IM.find (set, size) of
         NONE   => IM.insert (set, size, 1)
       | SOME n => IM.insert (set, size, n+1)

  fun allTriples limit =
    let
      val result = ref IM.empty
      fun add (_, size) =
        result := updateTriple (!result, size)
    in
      Triangle.generateTriples (limit, add);
      !result
    end

  fun solve () =
    let
      fun combine (size, n, (size0, n0)) =
        if n > n0 then (size, n)
        else (size0, n0)
      val all = allTriples 1000
      val (best, _) = IM.foldli combine (0, 0) all
    in
      best
    end

end
