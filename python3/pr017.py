#! /usr/bin/env python3

"""
Problem 17

17 May 2002

If the numbers 1 to 5 are written out in words: one, two, three, four,
five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written
out in words, how many letters would be used?

NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
20 letters. The use of "and" when writing out numbers is in compliance
with British usage.

21124
"""

ones = ['one', 'two', 'three', 'four', 'five', 'six', 'seven',
        'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen',
        'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen',
        'nineteen']
tens = ['ten', 'twenty', 'thirty', 'forty', 'fifty',
        'sixty', 'seventy', 'eighty', 'ninety']

def to_english(n):
    result = ''
    add_space = False

    def add(text):
        nonlocal result, add_space
        if add_space:
            result += ' '
        result += text
        add_space = True

    if n <= 0:
        raise Exception("Negative number")
    if n > 1000:
        raise Exception("Number too large")

    if n == 1000:
        return "one thousand"

    if n >= 100:
        add(ones[n // 100 - 1])
        add('hundred')
        n %= 100
        if n > 0:
            add('and')

    if n >= 20:
        add(tens[n // 10 - 1])
        n %= 10

        if n > 0:
            result += '-'
            add_space = False

    if n >= 1:
        add(ones[n - 1])

    return result

def main():
    count = 0
    for i in range(1, 1001):
        text = to_english(i)
        for ch in text:
            if ch.isalpha():
                count += 1
        # print("{:4} {}".format(i, to_english(i)))
    print(count)

if __name__ == '__main__':
    main()
