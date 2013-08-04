// Problem 10
//
// 08 February 2002
//
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.
//
// 142913828922

let pr10 () =
  let sv = Sieve.Sieve ()
  sv.PrimesFrom 2
  |> Seq.takeWhile (fun x -> x < 2000000)
  |> Seq.fold (fun acc x -> acc + int64 x) 0L

printfn "%d" (pr10 ())
