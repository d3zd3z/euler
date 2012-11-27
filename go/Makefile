# Build as desired:

all:
	@echo "Please specify a target"
	@false

pr%: .force
	GOPATH=$(PWD) go build $@

.PHONY: .force

clean:
	rm -f bin/*
	rm -f src/*/*.6
	rm -rf src/*/_obj
	rm -f src/*/pr[0-9]
	rm -f src/*/pr[0-9][0-9]
	rm -f src/*/pr[0-9][0-9][0-9]
