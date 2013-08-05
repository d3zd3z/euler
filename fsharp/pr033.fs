// Problem 33
//
// 20 December 2002
//
//
// The fraction ^49/[98] is a curious fraction, as an inexperienced
// mathematician in attempting to simplify it may incorrectly believe that ^
// 49/[98] = ^4/[8], which is correct, is obtained by cancelling the 9s.
//
// We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
// examples.
//
// There are exactly four non-trivial examples of this type of fraction, less
// than one in value, and containing two digits in the numerator and
// denominator.
//
// If the product of these four fractions is given in its lowest common
// terms, find the value of the denominator.

let isFrac a b =
    let an = a / 10
    let am = a % 10
    let bn = b / 10
    let bm = b % 10
    (an = bm && bn > 0 && am*b = bn*a) ||
        (am = bn && bm > 0 && an*b = bm*a)

let rec gcd a b =
    if b = 0 then a
    else gcd b (a % b)

// Rational multiplation that reduces the fraction
let ratMult (a, b) (c, d) =
    let n = a * c
    let m = b * d
    let common = gcd m n
    (n / common, m / common)

let pr33 () =
    let (_, m) =
        seq {
            for a = 10 to 99 do
                for b = a+1 to 99 do
                    if isFrac a b then yield (a, b) }
        |> Seq.fold ratMult (1, 1)
    m

printfn "%A" (pr33 ())
