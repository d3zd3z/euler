/*
 * Problem 17
 *
 * 17 May 2002
 *
 * If the numbers 1 to 5 are written out in words: one, two, three,
 * four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used
 * in total.
 *
 * If all the numbers from 1 to 1000 (one thousand) inclusive were
 * written out in words, how many letters would be used?
 *
 *
 * NOTE: Do not count spaces or hyphens. For example, 342 (three
 * hundred and forty-two) contains 23 letters and 115 (one hundred
 * and fifteen) contains 20 letters. The use of "and" when writing
 * out numbers is in compliance with British usage.
 *
 * 21124
 */

object Problem017 extends App {
  val ones = Array("one", "two", "three", "four", "five", "six", "seven",
    "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen", "eighteen", "nineteen")

  val tens = Array("twenty", "thirty", "forty", "fifty", "sixty", "seventy",
    "eighty", "ninety")

  def spoken(num: Int): String = {
    if (num == 1000)
      "one thousand"
    else if (num <= 0)
      sys.error("Unsupported number")
    else if (num < 20)
      ones(num-1)
    else if (num < 100 && num % 10 == 0)
      tens(num / 10 - 2)
    else if (num < 100)
      tens(num / 10 - 2) + "-" + ones(num % 10 - 1)
    else if (num < 1000 && num % 100 == 0)
      spoken(num / 100) + " hundred"
    else if (num < 1000)
      spoken(num / 100) + " hundred and " + spoken(num % 100)
    else
      sys.error("Unsupported number")
  }

  def solve() {
    var total = 0
    for (n <- 1 to 1000) {
      total += spoken(n).count(Character.isLetter(_))
      // printf("%4d: '%s'\n", n, spoken(n).count(Character.isLetter(_)))
    }
    printf("%d\n", total)
  }

  solve()
}
