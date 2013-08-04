// Problem 21
//
// 05 July 2002
//
//
// Let d(n) be defined as the sum of proper divisors of n (numbers less than
// n which divide evenly into n).
// If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
// and each of a and b are called amicable numbers.
//
// For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
// 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
// 2, 4, 71 and 142; so d(284) = 220.
//
// Evaluate the sum of all the amicable numbers under 10000.
//
// 31626

let limit = 10000

type Sieve.Sieve with
    member this.IsAmicable a =
        if a < limit then
            let b = this.ProperDivisorSum a
            let c = this.ProperDivisorSum b
            b < limit && a <> b && a = c
        else false

let pr21 () =
    let sv = new Sieve.Sieve ()
    seq { 2 .. 10000 }
    |> Seq.filter sv.IsAmicable
    |> Seq.sum

printfn "%A" (pr21 ())
