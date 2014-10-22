all: euler.byte
native: euler.native

euler.%: FORCE
	ocamlbuild -j 16 $@

.PHONY: FORCE

clean:
	ocamlbuild -clean
