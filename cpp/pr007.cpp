// Problem 7
//
// 28 December 2001
//
// By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
// that the 6th prime is 13.
//
// What is the 10 001st prime number?
//
// 104743

#include <iostream>

#include "sieve.hpp"

int main()
{
  Tsieve sieve;
  int count = 1;
  int prime = 2;
  while (count < 10001) {
    prime = sieve.next_prime(prime);
    ++count;
  }

  std::cout << prime << "\n";
}
