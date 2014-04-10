#! /usr/bin/env python3

# This seems fairly obvious to implement this in Python for this
# particular exercise.

import os
import subprocess
import sys

def generate(problem, contents):
    name = 'pr{0:03}.erl'.format(problem)
    with open(name, 'x') as f:
        for line in contents:
            if len(line) > 0:
                print("%", line.decode(), file=f)
            else:
                print("%", file=f)
        print('''
-module(pr{0:03}).
-export([solve/0]).

solve() ->
	42. '''.format(problem), file=f)

        # os.chmod(name, 0o755)

def main():
    if len(sys.argv) != 2:
        print("Expecting a single argument")
        sys.exit(1)
    problem = int(sys.argv[1])
    p3 = '{0:03}'.format(problem)
    url = '../haskell/probs/problem-{0:03}.html'.format(problem)
    contents = subprocess.check_output(['w3m', '-dump', '-cols', '75',
        url]).splitlines()

    # Skip until we get to the problem statement.
    while not contents[0].startswith(b'Problem '):
        del contents[0]

    # Remove everything after the copyright line.
    for i in range(len(contents)):
        if contents[i].startswith(b'Project Euler Copyright'):
            del contents[i:]
            break

    # Remove blanks at the end.
    while contents[-1] == b'':
        del contents[-1]

    generate(problem, contents)

if __name__ == '__main__':
    main()
