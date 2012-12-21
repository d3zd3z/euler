(*
 * Problem 17
 *
 * 17 May 2002
 *
 * If the numbers 1 to 5 are written out in words: one, two, three, four,
 * five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
 *
 * If all the numbers from 1 to 1000 (one thousand) inclusive were written
 * out in words, how many letters would be used?
 *
 * NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
 * forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
 * 20 letters. The use of "and" when writing out numbers is in compliance
 * with British usage.
 *
 * 21124
 *)

{$mode objfpc}
program pr017;

uses sysutils;

const
  ones : array[1..19] of ansistring = (
    'one', 'two', 'three', 'four', 'five', 'six', 'seven',
    'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen',
    'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen',
    'nineteen');

  tens : array[1..9] of ansistring = (
    'ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty',
    'seventy', 'eighty', 'ninety');

  function toEnglish(number : longint) : ansistring;
  var
    addSpace : boolean = false;

    procedure add(word : ansistring);
    begin
      if addSpace then
	toEnglish := toEnglish + ' ';
      toEnglish := toEnglish + word;
      addSpace := true;
    end;
  begin
    toEnglish := '';

    if number > 1000 then
      raise exception.create('Number too large');

    if number = 1000 then
      toEnglish := 'one thousand'
    else begin
      if number >= 100 then begin
	add(ones[number div 100]);
	add('hundred');
	number := number mod 100;
	if number > 0 then
	  add('and');
      end;

      if number >= 20 then begin
	add(tens[number div 10]);
	number := number mod 10;
	if number > 0 then begin
	  addSpace := false;
	  add('-');
	  addSpace := false;
	end;
      end;

      if number > 0 then
	add(ones[number]);
    end;
  end;

  function countLetters(text : ansistring) : longint;
  var
    ch : char;
  begin
    countLetters := 0;
    for ch in text do begin
      if (ch >= 'a') and (ch <= 'z') then
	countLetters := countLetters + 1;
    end;
  end;

var
  i : longint;
  total : longint = 0;
begin
  for i := 1 to 1000 do begin
    total := total + countLetters(toEnglish(i));
  end;
  writeln(total)
end.
