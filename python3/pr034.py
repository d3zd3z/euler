#! /usr/bin/env python3

"""
Problem 34

03 January 2003


145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of
their digits.

Note: as 1! = 1 and 2! = 2 are not sums they are not included.

40730
"""

class Chainer():
    def __init__(self):
        self.facts = self.make_facts(10)
        self.last_fact = self.facts[-1]
        self.total = -3
        self.chain(0, 0)

    def chain(self, number, fact_sum):
        if number > 0 and number == fact_sum:
            self.total += number
        if number * 10 <= fact_sum + self.last_fact:
            for i in range(0 if number > 0 else 1, 10):
                self.chain(number * 10 + i, fact_sum + self.facts[i])

    def make_facts(self, limit):
        facts = [1] * limit

        for i in range(2, limit):
            facts[i] = i * facts[i-1]
        return facts

def main():
    print(Chainer().total)

if __name__ == '__main__':
    main()
