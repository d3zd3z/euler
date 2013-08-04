// First attempt at a sieve.

module Sieve

type Factor = { Prime : int; Power : int }

let advance n = if n = 2 then 3 else n + 2

// Given an existing size, and a required limit 'n', return a new size that
// is better.
let betterSize existing needed =
    let rec loop n =
        if needed < n then n
        else loop (n * 8)
    if existing = 0 then loop 1024 else loop existing

type Sieve () =
    let mutable primes = [| |]
    let mutable count = 0

    let addFactor result p count =
        if count > 0 then
            { Prime = p; Power = count } :: result
        else
            result

    member this.ensure n =
        if n >= count then this.fill (betterSize count n)

    // let fill size =
    member this.fill size =
        let buf = Array.create size true
        buf.[0] <- false
        buf.[1] <- false
        let rec loop pos =
            if pos < size then
                if buf.[pos] then
                    let rec iloop n =
                        if n < size then
                            buf.[n] <- false
                            iloop (n + pos)
                    iloop (pos + pos)
                loop (advance pos)
        loop 2
        primes <- buf
        count <- size

    member this.IsPrime n =
        this.ensure n
        primes.[n]

    member this.NextPrime n =
        let rec loop n =
            if this.IsPrime n then n
            else loop (n + 2)
        loop (if n % 2 = 0 then n + 1 else n + 2)

    member this.PrimesFrom n =
        let next n =
            let n' = this.NextPrime n
            Some (n, n')
        Seq.unfold next n

    member this.DivisorCount n =
        let rec loop result n prime =
            if n = 1 then result
            else
                let rec iloop divideCount n =
                    if n % prime = 0 then
                        iloop (divideCount + 1) (n / prime)
                    else
                        loop (result * (divideCount + 1)) n (this.NextPrime prime)
                iloop 0 n
        loop 1 n 2

    member this.Factors n =
        let rec loop result n p count =
            if n = 1 then addFactor result p count
                else if n % p = 0 then
                    loop result (n / p) p (count + 1)
                else
                    loop (addFactor result p count) n (this.NextPrime p) 0
        loop [] n 2 0

    member this.Spread = function
        | [] -> [1]
        | ({Prime = xPrime; Power = xPower} :: r) ->
            let others = this.Spread r
            let rec loop result power i =
                if i > xPower then result
                else loop (result @ (List.map (fun x -> x * power) others))
                        (power * xPrime) (i + 1)
            loop [] 1 0

    member this.Divisors n =
        this.Factors n |> this.Spread |> List.sort

    member this.ProperDivisorSum n =
        (List.reduce (+) <| this.Divisors n) - n
