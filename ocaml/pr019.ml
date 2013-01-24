(*
 * Problem 19
 *
 * 14 June 2002
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
 *)

open Printf

let euler19 () =
  let count = ref 0 in
  for year = 1901 to 2000 do
    for month = 1 to 12 do
      let (_, tm) = Unix.mktime { Unix.tm_sec = 1;
				  Unix.tm_min = 0;
				  Unix.tm_hour = 0;
				  Unix.tm_mday = 1;
				  Unix.tm_mon = month - 1;
				  Unix.tm_year = year - 1900;
				  Unix.tm_wday = 0;
				  Unix.tm_yday = 0;
				  Unix.tm_isdst = false } in
      if tm.Unix.tm_wday = 0 then
	count := !count + 1
    done
  done;
  !count

let run () = printf "%d\n" (euler19 ())
