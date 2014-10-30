# Build the problems.

RUSTC = rustc
RUST_FLAGS = -C prefer-dynamic -C rpath -O -g
# RUST_FLAGS := -C prefer-dynamic -g
# RUST_FLAGS := $(RUST_FLAGS) -Z time-passes

CARGO_BUILD_FLAGS := --release

all: euler

probs := $(sort $(patsubst src/%.rs,%,$(wildcard src/pr[0-9][0-9][0-9]*.rs)))

euler: $(wildcard *.rs) src/plist.rs
	@echo "    RUST " $@
	@cargo build $(CARGO_BUILD_FLAGS)

src/plist.rs: .force
	@echo "     GEN " $@
	@echo "// Auto generate" > $@.tmp
	@echo "" >> $@.tmp
	@echo "pub use super::Problem;" >> $@.tmp
	@echo "" >> $@.tmp
	@for p in $(probs); do echo "#[path=\"$$p.rs\"] mod $$p;"; done >> $@.tmp
	@echo "" >> $@.tmp
	@echo "pub fn make() -> Vec<Box<Problem + 'static>> {" >> $@.tmp
	@echo "    let mut probs = Vec::new();" >> $@.tmp
	@for p in $(probs); do echo "    add_problem!(probs, $$p::Solution);"; done >> $@.tmp
	@echo "    probs" >> $@.tmp
	@echo "}" >> $@.tmp
	@etc/move-if-change $@.tmp $@

clean:
	rm -f src/plist.rs
	cargo clean

.PHONY: all .force clean
