# Miscellaneous utilities.

def reverse_number(n, base=10):
    result = 0
    while n > 0:
        result = result * base + n % base
        n //= base
    return result

def is_palindrome(n, base=10):
    return n == reverse_number(n, base)
