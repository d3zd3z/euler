(* Some simple timing utilities *)

signature TIMING = sig
  val time : ('a -> 'b) -> 'a -> 'b
  val notime : ('a -> 'b) -> 'a -> 'b
end

structure Timing : TIMING = struct

  (* Invoke 'thunk arg' and print out how much time it took to evaluate. *)
  fun time thunk arg =
  let
    val timer = Timer.startCPUTimer ()
    val answer = thunk arg
    val {nongc, gc} = Timer.checkCPUTimes timer
  in
    print "(u:";
    print (Time.toString (#usr nongc));
    print ", s:";
    print (Time.toString (#sys nongc));
    print "; gc u:";
    print (Time.toString (#usr gc));
    print ", s:";
    print (Time.toString (#sys gc));
    print ")\n";
    answer
  end

  (* Function with the same signature, just applies the argument. *)
  fun notime thunk arg = thunk arg

end
