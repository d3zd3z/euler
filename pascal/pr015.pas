(*
 * Problem 15
 *
 * 19 April 2002
 *
 * Starting in the top left corner of a 2x2 grid, there are 6 routes (without
 * backtracking) to the bottom right corner.
 *
 * [p_015]
 *
 * How many routes are there through a 20x20 grid?
 *
 * 137846528820
 *)

program pr015;

type
  baseint = int64;

const
  steps = 20;

  procedure init(var elements : array of baseint);
  var
    i : integer;
  begin
    for i := low(elements) to high(elements) do
      elements[i] := 1;
  end;

  procedure bump(var elements : array of baseint);
  var
    i : integer;
  begin
    for i := low(elements) to high(elements) - 1 do
      begin
	elements[i+1] := elements[i+1] + elements[i];
      end;
  end;

var
  values : array[1 .. steps + 1] of baseint;
  i : integer;
begin
  init(values);
  for i := 1 to steps do
    bump(values);
  writeln(values[high(values)]);
end.
