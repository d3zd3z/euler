# Simple build.

SRC = $(wildcard *.swift)

SWIFTC = swiftc
SWIFT_FLAGS = -O -g

euler: $(SRC)
	$(SWIFTC) $(SWIFT_FLAGS) -o $@ $(SRC)

clean:
	rm -f euler

.PHONY: clean
