// Problem 1
//
// 05 October 2001
//
//
// If we list all the natural numbers below 10 that are multiples of 3 or 5,
// we get 3, 5, 6 and 9. The sum of these multiples is 23.
//
// Find the sum of all the multiples of 3 or 5 below 1000.
//
// 233168

let mult n = n % 5 = 0 || n % 3 = 0

let pr1 () =
  let fnums = seq { for i in 1 .. 999 do if mult i then yield i }
  Seq.fold (+) 0 fnums

printfn "%A" (pr1 ())
