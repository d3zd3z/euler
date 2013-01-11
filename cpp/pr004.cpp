// Problem 4
//
// 16 November 2001
//
// A palindromic number reads the same both ways. The largest palindrome made
// from the product of two 2-digit numbers is 9009 = 91 x 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.
//
// 906609

#include <iostream>

static int reverse(int n)
{
  int result = 0;
  while (n > 0) {
    result = result * 10 + n % 10;
    n /= 10;
  }
  return result;
}

static int is_palindrome(int n)
{
  return n == reverse(n);
}

int main()
{
  int best = 0;

  for (int a = 100; a <= 999; ++a)
    for (int b = a; b <= 999; ++b) {
      int c = a * b;
      if (c > best && is_palindrome(c))
	best = c;
    }

  std::cout << best << "\n";
}
