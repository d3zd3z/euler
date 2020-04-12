all: _build/default/euler.exe

run: all
	./_build/default/euler.exe all

.PHONY: all run FORCE

_build/default/euler.exe: FORCE
	dune build

clean:
	dune clean
