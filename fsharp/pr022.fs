// Problem 22
//
// 19 July 2002
//
//
// Using names.txt (right click and 'Save Link/Target As...'), a 46K text
// file containing over five-thousand first names, begin by sorting it into
// alphabetical order. Then working out the alphabetical value for each name,
// multiply this value by its alphabetical position in the list to obtain a
// name score.
//
// For example, when the list is sorted into alphabetical order, COLIN, which
// is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
// COLIN would obtain a score of 938 x 53 = 49714.
//
// What is the total of all the name scores in the file?
//
// 871198282

open System.IO

let charValue ch =
    int ch - int 'A' + 1

let nameValue (name : string) =
    seq { for i in 0 .. name.Length - 1 -> charValue name.[i] }
    |> Seq.reduce (+)

let getNames () =
    use sr = new StreamReader ("../haskell/names.txt")
    let line = sr.ReadLine ()
    line.Split (',')
    |> Array.map (fun x -> x.Trim [|'"'|])

let pr22 () =
    let names =
        getNames ()
        |> Array.map (fun name -> (name, nameValue name))
        |> Array.sortBy (fun (n, _) -> n)
    let combine sum (_, v) prod = sum + v * prod
    Array.fold2 combine 0 names [| 1 .. names.Length |]

printfn "%A" (pr22 ())
