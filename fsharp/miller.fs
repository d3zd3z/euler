// Miller rabin

module Miller

let expMod (baseIn : uint64) power modulus =
    let rec loop b p result =
        if p <= 0UL then
            result
        else
            let r2 = if (p &&& 1UL) <> 0UL then (result * b) % modulus else result
            loop ((b * b) % modulus) (p / 2UL) r2
    loop baseIn power 1UL

let computeSd (n : uint64) =
    let rec loop s d =
        if (d &&& 1UL) = 0UL then
            loop (s + 1UL) (d / 2UL)
        else
            (s, d)
    loop 0UL (n - 1UL)

let rnd64 =
    let rnd = System.Random ()
    fun a b ->
        let left = rnd.Next()
        let right = rnd.Next()
        let big = (uint64 left <<< 31) ||| (uint64 right)
        let delta = b - a + 1UL
        // Note that this has a bias.
        (big % delta) + a

let oneRound n s d =
    let a = rnd64 0UL (n - 3UL) + 1UL
    let x = expMod a d n

    if x = 1UL || x = n - 1UL then true
    else
        let rec loop count x =
            if count = s then false
            else
                let x = (x * x) % n
                if x = 1UL then false
                else if x = n - 1UL then true
                else loop (count + 1UL) x
        loop 0UL x

let check n k =
    let (s, d) = computeSd n
    let rec loop count =
        if count = k then true
        else
            if not (oneRound n s d) then false
            else loop (count + 1)
    loop 0

let isPrime n k =
    if n = 1UL || n = 0UL then false
    else if n = 2UL || n = 3UL || n = 5UL || n = 7UL then true
    else if n % 2UL = 0UL || n % 3UL = 0UL || n % 5UL = 0UL || n % 7UL = 0UL then false
    else check n k

(*
let pcheck a =
    printf "prime? %A %A\n" a (isPrime a 20)

pcheck 65537UL
*)
