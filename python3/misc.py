# Miscellaneous utilities.

def reverse_number(n, base=10):
    result = 0
    while n > 0:
        result = result * base + n % base
        n //= base
    return result

def is_palindrome(n, base=10):
    return n == reverse_number(n, base)

def isqrt(x):
    if x < 0:
        raise ValueError('square root not defined for negative numbers')
    n = int(x)
    if n == 0:
        return 0
    a, b = divmod(n.bit_length(), 2)
    x = 2**(a+b)
    while True:
        y = (x + n//x)//2
        if y >= x:
            return x
        x = y
