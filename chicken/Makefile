# Building chicken programs.

CSC_SCM_FLAGS =
CSC_LINK_FLAGS =

%: %.o
	csc -o $@ $(CSC_SCM_FLAGS) $^

%.o: %.scm
	csc -c $(CSC_LINK_FLAGS) $*.scm

pr007:: sieve.o

clean:
	rm -f *.o
	rm -f pr[0-9][0-9][0-9]

.PHONY: clean
