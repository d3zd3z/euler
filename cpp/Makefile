# Some basic rules to build this with dependencies.

CXX = g++ -MMD
CXXFLAGS = -std=c++11 -O3 -g -Wall

PROBS := $(sort $(wildcard pr[0-9][0-9][0-9].cpp))

OBJS := $(patsubst %.cpp,%.o,$(PROBS)) euler.o problems.o sieve.o
DEPS := $(patsubst %.o,%.d,$(OBJS))
NUMS := $(patsubst pr%.cpp,%,$(PROBS))

euler: $(OBJS)
	@echo '[LD]    '$@
	@$(CXX) -o $@ $(OBJS)

clean: .PHONY
	rm -f *.d *.o
	rm -f euler
	rm -f problems.cpp

%.o: %.cpp
	@echo '[C++]   '$*.cpp
	@$(CXX) $(CXXFLAGS) -c -o $@ $*.cpp

# TODO: Make this print nicer
problems.cpp: .force
	@echo '[GEN]   '$@
	@python etc/gen-problems.py $(NUMS) > $@.tmp
	@./etc/move-if-change $@.tmp $@

all: .force
	@echo $(PROBS)
	@echo $(DEPS)

.force: .PHONY
.PHONY:

-include $(DEPS)
