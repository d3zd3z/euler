:- module pr005.

% Problem 5
%
% 30 November 2001
%
% 2520 is the smallest number that can be divided by each of the numbers
% from 1 to 10 without any remainder.
%
% What is the smallest positive number that is evenly divisible by all of
% the numbers from 1 to 20?
%
% 232792560

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list, int, string.

main(!IO) :-
    Answer = int.fold_up(lcm, 1, 20, 1),
    io.format("%d\n", [i(Answer)], !IO).

:- func lcm(int, int) = int.
lcm(A, B) = (A div gcd(A, B)) * B.

:- func gcd(int, int) = (int) is det.
gcd(A, B) = C :-
    (if B = 0 then C = A else C = gcd(B, A mod B)).
