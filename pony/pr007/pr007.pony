// Problem 7
//
// 28 December 2001
//
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?
//
// 104743

use "euler"

actor Main
  new create(env: Env) =>
    try
      var sieve = Sieve
      var p: U64 = 2
      var count: U64 = 1

      while count < 10001 do
	p = sieve.next_prime(p)
	count = count + 1
      end
      env.out.print(p.string())
    else
      env.out.print("No answer")
    end
