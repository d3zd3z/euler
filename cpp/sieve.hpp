#ifndef __SIEVE_HPP__
#define __SIEVE_HPP__

// A simple sieve for prime numbers.  Auto-grows as needed.

#include <vector>

namespace euler {

class Tsieve {
public:
  Tsieve() {fill(1024);}

  bool is_prime(int num);
  int next_prime(int num);
private:
  std::vector<bool> primes;

  void new_length(int n);
  void fill(int nsize);
};

}

#endif
