(* Triangle utilities *)

signature TRIANGLE =
sig
  type triple = {a : int, b : int, c : int}
  val circumference : triple -> int
  val generateTriples : int * (triple * int -> unit) -> unit
  val showTriple : triple * int -> unit
end

structure Triangle : TRIANGLE =
struct

  type box = { p1 : int, p2 : int, q1 : int, q2 : int }

  fun makeBox (p1, p2, q1, q2) : box = { p1=p1, p2=p2, q1=q1, q2=q2 }

  val initialBox : box = makeBox (1, 1, 2, 3)

  fun children (box : box) : box list =
    let
      val x = #p2 box
      val y = #q2 box
    in
      [ makeBox (y-x, x, y,   y*2 - x),
        makeBox (x,   y, x+y, x*2 + y),
        makeBox (y,   x, y+x, y*2 + x) ]
    end

  type triple = { a : int, b : int, c : int }

  fun circumference (triangle : triple) =
    #a triangle + #b triangle + #c triangle

  (* Return the three sides of the pythagorean triple described by the given
   * box. *)
  fun boxTriangle (box : box) : triple =
    { a = #q1 box * #p1 box * 2,
      b = #q2 box * #p2 box,
      c = #p1 box * #q2 box + #p2 box * #q1 box }

  fun multipleTriple (tri : triple, k) : triple =
    { a = #a tri * k,
      b = #b tri * k,
      c = #c tri * k }

  (* Generate all of the primitive Pythagorean triples with a circumference <=
   * limit.  Calls 'act (triple, circumference)' for each possible triple. *)
  fun generateFibonacciTriples (limit, act) =
    let
      fun loop [] = ()
        | loop (box :: nextWork) =
            let
              val triple = boxTriangle box
              val size = circumference triple
            in
              if size <= limit then
                (act (triple, size);
                 loop (nextWork @ children box))
              else ()
            end
    in
      loop [initialBox]
    end


  fun generateTriples (limit, act) =
    let
      fun subGenerate (triple, _) =
        let
          fun loop k =
            let
              val kTriple = multipleTriple (triple, k)
              val kSize = circumference kTriple
            in
              if kSize <= limit then
                (act (kTriple, kSize);
                 loop (k+1))
              else ()
            end
        in
          loop 1
        end
    in
      generateFibonacciTriples (limit, subGenerate)
    end

  (* For debugging *)
  fun showTriple (triple : triple, circ) =
    (print "a=";
    print (Int.toString (#a triple));
    print ", b=";
    print (Int.toString (#b triple));
    print ", c=";
    print (Int.toString (#c triple));
    print ", circ=";
    print (Int.toString circ);
    print "\n")

end
