#! /usr/bin/perl6

use v6;

die "Expecting an argument" unless @*ARGS == 1;
# die "Expecting a single integer" unless @*ARGS[0] ~~ /^(<[1..9]><[0..9]>*)$/;

my $problem = @*ARGS[0] + 0; # TODO: Better idiom in Perl6?
$problem = sprintf "%03d", $problem;
my $url = "../haskell/probs/problem-$problem.html";

my $in = open "w3m -dump -cols 75 $url", :p;
my $out = open "pr$problem.p6", :w;

# Are heredocs not implemented?
$out.say('#! /usr/bin/perl6');
$out.say('');
$out.say('use v6;');
$out.say('');
$out.say('######################################################################');

my $line;
repeat {
    $line = $in.get;
} until $line ~~ /^Problem /;

$out.say("# $line");
my $last = $line;
for $in.lines -> $line {
    last if $line ~~ /Project\ Euler\ Copyright.*/;
    if $line ne $last || $line !~~ /^\s*$/ {
        if $line.chars {
            $out.say("# $line");
        } else {
            $out.say("#");
        }
    } else {
    }
    $last = $line;
}

$out.say("######################################################################");
$out.close();
