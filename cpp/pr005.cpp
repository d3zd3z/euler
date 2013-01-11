// Problem 5
//
// 30 November 2001
//
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all of
// the numbers from 1 to 20?
//
// 232792560

#include <iostream>

static int
gcd (int a, int b)
{
  while (b != 0) {
    int tmp = a % b;
    a = b;
    b = tmp;
  }
  return a;
}

static int
lcm (int a, int b)
{
  return (a / gcd(a, b)) * b;
}

int main()
{
  int answer = 1;

  for (int i = 2; i <= 20; ++i) {
    answer = lcm(answer, i);
  }

  std::cout << answer << "\n";
}
