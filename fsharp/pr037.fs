// Problem 37
//
// 14 February 2003
//
//
// The number 3797 has an interesting property. Being prime itself, it is
// possible to continuously remove digits from left to right, and remain
// prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
// right to left: 3797, 379, 37, and 3.
//
// Find the sum of the only eleven primes that are both truncatable from left
// to right and right to left.
//
// NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
//
// 748317

module Pr037

// Solve this by trying and filtering all primes.  This works pretty close to a lazy solution in
// haskell.

// Convenient int-based one.
let isPrime (x : int) = Miller.isPrime (uint64 x) 20

// Generate all of the right removal digits from a given number.
let rec leftGen n =
    if n = 0 then Seq.empty
    else seq {
        yield n
        yield! (leftGen (n / 10))
    }

let rightGen n =
    let rec loop n build ten =
        if n = 0 then Seq.singleton build
        else seq {
            yield build
            yield! (loop (n / 10) ((n % 10) * ten + build) (ten * 10))
        }
    loop (n / 10) (n % 10) 10

// Fortunately the problem statement tells us there are only 11 of these primes, so we can stop
// generating at that point.
let euler037 () =
    let sv = Sieve.Sieve ()
    sv.PrimesFrom 11
    |> Seq.filter (fun x ->
        let lefts = leftGen x
        let rights = rightGen x
        Seq.append lefts rights
        |> Seq.forall (fun n -> isPrime n))
    |> Seq.take 11
    |> Seq.sum

#if COMPILED
euler037 () |> printfn "%A"
#endif
