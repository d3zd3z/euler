// Sieve implementation.

#include "sieve.hpp"

namespace euler {

void
Sieve::fill(int nsize) {
  primes.assign(nsize, true);

  primes[0] = false;
  primes[1] = false;
  int pos = 2;
  while (pos < nsize) {
    if (primes[pos]) {
      int n = pos + pos;
      while (n < nsize) {
	primes[n] = false;
	n += pos;
      }
      if (pos == 2)
	pos = 3;
      else
	pos += 2;
    } else {
      pos += 2;
    }
  }
}

bool
Sieve::is_prime(int num) {
  if (num >= (int)primes.size())
    new_length(num);

  return primes[num];
}

void
Sieve::new_length(int n) {
  int cur = primes.size();
  while (n >= cur)
    cur *= 8;
  fill(cur);
}

int
Sieve::next_prime(int num) {
  if (num == 2)
    return 3;
  do
    num += 2;
  while (!is_prime(num));

  return num;
}

}
