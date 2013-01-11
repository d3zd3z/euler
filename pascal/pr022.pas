(*
 * Problem 22
 *
 * 19 July 2002
 *
 * Using names.txt (right click and 'Save Link/Target As...'), a 46K text
 * file containing over five-thousand first names, begin by sorting it into
 * alphabetical order. Then working out the alphabetical value for each name,
 * multiply this value by its alphabetical position in the list to obtain a
 * name score.
 *
 * For example, when the list is sorted into alphabetical order, COLIN, which
 * is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
 * COLIN would obtain a score of 938 x 53 = 49714.
 *
 * What is the total of all the name scores in the file?
 *
 * 871198282
 *)

{$mode objfpc}
program pr022;

uses sysutils;

type
   Tname = record
      name : ansistring;
      value : longint;
   end;

var
   names : array of Tname;

   function nameValue(name : ansistring) : longint;
   var
      ch : char;
   begin
      result := 0;
      for ch in name do begin
	 { All the names are upper case, so this is simple. }
	 result := result + ord(ch) - ord('A') + 1;
      end;
   end;

   procedure addName(newName : ansistring);
   begin
      setlength(names, length(names) + 1);
      with names[high(names)] do begin
	 name := newName;
	 value := nameValue(newName);
      end;
   end;

   procedure readNames;
   var
      f	: text;
      ch	: char;
      name	: ansistring;

      procedure must(expect : char);
      begin
	 if ch <> expect then
	    raise exception.create('Unexpected character');
      end;

   begin
      setlength(names, 0);
      assign(f, '../haskell/names.txt');
      reset(f);
      while not eof(f) do begin
	 read(f, ch);
	 must('"');
	 name := '';

	 repeat
	    read(f, ch);
	    if ch = '"' then
	       break;
	    name := name + ch;
	 until false;

	 { Add the name }
	 addName(name);

	 if not eof(f) then begin
	    read(f, ch);
	    must(',');
	 end;
      end;
      close(f);
   end;
   
   { Insertion sort on the names.  Should be sufficient.  This is
     right out of wikipedia. }
   procedure sortNames;
   var
      item : Tname;
      i, iHole : longint;
   begin
      for i := low(names) + 1 to high(names) do begin
         item := names[i];
         iHole := i;
         while (iHole > low(names)) and (names[iHole-1].name > item.name) do begin
            names[iHole] := names[iHole-1];
            iHole := iHole - 1;
         end;
         if iHole <> i then
            names[iHole] := item;
      end;
   end;

var
   i : longint;
   total : longint = 0;

begin
   readNames;
   sortNames;
   for i := low(names) to high(names) do
      total := total + names[i].value * (i - low(names) + 1);
   writeln(total);
end.
