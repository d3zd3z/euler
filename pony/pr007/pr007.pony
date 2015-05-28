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

use "collections"

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

class Sieve

  var _primes: Array[Bool]

  new create() =>
    // Yeah, this is a double initialization.
    _primes = Array[Bool]()
    try
      _fill(1024)
    end

  fun ref is_prime(pos: U64): Bool ? =>
    _room(pos)
    _primes(pos)

  fun ref next_prime(pos: U64): U64 ? =>
    if pos == 2 then
      return 3
    end

    var next = pos + 2
    while not is_prime(next) do
      next = next + 2
    end
    next

  fun ref _room(need: U64) ? =>
    if not (need < _primes.size()) then
      var nsize = _primes.size()
      while not (need < nsize) do
	nsize = nsize * 8
      end
      // _primes = Array[Bool].init(true, nsize)
      _fill(nsize)
    end

  fun ref _fill(size: U64) ? =>
    _primes = Array[Bool].init(true, size)
    _primes.update(0, false)
    _primes.update(1, false)

    var pos: U64 = 2
    let limit = _primes.size()
    while pos < limit do
      if _primes(pos) then
	var n = pos + pos
	while n < limit do
	  _primes.update(n, false)
	  n = n + pos
	end

	if pos == 2 then
	  pos = 3
	else
	  pos = pos + 2
	end
      else
	pos = pos + 2
      end
    end
