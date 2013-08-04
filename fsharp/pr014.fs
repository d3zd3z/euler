// Problem 14
//
// 05 April 2002
//
//
// The following iterative sequence is defined for the set of positive
// integers:
//
// n → n/2 (n is even)
// n → 3n + 1 (n is odd)
//
// Using the rule above and starting with 13, we generate the following
// sequence:
//
// 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
//
// It can be seen that this sequence (starting at 13 and finishing at 1)
// contains 10 terms. Although it has not been proved yet (Collatz Problem),
// it is thought that all starting numbers finish at 1.
//
// Which starting number, under one million, produces the longest chain?
//
// NOTE: Once the chain starts the terms are allowed to go above one million.
//
// 837799

open System.Collections.Generic

// Non-cached version.
let chainLength n =
    let rec loop length n =
        if n = 1L then length
        else if n &&& 1L = 0L then loop (length + 1) (n / 2L)
        else loop (length + 1) (n * 3L + 1L)
    loop 1 n

// Based on an immutable functional hash.  This seems to be much slower than the simple solution.
let mapChainLength () =
    let cache = ref (Map.empty)
    let rec lookup n =
        match (!cache).TryFind n with
        | Some(x) -> x
        | None ->
            let result = nextLookup n
            cache := (!cache).Add (n, result)
            result
    and nextLookup n =
        if n = 1L then 1
        else if n &&& 1L = 0L then (lookup (n / 2L)) + 1
        else (lookup (n * 3L + 1L)) + 1
    lookup

// Using the mutable dictionary type.  This is significantly faster.
let dictChainLength () =
    let limit = 100000L   // Seems to be faster the higher.
    let cache = new Dictionary<_, _> ()
    let rec lookup n =
        let mutable res = Unchecked.defaultof<_>
        if n < limit && cache.TryGetValue (n, &res) then res
        else
            let result = nextLookup n
            if n < limit then
                cache.Add (n, result)
            result
    and nextLookup n =
        if n = 1L then 1
        else if n &&& 1L = 0L then (lookup (n / 2L)) + 1
        else (lookup (n * 3L + 1L)) + 1
    lookup

let pr14 () =
    seq { 1L .. 999999L }
    // |> Seq.maxBy chainLength
    // |> Seq.maxBy (mapChainLength ())
    |> Seq.maxBy (dictChainLength ())

printfn "%d" (pr14 ())
