# Building chicken programs.

CSC_SCM_FLAGS = -J
CSC_LINK_FLAGS =

all:
	echo Please specify which problem to build.

%: %.o
	csc -o $@ $(CSC_LINK_FLAGS) $^

%.o: %.scm
	csc -c $(CSC_SCM_FLAGS) $*.scm

pr007:: sieve.o

clean:
	rm -f *.o
	rm -f pr[0-9][0-9][0-9]
	rm -f *.import.scm

.PHONY: clean
