(*
 * Problem 35
 *
 * 17 January 2003
 *
 * The number, 197, is called a circular prime because all rotations of
 * the digits: 197, 971, and 719, are themselves prime.
 *
 * There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17,
 * 31, 37, 71, 73, 79, and 97.
 *
 * How many circular primes are there below one million?
 *
 * 55
 *)

module Pr035

let number_of_digits num =
    let rec loop count num =
        if num = 0 then count
        else loop (count+1) (num/10)
    loop 0 num

let number_rotations num =
    let len = number_of_digits num
    let highest_one = Misc.expt 10 (len-1)
    let rec loop right left accum n result =
        if left > highest_one then result else
            let n_quotient = n / 10
            let n_remainder = n % 10
            let new_accum = accum + left * n_remainder
            let next = n_quotient + right * new_accum
            loop (right/10) (left*10) new_accum n_quotient (next :: result)
    loop highest_one 1 0 num []

// Return a sequence of primes up to the given limit.
let primes_upto (sieve : Sieve.Sieve) limit =
    sieve.PrimesFrom 2 |> Seq.takeWhile (fun x -> x <= limit)

let euler35 () =
    let sieve = Sieve.Sieve ()
    let each count prime =
        if List.forall (sieve.IsPrime) (number_rotations prime)
            then count + 1 else count
    Seq.fold each 0 (primes_upto sieve 1000000)

#if COMPILED
printfn "%A" (euler35 ())
#endif
