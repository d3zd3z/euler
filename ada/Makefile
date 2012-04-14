all:
	@echo "Please specify a target"
	@false

GNAT_FLAGS = -g -gnatwa -gnatyy -gnat12 -gnato -O2

pr%: .force
	gnatmake -s $(GNAT_FLAGS) $@

clean:
	for i in pr[0-9][0-9][0-9]; do \
		gnatclean $$i; \
	done

.PHONY: .force
