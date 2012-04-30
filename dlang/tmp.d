import std.stdio;
import std.algorithm;
import std.conv;

// This doesn't work with gdc.
void main() {
    import std.algorithm;
    auto tmp = to!(char[])("12345");
    reverse(tmp);
    writeln(tmp);
}
