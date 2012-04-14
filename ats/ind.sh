#! /bin/sh

# Run indent on the given C file.  Does some stuff to fix up ATS
# output so that indent can handle it.

indent -fc1 -linux "$@"

for i in "$@"; do rm -f "${i}~"; done
