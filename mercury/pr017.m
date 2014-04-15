:- module pr017.

% Problem 17
%
% 17 May 2002
%
% If the numbers 1 to 5 are written out in words: one, two, three, four,
% five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
%
% If all the numbers from 1 to 1000 (one thousand) inclusive were written
% out in words, how many letters would be used?
%
% NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
% forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
% 20 letters. The use of "and" when writing out numbers is in compliance
% with British usage.
%
% 21124

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module char.
:- import_module exception.
:- import_module int.
:- import_module list.
:- import_module string.

main(!IO) :-
    Answer = fold_up(count_accum, 1, 1000, 0),
    % fold_up(showit, 1, 1000, !IO),
    io.print(Answer, !IO),
    io.nl(!IO).

% For debugging, show the conversion of a number.
:- pred showit(int::in, io::di, io::uo) is det.
showit(N, !IO) :-
    ( if spoken(N, Text) then
        Words = Text
    else
        Words = "out of range"
    ),
    Count = count_letters(Words),
    io.format("%4d: (%3d) %s\n", [i(N), i(Count), s(Words)], !IO).

:- func count_accum(int, int) = int.
count_accum(Num, Accum) = Result :-
    ( if spoken(Num, Text) then
        Result = Accum + count_letters(Text)
    else
        throw(software_error("Out of range"))
    ).


% Count the number of letters in the given word.
:- func count_letters(string) = int.
count_letters(Text) = Count :-
    Count = foldl(letter_counter, Text, 0).

:- func letter_counter(char, int) = int.
letter_counter(Ch, Accum) =
    ( if is_alpha(Ch) then Accum + 1 else Accum ).

% Convert the number 1-1000 to a spoken representation.  Fails if outside of
% this range.
:- pred spoken(int::in, string::out) is semidet.
spoken(N, Text) :-
    ( if N = 1000 then
        Text = "one thousand"
    else if N < 20 then
        smalls(N, Text)
    else if N < 100, N mod 10 = 0 then
        tens(N div 10, Text)
    else if N < 100 then
        tens(N div 10, T1),
        smalls(N mod 10, T2),
        Text = T1 ++ " " ++ T2
    else if N < 1000, N mod 100 = 0 then
        spoken(N div 100, T1),
        Text = T1 ++ " hundred"
    else if N < 1000 then
        spoken(N div 100, T1),
        spoken(N mod 100, T2),
        Text = T1 ++ " hundred and " ++ T2
    else
        fail
    ).

:- pred smalls(int::in, string::out) is semidet.
smalls(N, Name) :-
    Words = ["one", "two", "three", "four", "five", "six", "seven", "eight",
             "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
             "sixteen", "seventeen", "eighteen", "nineteen"],
    index1(Words, N, Name).

:- pred tens(int::in, string::out) is semidet.
tens(N, Name) :-
    Words = ["twenty", "thirty", "forty", "fifty", "sixty",
             "seventy", "eighty", "ninety"],
    index1(Words, N-1, Name).
