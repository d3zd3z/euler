#ifndef __SIEVE_HPP__
#define __SIEVE_HPP__

class Tsieve {
public:
  Tsieve();
  ~Tsieve();

  bool is_prime(int num);
  int next_prime(int num);
private:
  int size;
  bool *primes;

  void new_length(int n);
  void fill(int nsize);
};

#endif
