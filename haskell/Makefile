# Build named problems.

all:
	@echo Please specify target to build.
	@false

%: %.hs
	ghc -O --make -o $@ $@.hs

clean:
	rm -f *.o *.hi pr[0-9] pr[0-9][0-9] pr[0-9][0-9][0-9]
