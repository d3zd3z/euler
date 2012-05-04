// Drive the project Euler tests.

// This seems to be stretching what dmd can do.  It sort of works with
// dmd 2.059, but not every solution can build.  For example problem
// 21, generates a compiler assertion:
//  dmd: glue.c:686: virtual void FuncDeclaration::toObjFile(int): Assertion `!vthis->csym' failed.
// The version in gdc-4.6 doesn't allow formattedWrite at compile time.
// Maybe someday, this will work better.

import std.array;
import std.format;
import std.stdio;

const uint[] solutions = [
    20, /*21,*/ 22, 23, 25,
    ];

alias uint function() Test;
mixin(makeImports(solutions));
mixin(makeOperations(solutions));

string makeImports(const uint[] tests) {
    auto writer = appender!string();
    foreach (test; tests)
	formattedWrite(writer, "import pr%03d;\n", test);

    return writer.data;
}

string makeOperations(const uint[] tests) {
    auto writer = appender!string();
    formattedWrite(writer, "Test[uint] buildTests() {\n");
    formattedWrite(writer, "  Test[uint] result;\n");
    foreach (test; tests)
	formattedWrite(writer, "  result[%d] = &pr%03d.euler%d;\n", test, test, test);
    formattedWrite(writer, "  return result;\n}");
    return writer.data;
}

void main() {
    auto tests = buildTests();
    foreach (num, test; tests)
	writefln("%3d: %d", num, test());
}
