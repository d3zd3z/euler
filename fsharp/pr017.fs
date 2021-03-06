// Problem 17
//
// 17 May 2002
//
//
// If the numbers 1 to 5 are written out in words: one, two, three, four,
// five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
//
// If all the numbers from 1 to 1000 (one thousand) inclusive were written
// out in words, how many letters would be used?
//
//
// NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
// forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
// 20 letters. The use of "and" when writing out numbers is in compliance
// with British usage.
//
// 21124

open System

let one_names = [|
  "one"; "two"; "three"; "four"; "five"; "six"; "seven"; "eight"; "nine";
  "ten"; "eleven"; "twelve"; "thirteen"; "fourteen"; "fifteen"; "sixteen";
  "seventeen"; "eighteen"; "nineteen" |]

let ten_names = [|
  "ten"; "twenty"; "thirty"; "forty"; "fifty"; "sixty"; "seventy";
  "eighty"; "ninety" |]

let ones = function
  | n when 1 <= n && n <= 19 -> one_names.[n-1]
  | _ -> failwith "Invalid ones"

let tens = function
  | n when 1 <= n && n <= 9 -> ten_names.[n-1]
  | _ -> failwith "Invalid tens"

let rec textize = function
  | x when x > 1000 -> failwith "Only up to 1000 supported"
  | x when x < 0 -> failwith "Only positive numbers supported"
  | 1000 -> "one thousand"
  | x when x >= 100 ->
      let num = x % 100 in
      let and' = if num <> 0 then "and " else "" in
      ones (x / 100) + " hundred " + and' + textize num
  | x when x >= 20 ->
      let num = x % 10 in
      let hyphen' = if num > 0 then "-" else " " in
      tens (x / 10) + hyphen' + textize num
  | x when x >= 1 ->
      ones x
  | 0 -> ""
  | _ -> failwith "Unsupported number"

let countLetters (str : string) =
  let mutable count = 0
  for i = 0 to str.Length - 1 do
    if Char.IsLetter str.[i] then
      count <- count + 1
  count

let pr17 () =
  seq { 1 .. 1000 }
  |> Seq.map textize
  |> Seq.map countLetters
  |> Seq.sum

printfn "%A" (pr17 ())
