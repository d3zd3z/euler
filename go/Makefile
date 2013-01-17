# Build as desired:

all:
	@echo "Please specify a target"
	@false

# GOFLAGS = -compiler gccgo -x -gccgoflags '-O3'

pr%: .force
	@GOPATH=$(PWD) go build $(GOFLAGS) $@

.PHONY: .force

clean:
	rm -f pr[0-9][0-9][0-9]
