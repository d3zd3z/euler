// Test miller Rabin

module Mtest

// Positive test of primes.
let mtest () =
    let sv = Sieve.Sieve ()
    sv.PrimesFrom 2
    |> Seq.take 1000000
    |> Seq.forall (fun n -> Miller.isPrime (uint64 n) 20)

// Negative test.
let ftest () =
    let sv = Sieve.Sieve ()
    seq { 2 .. 999999 }
    |> Seq.filter (fun n -> not (sv.IsPrime n))
    |> Seq.forall (fun n -> not (Miller.isPrime (uint64 n) 20))
