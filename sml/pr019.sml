(*
 * Problem 19
 *
 * 14 June 2002
 *
 *
 * You are given the following information, but you may prefer to do
 * some research for yourself.
 *
 *   • 1 Jan 1900 was a Monday.
 *   • Thirty days has September,
 *     April, June and November.
 *     All the rest have thirty-one,
 *     Saving February alone,
 *     Which has twenty-eight, rain or shine.
 *     And on leap years, twenty-nine.
 *   • A leap year occurs on any year evenly divisible by 4, but not on
 *     a century unless it is divisible by 400.
 *
 * How many Sundays fell on the first of the month during the twentieth
 * century (1 Jan 1901 to 31 Dec 2000)?
 *
 * 171
 *)

(* The SMLNJ date library doesn't work outside of Unix date ranges (no earlier than 1970). *)
(* This version does work with mlton, though. *)
(*
val months = [Date.Jan, Date.Feb, Date.Mar, Date.Apr, Date.May, Date.Jun,
	      Date.Jul, Date.Aug, Date.Sep, Date.Oct, Date.Nov, Date.Dec]

fun euler019 () =
    let fun sunday (year, month) =
	    let val date = Date.date { year = year, month = month,
				       day = 1, hour = 0, minute = 0, second = 0,
				       offset = NONE }
	    in
	      Date.weekDay date = Date.Sun
	    end

	fun mloop (year, count) =
	    foldl (fn (month, count) => if sunday (year, month) then count + 1 else count)
		  count
		  months

	fun yloop (year, count) =
	    if year = 2001 then count
	    else yloop (year + 1, mloop (year, count))
    in
      yloop (1901, 0)
    end
*)

(* This is a julian date conversion from wikipedia. *)
fun jdate (year, month, day) =
    let val a = (14 - month) div 12
	val y = year + 4800 - a
	val m = month + 12*a - 3
    in
      day + ((153*m + 2) div 5) + 365*y + (y div 4) - (y div 100) + (y div 400) - 32045
    end

fun euler019 () =
    let val allMonths = List.tabulate (12, fn x => x + 1)
	val allYears = List.tabulate (100, fn x => x + 1901)
	fun sunday (year, month) = (jdate (year, month, 1) mod 7) = 6
	fun ayear (year, count) =
	    foldl (fn (month, count) => if sunday (year, month) then count + 1 else count)
		  count
		  allMonths
    in
      foldl ayear 0 allYears
    end

val () = print (Int.toString (euler019 ()) ^ "\n")
