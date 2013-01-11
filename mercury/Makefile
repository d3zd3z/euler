all:
	echo Please specify which problem to build.

%: %.m .force
	mmc --make $@

clean:
	rm -rf Mercury
	rm -rf *.mh *.err
	rm -rf pr[0-9][0-9][0-9]

.PHONY: .force
