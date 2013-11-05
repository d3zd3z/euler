      * Problem 3
      *
      * 02 November 2001
      *
      * The prime factors of 13195 are 5, 7, 13 and 29.
      *
      * What is the largest prime factor of the number 600851475143 ?
      *
       identification division.
       program-id. euler-problem-003.

       environment division.
       configuration section.
       repository.
           function mod intrinsic.

       data division.
       working-storage section.
       01 working-number        pic 9(12) value 600851475143.
       01 temp                  pic 9(12).
       01 factor                pic 9(4)  value 2.

       procedure division.

           perform forever
               perform try-divisions
               if working-number = 1 then exit perform end-if
               perform advance-factor
           end-perform

           display factor

           stop run.

       try-divisions.
           perform forever

      * Open Cobol seems to get the math wrong here.  It seems that
      * function integer(a/b) will sometimes give 1 less than the
      * correct answer.  This results in the mod function returning the
      * modulus in some cases.
      * This seems to be fixed in GNU Cobol 2.0
               compute temp = mod (working-number, factor)
      
      *        if (temp = 0) or (temp = factor) then
      *            compute working-number = working-number / factor
               if (temp = 0) then
                   compute working-number = working-number / factor
               else
                   exit perform
               end-if
           end-perform.

       advance-factor.
           if factor = 2 then
               move 3 to factor
           else
               add 2 to factor
           end-if.
