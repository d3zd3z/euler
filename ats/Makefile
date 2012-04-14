# Build named problems.

all:
	@echo Please specify target to build.
	@false

%: %.dats
	atscc -O -o $@ $^

clean:
	rm -f *.o *_dats.c pr[0-9]

always:
.PHONY: always
