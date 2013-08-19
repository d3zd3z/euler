(* Euler problem driver. *)

structure Euler =
struct

fun runInt thunk () = Int.toString (thunk ())
fun runInf thunk () = IntInf.toString (thunk ())
fun runI64 thunk () = Int64.toString (thunk ())

val problems = [(1, runInt Pr001.solve),
		(2, runInt Pr002.solve),
		(3, runInf Pr003.solve),
		(4, runInt Pr004.solve),
		(5, runInt Pr005.solve),
		(6, runInt Pr006.solve),
		(7, runInt Pr007.solve),
		(8, runInt Pr008.solve),
		(9, runInt Pr009.solve),
		(10, runInf Pr010.solve),
		(11, runInt Pr011.solve),
		(12, runInt Pr012.solve),
		(13,        Pr013.solve),
		(14, runI64 Pr014.solve),
		(15, runInf Pr015.solve),
		(16, runInf Pr016.solve),
		(17, runInt Pr017.solve),
		(18, runInt Pr018.solve),
		(19, runInt Pr019.solve),
		(20, runInf Pr020.solve),
		(21, runInt Pr021.solve),
		(22, runInt Pr022.solve),
		(23, runInt Pr023.solve),
		(24,        Pr024.solve),
		(25, runInt Pr025.solve),
		(26, runInt Pr026.solve),
		(27, runInt Pr027.solve),
		(28, runInt Pr028.solve),
		(29, runInt Pr029.solve),
		(30, runInt Pr030.solve),
		(31, runInt Pr031.solve),
		(32, runInt Pr032.solve),
		(33, runInt Pr033.solve),
		(34, runInt Pr034.solve),
		(35, runInt Pr035.solve),
		(36, runInt Pr036.solve),
		(37, runInt Pr037.solve),
		(38, runInt Pr038.solve),
		(39, runInt Pr039.solve),
		(40, runInt Pr040.solve),
		(41, runInt Pr041.solve),
		(42, runInt Pr042.solve),
		(43, runInf Pr043.solve),
		(44, runInt Pr044.solve),
		(45, runInf Pr045.solve),

		(87, runInt Pr087.solve)]

fun flush () = TextIO.flushOut TextIO.stdOut

(* Determined if we want timing or not. *)
val doTiming = ref false

fun run (num, thunk) =
let
  val time = if !doTiming then Timing.time else Timing.notime
in
  (print (Int.toString num ^ ": ");
  flush ();
  print (time thunk () ^ "\n"))
end

fun runOne n =
    let fun scan [] = raise Fail "Unknown problem"
	  | scan ((nn, thunk)::rest) =
	    if n = nn then run (n, thunk)
	    else scan rest
    in
      scan problems
    end

fun runAll () = List.app run problems

fun main (n, "-timing"::rest) =
      (doTiming := true; main (n, rest))
  | main (_, ["all"]) = (runAll (); 0)
  | main (n, arg::rest) = (case Int.fromString arg
			    of SOME n => runOne n
			     | NONE => raise Fail "Invalid problem number";
			   main (n, rest))
  | main (_, []) = 0

end
