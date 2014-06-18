# Build vala executables.

VALAC = valac
VALAFLAGS = -X -O0 -g

all:
	echo Please specify which problem to build.

%: %.vala
	$(VALAC) -o $@ $(VALAFLAGS) $^

%.c: %.vala
	$(VALAC) $(VALAFLAGS) -C $^

# Extra dependencies
pr007:: sieve.vala
pr010:: sieve.vala

clean:
	rm -rf pr[0-9][0-9][0-9]

.PHONY: clean
