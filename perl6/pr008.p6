#! /usr/bin/perl6

use v6;

######################################################################
# Problem 8
#
# 11 January 2002
#
# Find the greatest product of five consecutive digits in the 1000-digit
# number.
#
# 73167176531330624919225119674426574742355349194934
# 96983520312774506326239578318016984801869478851843
# 85861560789112949495459501737958331952853208805511
# 12540698747158523863050715693290963295227443043557
# 66896648950445244523161731856403098711121722383113
# 62229893423380308135336276614282806444486645238749
# 30358907296290491560440772390713810515859307960866
# 70172427121883998797908792274921901699720888093776
# 65727333001053367881220235421809751254540594752243
# 52584907711670556013604839586446706324415722155397
# 53697817977846174064955149290862569321978468622482
# 83972241375657056057490261407972968652414535100474
# 82166370484403199890008895243450658541227588666881
# 16427171479924442928230863465674813919123162824586
# 17866458359124566529476545682848912883142607690042
# 24219022671055626321111109370544217506941658960408
# 07198403850962455444362981230987879927244284909188
# 84580156166097919133875499200524063689912560717606
# 05886116467109405077541002256983155200055935729725
# 71636269561882670428252483600823257530420752963450
#
######################################################################
# 40824

my $src = '';
$src ~= '73167176531330624919225119674426574742355349194934';
$src ~= '96983520312774506326239578318016984801869478851843';
$src ~= '85861560789112949495459501737958331952853208805511';
$src ~= '12540698747158523863050715693290963295227443043557';
$src ~= '66896648950445244523161731856403098711121722383113';
$src ~= '62229893423380308135336276614282806444486645238749';
$src ~= '30358907296290491560440772390713810515859307960866';
$src ~= '70172427121883998797908792274921901699720888093776';
$src ~= '65727333001053367881220235421809751254540594752243';
$src ~= '52584907711670556013604839586446706324415722155397';
$src ~= '53697817977846174064955149290862569321978468622482';
$src ~= '83972241375657056057490261407972968652414535100474';
$src ~= '82166370484403199890008895243450658541227588666881';
$src ~= '16427171479924442928230863465674813919123162824586';
$src ~= '17866458359124566529476545682848912883142607690042';
$src ~= '24219022671055626321111109370544217506941658960408';
$src ~= '07198403850962455444362981230987879927244284909188';
$src ~= '84580156166097919133875499200524063689912560717606';
$src ~= '05886116467109405077541002256983155200055935729725';
$src ~= '71636269561882670428252483600823257530420752963450';

sub piece(Int $offset) returns Int {
    [*] ($offset..$offset+4).map({$src.substr($_, 1)})
}

say [max] (0..995).map({piece($_)});