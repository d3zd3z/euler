# Build it all

FSFLAGS = --nologo
FSC = fsharpc

pr%.exe: pr%.fs euler.dll
	$(FSC) $(FSFLAGS) -r:euler.dll pr$*.fs

libs = misc.fsi misc.fs sieve.fsi sieve.fs \
       miller.fsi miller.fs

euler.dll: $(libs)
	$(FSC) $(FSFLAGS) --target:library -o:$@ $(libs)

clean:
	rm -f *.exe
	rm -f *.dll

.PHONY: clean
