! Problem 22
!
! 19 July 2002
!
!
! Using names.txt (right click and 'Save Link/Target As...'), a
! 46K text file containing over five-thousand first names,
! begin by sorting it into alphabetical order. Then working out
! the alphabetical value for each name, multiply this value by
! its alphabetical position in the list to obtain a name score.
!
! For example, when the list is sorted into alphabetical order,
! COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th
! name in the list. So, COLIN would obtain a score of 938 × 53
! = 49714.
!
! What is the total of all the name scores in the file?

USING: ascii io.encodings.ascii io.files kernel math sequences
sorting splitting ;
IN: euler.pr22

: source ( -- seq )
    "vocab:euler/pr22/names.txt" ascii file-contents
    [ quotable? ] filter "," split ;

: alpha-value ( str -- n )
    >lower [ CHAR: a - 1 + ] map-sum ;

: euler-22 ( -- n )
    source natural-sort
    [ 1 + swap alpha-value * ] map-index
    sum ;
