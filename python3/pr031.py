#! /usr/bin/env python3

"""
Problem 31

22 November 2002


In England the currency is made up of pound, £, and pence, p, and there
are eight coins in general circulation:

    1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).

It is possible to make £2 in the following way:

    1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?

73682
"""

def main():
    print(rways(200, all_coins))

# Best performance puts the largest coins first.
all_coins = [200, 100, 50, 20, 10, 5, 2, 1]

def rways(remaining, coins):
    if len(coins) == 0:
        if remaining == 0:
            return 1
        else:
            return 0

    coin = coins[0]
    others = coins[1:]

    total = 0
    for r in range(remaining, -1, -coin):
        total += rways(r, others)

    return total

if __name__ == '__main__':
    main()
