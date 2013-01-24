all: euler.byte
native: euler.native

euler.%: FORCE
	ocamlbuild $@

.PHONY: FORCE

clean:
	ocamlbuild -clean
