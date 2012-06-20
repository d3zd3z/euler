# Various build rules.

FC = gfortran
FFLAGS = -fcheck=all -Wall -O3 -g

%.mod %.o: %.f90
	$(FC) -c $(FFLAGS) $*.f90

PROBLEMS = pr001.o pr002.o pr003.o pr004.o pr005.o pr006.o \
	   pr007.o pr008.o pr009.o pr010.o

MAIN = main.o problems.o primes.o

all: main

clean:
	rm -f *.o *.mod
	rm -f problems.f90
	rm -f main

main: $(MAIN) $(PROBLEMS)
	$(FC) -o $@ $(MAIN) $(PROBLEMS)

main.o: problems.mod

pr010: pr010.o primes.o
	$(FC) -o $@ pr010.o primes.o

problems.f90: .force
	python ./etc/generate.py $(PROBLEMS) > $@.tmp
	./etc/move-if-change $@.tmp $@

.force:
.PHONY: .force

# Dependencies
pr010.o: primes.mod
