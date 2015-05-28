// A basic prime number sieve.

use "collections"

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
