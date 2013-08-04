// Problem 5
//
// 30 November 2001
//
//
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?
//
// 232792560

let rec gcd a b =
  if b = 0 then a
  else gcd b (a % b)

let lcm a b = (a / gcd a b) * b

let pr5 () =
  seq { 2 .. 20 }
  |> Seq.fold lcm 1

printfn "%A" (pr5 ())
