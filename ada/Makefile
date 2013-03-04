all: main
not-all:
	@echo "Please specify a target"
	@false

GNAT_FLAGS = -g -gnata -gnatwa -gnatyy -gnat12 -gnato -O2 -j17

pr%: .force
	gnatmake -s $(GNAT_FLAGS) $@

main: problem_list.ads .force
	gnatmake -s $(GNAT_FLAGS) $@

problem_list.ads: generate_list
	./generate_list > $@

generate_list: .force
	gnatmake -s $(GNAT_FLAGS) $@

clean:
	for i in pr[0-9][0-9][0-9] main generate_list; do \
		gnatclean $$i; \
	done
	rm -f problem_list.ads

.PHONY: .force
