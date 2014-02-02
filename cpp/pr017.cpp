// Problem 17
//
// 17 May 2002
//
// If the numbers 1 to 5 are written out in words: one, two, three, four,
// five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
//
// If all the numbers from 1 to 1000 (one thousand) inclusive were written
// out in words, how many letters would be used?
//
// NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
// forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
// 20 letters. The use of "and" when writing out numbers is in compliance
// with British usage.
//
// 21124

#include <cctype>
#include <iostream>
#include <stdexcept>
#include <vector>

namespace euler {
namespace pr017 {

const std::vector<std::string> ones {
  "one", "two", "three", "four", "five", "six", "seven",
      "eight", "nine", "ten", "eleven", "twelve", "thirteen",
      "fourteen", "fifteen", "sixteen", "seventeen", "eighteen",
      "nineteen"
};

const std::vector<std::string> tens {
  "ten", "twenty", "thirty", "forty", "fifty",
      "sixty", "seventy", "eighty", "ninety"
};

class Converter {
 public:
  Converter() :add_space(false) {}
  std::string to_english(int n);
 private:
  std::string buffer;
  bool add_space;
  void add(const std::string text);
};

std::string Converter::to_english(int n) {
  add_space = false;

  if (n <= 0)
    throw std::runtime_error("Negative number");
  if (n > 1000)
    throw std::runtime_error("Number too large");

  if (n == 1000)
    return "one thousand";

  if (n >= 100) {
    add(ones[n / 100 - 1]);
    add("hundred");

    n %= 100;
    if (n > 0)
      add("and");
  }

  if (n >= 20) {
    add(tens[n / 10 - 1]);
    n %= 10;

    if (n > 0) {
      buffer += '-';
      add_space = false;
    }
  }

  if (n >= 1) {
    add(ones[n - 1]);
  }

  std::string result;
  swap(buffer, result);
  return result;
}

void Converter::add(const std::string text) {
  if (add_space)
    buffer += ' ';
  buffer += text;
  add_space = true;
}

void solve()
{
  int total = 0;
  for (int i = 1; i <= 1000; ++i) {
    Converter conv;
    auto text = conv.to_english(i);
    // std::cout << i << ' ' << text << '\n';
    for (auto ch : text) {
      if (std::isalpha(ch))
	++total;
    }
  }
  std::cout << total << "\n";
}

}
}
