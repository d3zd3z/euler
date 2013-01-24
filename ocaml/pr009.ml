(**********************************************************************
 * Problem 9
 *
 * 25 January 2002
 *
 *
 * A Pythagorean triplet is a set of three natural numbers, a < b < c,
 * for which,
 *
 * a^2 + b^2 = c^2
 *
 * For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
 *
 * There exists exactly one Pythagorean triplet for which a + b + c =
 * 1000.
 * Find the product abc.
 **********************************************************************)

let pr9 () =
  let rec top a =
    if a = 1000 then failwith "No answer";
    let rec mid b =
      if a + b > 1000 then top (a + 1) else
	let c = 1000 - a - b in
	if (c > b) && (a*a + b*b = c*c) then
	  a * b * c
	else
	  mid (b + 1)
    in mid a
  in top 1

let run () = Printf.printf "%d\n" (pr9 ())
