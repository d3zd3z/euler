# Build named problems.

all:
	@echo Please specify target to build.
	@false

%: %.hs always
	ghc -O --make -rtsopts -outputdir obj $@
	# ghc -O -prof -auto-all -rtsopts -outputdir obj $@

clean:
	rm -f *.o *.hi pr[0-9] pr[0-9][0-9] pr[0-9][0-9][0-9]
	rm -rf obj

always:
.PHONY: always
