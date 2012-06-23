#! /usr/bin/env python3

import sys
import re

# Generate the problem module, based on the available problems.
# The assumption is that each problem is an external subroutine of the
# given name.

def module_name(n):
    if n.endswith(".o"):
        return n[:-2]
    else:
        return n

num_re = re.compile(r"""[0-9]*([0-9]+)[0-9]*""")
num_re = re.compile(r"""([0-9]+)""")
def module_index(n):
    m = num_re.search(n)
    if m:
        return int(m.group(1))
    else:
        raise Exception("problem doesn't have digits")

def gen(names):
    print("""! Auto generated, do not edit.

module problems

  implicit none

  abstract interface
    subroutine problem_call ()
    end subroutine
  end interface

  type :: one_problem
    integer :: index
    procedure (problem_call), pointer, nopass :: exec
  end type

  interface""")
    for name in names:
        name = module_name(name)
        print("    subroutine {} (); end subroutine".format(name))
    print("""  end interface

""")

    print("  type(one_problem), dimension({}) :: all_problems".format(len(names)))

    print("""

contains

  subroutine init()
    implicit none
""")
    n = 1
    for name in names:
        name = module_name(name)
        index = module_index(name)
        print("    all_problems({})%index = {}".format(n, index))
        print("    all_problems({})%exec => {}".format(n, name))
        n += 1
    print("""  end subroutine
""")
    print("end module problems")

if __name__ == '__main__':
    gen(sys.argv[1:])
