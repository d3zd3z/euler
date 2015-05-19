// Problem 4
//
// 16 November 2001
//
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 x 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.
//
// 906609

use "collections"

actor Main
  new create(env: Env) =>
    var max: U32 = 0
    for a in Range[U32](100, 1000) do
      for b in Range[U32](a, 1000) do
	let c = a * b
	if (c > max) and is_palindrome(c) then
	  max = c
	end
      end
    end
    env.out.print(max.string())

  fun reverse(num: U32, base: U32 = 10): U32 =>
    var n = num
    var result: U32 = 0
    while n > 0 do
      result = (result * base) + (n % base)
      n = n / base
    end
    result

  fun is_palindrome(num: U32, base: U32 = 10): Bool =>
    num == reverse(num, base)
