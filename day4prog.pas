program day4;

Uses sysutils, strutils;

type
  tlines = array[1..2000] of string;

{ https://www.pascal-programming.info/articles/sorting.php }
procedure sort(var lines: tlines; size: integer);
var
  i, j: integer;
  e: string;

begin
  for i := 2 to size do begin
    e := lines[i];
    j := i;
    while ((j > 1) AND (lines[j - 1] > e)) do begin
      lines[j] := lines[j - 1];
      j := j - 1;
    end;
    lines[j] := e;
  end;
end;

var
  idx: integer = 0;
  i, j: integer;
  lines: tlines;
  l: string;
  min: integer;
  started: integer;
  id: integer;
  max: integer = 0;
  totalMinsSlept: array[1..5000] of integer;
  countMinsSlept: array[1..5000, 0..59] of integer;

begin
  while not eof() do
  begin
    idx := idx + 1;
    readln(lines[idx]);
  end;

  sort(lines, idx);

  for i := 1 to idx do
  begin
     l := lines[i];
     min := strtoint(copy(l, 16, 2));

     if (AnsiContainsText(l, 'Guard')) then
     begin
       id := strtoint(copy(ExtractWord(5, l, StdWordDelims), 2));
     end else if (AnsiContainsText(l, 'falls')) then
     begin
       started := min;
     end else
       for j := started to min do
       begin
         totalMinsSlept[id] := totalMinsSlept[id] + 1;
         countMinsSlept[id, j] := countMinsSlept[id, j] + 1;
       end;
  end;

  { Strategy 1 }
  for j := 1 to 5000 do
    if (totalMinsSlept[j] > max) then
    begin
      max := totalMinsSlept[j];
      id := j;
    end;

  max := 0;

  for j := 0 to 59 do
    if (countMinsSlept[id, j] > max) then
    begin
      max := countMinsSlept[id, j];
      min := j;
    end;

  writeln(id * min);

  { Strategy 2 }
  max := 0;

  for j := 1 to 5000 do
    for i := 0 to 59 do
      if countMinsSlept[j, i] > max then
      begin
        max := countMinsSlept[j, i];
        id := j;
        min := i;
      end;

  writeln(id * min);
end.

