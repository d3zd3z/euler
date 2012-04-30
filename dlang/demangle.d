// Demangle utility.

// Copied from the demangle.d source.
import std.stdio;
import std.ascii;
import std.demangle;
private import core.stdc.stdio;

void main() {
    string buffer;
    bool inword;
    int c;

    while ((c = fgetc(core.stdc.stdio.stdin)) != EOF) {
	if (inword) {
	    if (c == '_' || isAlphaNum(c))
		buffer ~= cast(char) c;
	    else {
		inword = false;
		write(demangle(buffer), cast(char) c);
	    }
	} else {
	    if (c == '_' || isAlpha(c)) {
		inword = true;
		buffer.length = 0;
		buffer ~= cast(char) c;
	    } else
		write(cast(char) c);
	}
    }
    if (inword)
	write(demangle(buffer));
}
