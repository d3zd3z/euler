:- module pr022.

% Problem 22
%
% 19 July 2002
%
% Using names.txt (right click and 'Save Link/Target As...'), a 46K text
% file containing over five-thousand first names, begin by sorting it into
% alphabetical order. Then working out the alphabetical value for each name,
% multiply this value by its alphabetical position in the list to obtain a
% name score.
%
% For example, when the list is sorted into alphabetical order, COLIN, which
% is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
% COLIN would obtain a score of 938 × 53 = 49714.
%
% What is the total of all the name scores in the file?
%
% 871198282

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module char.
:- import_module int.
:- import_module list.
:- import_module require.
:- import_module string.

main(!IO) :-
    read_words("../haskell/names.txt", Unsorted, !IO),
    sort(Unsorted, Names),
    Numbers = 1 `..` length(Names),
    map_corresponding(word_value, Names, Numbers, Values),
    Answer = foldl(plus, Values, 0),
    io.print(Answer, !IO),
    io.nl(!IO).

% Compute the "word value" as described by the problem.
:- pred word_value(string::in, int::in, int::out) is det.
word_value(Word, Position, Value) :-
    foldl((pred(Ch::in, Sum0::in, Sum::out) is det :-
            Sum = Sum0 + to_int(Ch) - to_int('A') + 1),
        Word, 0, ThisValue),
    Value = Position * ThisValue.

:- pred read_words(string::in, list(string)::out, io::di, io::uo) is det.
read_words(Name, Words, !IO) :-
    io.open_input(Name, Result, !IO),
    (
        Result = ok(Stream),
        % read_open_quot(Stream, [], Words, !IO),
        read_machine(Stream, open_quot, [], [], Words, !IO),
        io.close_input(Stream, !IO)
    ;
        Result = error(Error),
        error(error_message(Error))
    ).

% State machine for reading.
:- type parse_state
    --->    open_quot
    ;       name
    ;       comma.

% Read the comma-separated list of double-quoted words.
:- pred read_machine(input_stream::in,
    parse_state::in,
    list(char)::in,   % Name being built
    list(string)::in, list(string)::out, % Word list
    io::di, io::uo) is det.
read_machine(Stream, State, Name, !Words, !IO) :-
    io.read_char(Stream, Result, !IO),
    (
        Result = error(Error),
        error(error_message(Error))
    ;
        Result = eof,
        ( if State = comma then
            !:Words = reverse(!.Words)
            % Proper finish.
        else
            error("Unexpected end of file")
        )
    ;
        Result = ok(Char),
        (
            State = open_quot,
            ( if Char = ('"') then
                read_machine(Stream, name, [], !Words, !IO)
            else
                error(format("Unexpected character '%c'", [c(Char)]))
            )
        ;
            State = name,
            ( if Char = ('"') then
                from_char_list(reverse(Name), NameString),
                !:Words = [NameString | !.Words],
                read_machine(Stream, comma, [], !Words, !IO)
            else if is_upper(Char) then
                Name2 = [Char | Name],
                read_machine(Stream, name, Name2, !Words, !IO)
            else
                error(format("Unexpected character '%c'", [c(Char)]))
            )
        ;
            State = comma,
            ( if Char = (',') then
                read_machine(Stream, open_quot, Name, !Words, !IO)
            else
                error(format("Unexpected character '%c'", [c(Char)]))
            )
        )
    ).
