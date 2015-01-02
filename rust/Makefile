# Build the problems.

RUSTC = rustc
RUST_FLAGS = -C prefer-dynamic -C rpath -O -g
# RUST_FLAGS := -C prefer-dynamic -g
# RUST_FLAGS := $(RUST_FLAGS) -Z time-passes

CARGO_BUILD_FLAGS := --release

all: euler

probs := $(sort $(patsubst src/%.rs,%,$(wildcard src/pr[0-9][0-9][0-9]*.rs)))

euler: .force
	cargo build $(CARGO_BUILD_FLAGS)

clean:
	cargo clean

.PHONY: all .force clean
