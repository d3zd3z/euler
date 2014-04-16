:- module pr019.

% Problem 19
%
% 14 June 2002
%
% You are given the following information, but you may prefer to do some
% research for yourself.
%
%   • 1 Jan 1900 was a Monday.
%   • Thirty days has September,
%     April, June and November.
%     All the rest have thirty-one,
%     Saving February alone,
%     Which has twenty-eight, rain or shine.
%     And on leap years, twenty-nine.
%   • A leap year occurs on any year evenly divisible by 4, but not on a
%     century unless it is divisible by 400.
%
% How many Sundays fell on the first of the month during the twentieth
% century (1 Jan 1901 to 31 Dec 2000)?
%
% 171

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module calendar.
:- import_module int.
:- import_module list.
:- import_module string.

main(!IO) :-
    Start = det_init_date(1901, january, 1, 0, 0, 0, 0),
    Stop = det_init_date(2000, december, 2, 0, 0, 0, 0),
    foldl_months(count_sunday, Start, Stop, 0, Answer),
    io.print(Answer, !IO),
    io.nl(!IO).

:- pred count_sunday(date::in, int::in, int::out) is det.
count_sunday(Day, !Count) :-
    ( if day_of_week(Day) = sunday then
        !:Count = !.Count + 1
    else
        true
    ).


:- pred foldl_months(pred(date, A, A), date, date, A, A).
:- mode foldl_months(pred(in, in, out) is det, in, in, in, out) is det.
foldl_months(Pred, !.Curr, End, !Acc) :-
    compare(Res, !.Curr, End),
    (
        ( Res = (<)
        ; Res = (=)
        ),
        Pred(!.Curr, !Acc),
        add_duration(init_duration(0, 1, 0, 0, 0, 0, 0), !Curr),
        foldl_months(Pred, !.Curr, End, !Acc)
    ;
        Res = (>)
    ).
