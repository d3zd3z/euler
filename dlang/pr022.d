/*
 * Problem 22
 *
 * 19 July 2002
 *
 *
 * Using names.txt (right click and 'Save Link/Target As...'), a 46K
 * text file containing over five-thousand first names, begin by
 * sorting it into alphabetical order. Then working out the
 * alphabetical value for each name, multiply this value by its
 * alphabetical position in the list to obtain a name score.
 *
 * For example, when the list is sorted into alphabetical order, COLIN,
 * which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the
 * list. So, COLIN would obtain a score of 938 × 53 = 49714.
 *
 * What is the total of all the name scores in the file?
 */

import std.algorithm;
import std.array;
import std.range;
import std.stdio;

uint euler22() {
    auto fd = File("../haskell/names.txt", "r");
    auto names = fd.readln();
    auto s1 = map!(getName)(splitter(names, ','));
    auto s2 = sort!("a.text < b.text")(array(s1));
    auto sum = 0;
    foreach (name, index; lockstep(s2, iota(1, s2.length + 1))) {
	sum += name.score * index;
    }
    return sum;
}

struct Name {
    string text;
    uint score;
}

Name getName(string name) {
    name = name[1 .. $-1];
    auto score = reduce!"a+b"(map!"a - 'A' + 1"(name));
    return Name(name, score);
}

unittest {
    assert(euler22() == 871198282);
}
