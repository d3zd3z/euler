      * Problem 22
      *
      * 19 July 2002
      *
      * Using names.txt (right click and 'Save Link/Target As...'), a
      * 46K text file containing over five-thousand first names, begin
      * by sorting it into alphabetical order. Then working out the
      * alphabetical value for each name, multiply this value by its
      * alphabetical position in the list to obtain a name score.
      *
      * For example, when the list is sorted into alphabetical order,
      * COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th
      * name in the list. So, COLIN would obtain a score of 938 × 53 =
      * 49714.
      *
      * What is the total of all the name scores in the file?
      *
      * 871198282
      *
       identification division.
       program-id. euler-problem-022.

       environment division.
       input-output section.
       file-control.
           select names-file
             assign to "../haskell/names.txt"
             organization record binary sequential.

       data division.
       file section.
       fd names-file
           block contains 8192 characters
           record contains 1 characters.
       01 name-character pic x.
       working-storage section.

       01 number-of-names constant as 5163.
       01 name-buffers.
         02 names
           occurs number-of-names times
           indexed by name-count.
           03 name              pic x(11).
           03 name-value        pic 9(5).
         02 name-position     pic 9(3) comp-5.
         02 sub-pos           pic 9(3) comp-5.
         02 temp-char         pic x.
         02 temp-value        pic 9(6) comp-5.
         02 total             pic 9(9) comp-5 value 0.
         02 pos               pic 9(6).

       procedure division.

           move 0 to name-count.
           perform process-file.
           subtract 1 from name-count.
           sort names on ascending key name.
           perform compute-total.
           display total
           stop run.

       compute-total.
           perform varying pos from 1 by 1 until pos > name-count

             compute temp-value = pos * name-value (pos)
      D      display pos, ' ',
      D        name (pos), ' ', name-value (pos), ' ', temp-value
             add temp-value to total

           end-perform.

       process-file.
           perform name-start

           open input names-file

           perform forever
             read names-file
               at end exit perform
             end-read
             evaluate name-character
               when '"'
                 continue
               when ','
                 perform name-ending
               when other
                 perform name-add
             end-evaluate
           end-perform
           perform name-ending

           close names-file.

       name-start.
           move 0 to name-position
           add 1 to name-count
           if name-count < number-of-names then
             move spaces to name (name-count)
             move zero to name-value (name-count)
           end-if.

       name-add.
           add 1 to name-position
           move name-character
             to names (name-count) (name-position:1).

       name-ending.
           perform compute-name-value
      D    display 'Name: ', name-value (name-count), ' ',
      D     function trim(name (name-count), trailing)
           perform name-start.

       compute-name-value.
           perform varying sub-pos from 1 by 1
             until sub-pos > 11

             move name (name-count) (sub-pos:1) to temp-char
             evaluate temp-char
               when 'A' thru 'Z'
                 compute temp-value = function ord (temp-char) -
                   function ord ('A') + 1
                 end-compute
                 add temp-value to name-value (name-count)
             end-evaluate

           end-perform.
