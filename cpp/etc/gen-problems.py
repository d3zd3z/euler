#! /usr/bin/env python

import sys

if __name__ == '__main__':
    print '''// Auto-generated, do not edit.

#include <vector>
#include "problems.hpp"

namespace euler {
'''

    for problem in sys.argv[1:]:
        print("namespace pr{0} {{ void solve(); }}".format(problem))

    print '''const std::vector<Problem> problems {'''
    for problem in sys.argv[1:]:
        print("  {{ {0}, pr{1}::solve }},".format(int(problem), problem))
    print '''};
}'''
