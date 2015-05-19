// Problem 5
//
// 30 November 2001
//
//
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?
//
// 232792560

use "collections"

actor Main
  new create(env: Env) =>
    var accum: U64 = 1

    for i in Range[U64](2, 20) do
      accum = lcm(accum, i)
    end

    env.out.print(accum.string())

  fun lcm(a: U64, b: U64): U64 =>
    (a / gcd(a, b)) * b

  fun gcd(a: U64, b: U64): U64 =>
    if b == 0 then
      a
    else
      gcd(b, a % b)
    end
