// Sieve implementation.

#include "sieve.hpp"

Tsieve::Tsieve() {
  primes = 0;
  fill(1024);
}

Tsieve::~Tsieve() {
  if (primes)
    delete(primes);
}

void
Tsieve::fill(int nsize) {
  if (primes)
    delete(primes);

  primes = new bool[nsize];
  size = nsize;

  for (int i = 0; i < size; ++i) {
    primes[i] = true;
  }

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
Tsieve::is_prime(int num) {
  if (num >= size)
    new_length(num);

  return primes[num];
}

void
Tsieve::new_length(int n) {
  int cur = size;
  while (n >= cur)
    cur *= 8;
  fill(cur);
}

int
Tsieve::next_prime(int num) {
  if (num == 2)
    return 3;
  do
    num += 2;
  while (!is_prime(num));

  return num;
}
