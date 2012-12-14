# Building bigloo programs.

BIGLOO_SCM_FLAGS = -O6
BIGLOO_LINK_FLAGS =

all:
	echo Please specify which problem to build.

%: %.o
	bigloo -o $@ $(BIGLOO_LINK_FLAGS) $^

%.o: %.scm
	bigloo -c $(BIGLOO_SCM_FLAGS) $*.scm

pr007:: sieve.o
pr010:: sieve.o
pr011:: utilities.o
pr012:: sieve.o utilities.o
pr014:: utilities.o

clean:
	rm -f *.o
	rm -f pr[0-9][0-9][0-9]

.PHONY: clean all
