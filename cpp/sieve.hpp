#ifndef __SIEVE_HPP__
#define __SIEVE_HPP__

// A simple sieve for prime numbers.  Auto-grows as needed.
// TODO: Change to a vector instead of the pointer as given.

namespace euler {

class Tsieve {
public:
  Tsieve() :primes{nullptr} {fill(1024);}
  ~Tsieve() {
    if (primes)
      delete(primes);
  }

  bool is_prime(int num);
  int next_prime(int num);
private:
  int size;
  bool *primes;

  void new_length(int n);
  void fill(int nsize);
};

}

#endif
