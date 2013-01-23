(*
 * Problem 22
 *
 * 19 July 2002
 *
 *
 * Using names.txt (right click and 'Save Link/Target As...'), a 46K
 * text file containing over five-thousand first names, begin by
 * sorting it into alphabetical order. Then working out the
 * alphabetical value for each name, multiply this value by its
 * alphabetical position in the list to obtain a name score.
 *
 * For example, when the list is sorted into alphabetical order, COLIN,
 * which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the
 * list. So, COLIN would obtain a score of 938 x 53 = 49714.
 *
 * What is the total of all the name scores in the file?
 *
 * 871198282
 *)

structure Pr022 =
struct

fun finally (first, cleanup) =
    first () before cleanup ()
    handle e => (cleanup (); raise e)

fun readNames () =
    let val strm = TextIO.openIn "../haskell/names.txt"
	fun openQuot result = case TextIO.input1 strm
			       of NONE => raise Fail "Empty input"
				| SOME(#"\"") => name (result, [])
				| SOME(x) => raise Fail "Illegal character"
	and name (result, buf) =
	    case TextIO.input1 strm
	     of NONE => raise Fail "Unexpected EOF"
	      | SOME(#"\"") => comma (String.implode (rev buf) :: result)
	      | SOME(ch) => if Char.isUpper ch then
			      name (result, (ch :: buf))
			    else
			      raise Fail "Invalid character"
	and comma result =
	    case TextIO.input1 strm
	     of NONE => result
	      | SOME(#",") => openQuot result
	      | SOME(x) => raise Fail "Illegal character"
    in
      finally (fn () => openQuot [], fn () => TextIO.closeIn strm)
    end

fun nameValue name =
    let val len = size name
	fun loop (pos, sum) =
	    if pos = len then
	      sum
	    else
	      loop (pos+1, sum + Char.ord (String.sub (name, pos)) - Char.ord #"A" + 1)
    in
      loop (0, 0)
    end

fun solve () =
    let val names = readNames ()
	val names = ListMergeSort.sort (op >) names
	fun loop ([], total, _) = total
	  | loop (n::ns, total, pos) = loop(ns, total + pos * (nameValue n), pos + 1)
    in
      loop (names, 0, 1)
    end

(* val () = print (Int.toString (solve ()) ^ "\n") *)
end
