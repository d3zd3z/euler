      * A simple prime sieve, which can be parameterized as needed.
      * To use, define 'max-prime-number' as a constant giving the
      * desired size of the sieve.
      * This file should be pulled into the working-storage section.
       01 prime-data.
         02 primes              pic a
           occurs max-prime-number times
           value 'Y'.
         02 p                   pic 9(7) comp-5.
         02 q                   pic 9(7) comp-5.
         02 tmp                 pic 9(7) comp-5.
         02 sieve-limit         pic 9(7) comp-5.
