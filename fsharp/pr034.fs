// Problem 34
//
// 03 January 2003
//
//
// 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
//
// Find the sum of all numbers which are equal to the sum of the factorial of
// their digits.
//
// Note: as 1! = 1 and 2! = 2 are not sums they are not included.
//
// 40730

let factorial =
    let facts = Array.create 10 1
    for i = 2 to 9 do
        facts.[i] <- i * facts.[i-1]
    fun x -> facts.[x]

let pr34 () =
    let total = ref -3
    let lastFact = factorial 9 in
    let rec chain number factSum =
        if number > 0 && number = factSum then
            total := !total + number
        if number * 10 <= factSum + lastFact then
            for i = (if number > 0 then 0 else 1) to 9 do
                chain (number * 10 + i) (factSum + factorial i)
    chain 0 0
    !total

printfn "%A" (pr34 ())
