# A simple prime sieve

class exports.Sieve

  constructor: ->
    this.fill 32

  fill: (size) ->
    primes = (true for i in [0...size])
    primes[0] = false
    primes[1] = false
    p = 2
    while p < size
      tmp = p+p
      if p+p < size
        for n in [p+p ... size] by p
          primes[n] = false
      p = if p == 2 then 3 else p+2
      while p < size and not primes[p]
        p += 2
    this.primes = primes

  ensureSize: (n) ->
    cur = this.primes.length
    if cur <= n
      while cur <= n
        cur *= 8
      this.fill(cur)

  isPrime: (n) ->
    this.ensureSize(n)
    this.primes[n]

  nextPrime: (n) ->
    n = if n == 2 then 3 else n+2
    while not this.isPrime(n)
      n += 2
    n
