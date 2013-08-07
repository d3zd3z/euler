// Problem 60
//
// 02 January 2004
//
//
// The primes 3, 7, 109, and 673, are quite remarkable. By taking any two
// primes and concatenating them in any order the result will always be
// prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The
// sum of these four primes, 792, represents the lowest sum for a set of four
// primes with this property.
//
// Find the lowest sum for a set of five primes for which any two primes
// concatenate to produce another prime.
//
// 26033

// The code for concatInts, as currently presented, seems to provoke a bug
// in x86_64 mono 3.2.0's optimizer.

open System.Collections.Generic

// Concatenate two integers, in base 10.
let concatInts a b =
    let rec scale a b =
        if b = 0 then a
        else scale (a * 10) (b / 10)
    (scale a b) + b

type Sieve.Sieve with
    member this.IsPair a b =
        this.IsPrime (concatInts a b) &&
            this.IsPrime (concatInts b a)

    // Given a list of primes (descending order), add the next prime, and
    // produce the prime pairs.  Returns the new list, with the newly added
    // prime at the front, and 'list' of the pairs that are valid with IsPair.
    member this.NextPairs primes =
        match primes with
        | [] -> ([2], [])
        | (a::_) ->
            let n = this.NextPrime a
            let pairs = [ for p in primes do
                            if this.IsPair p n then yield (p, n) ]
            (n::primes, pairs)

// Raise the result as an exception to stop the traversal.
exception Result of int list

// The solver for this problem tracks paired primes, and is able to
// search for deeper sets.
type PairedPrimeSearch () =
    let sieve = Sieve.Sieve ()
    let mutable primes = [2]
    let mutable pairto = Map.empty<_, _>

    member this.AddPair (a, b) =
        let add src dest =
            match Map.tryFind src pairto with
            | None ->
                pairto <- Map.add src (Set.singleton dest) pairto
            | Some s ->
                pairto <- Map.add src (Set.add dest s) pairto
        add a b
        add b a

    member this.AddNextPrime () =
        let p2, pairs = sieve.NextPairs primes
        primes <- p2
        List.iter this.AddPair pairs

    /// Scan the current data, looking for a chain of length 'len'.
    member this.Scan len =
        let rec subScan seen tocheck =
            if Set.count seen = len then
                raise (Result (Set.toList seen))
            else
                let rec loop = function
                | [] -> ()
                | (p2 :: rest) ->
                    // Ensure that 'p2' references all of the others.
                    let p2Set =
                        match Map.tryFind p2 pairto with
                        | None -> Set.empty
                        | Some x -> x
                    if Set.forall (fun x -> Set.contains x p2Set) seen then
                        subScan (Set.add p2 seen) rest
                    loop rest
                loop tocheck

        // Top level scan always starts with this prime number.
        match primes with
        | [] -> failwith "Cannot scan without primes"
        | (n :: rest) ->
            let startSet = Set.singleton n
            subScan startSet rest

    override this.ToString () = pairto.ToString ()

let pr60 () =
    let solver = PairedPrimeSearch ()
    try
        while true do
            solver.AddNextPrime ()
            solver.Scan 5
        failwith "Notreached"
    with
    | Result answer ->
        List.sum answer

printfn "%A" (pr60 ())
