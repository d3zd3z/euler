// Problem 27
//
// 27 September 2002
//
//
// Euler published the remarkable quadratic formula:
//
// n^2 + n + 41
//
// It turns out that the formula will produce 40 primes for the consecutive
// values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41
// is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly
// divisible by 41.
//
// Using computers, the incredible formula  n^2 − 79n + 1601 was discovered,
// which produces 80 primes for the consecutive values n = 0 to 79. The
// product of the coefficients, −79 and 1601, is −126479.
//
// Considering quadratics of the form:
//
//     n^2 + an + b, where |a| < 1000 and |b| < 1000
//
//     where |n| is the modulus/absolute value of n
//     e.g. |11| = 11 and |−4| = 4
//
// Find the product of the coefficients, a and b, for the quadratic
// expression that produces the maximum number of primes for consecutive
// values of n, starting with n = 0.
//
// -59231

type Sieve.Sieve with
    member this.PrimeLength a b =
        let rec loop n =
            let num = n*n + a*n + b
            if num >= 2 && this.IsPrime num then loop (n+1)
            else n
        loop 0

let pr27 () =
    let sv = new Sieve.Sieve ()
    let a, b =
        seq {
            for a = -999 to 999 do
            for b = 2 to 999 do
            yield (a, b) }
        |> Seq.maxBy (fun (a, b) -> sv.PrimeLength a b)
    a * b

printfn "%A" (pr27 ())
