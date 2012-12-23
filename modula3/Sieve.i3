(* Prime number sieve *)

INTERFACE Sieve;

TYPE
  T <: PUBLIC;
  PUBLIC = OBJECT
  METHODS
    init() : T;

    isPrime(n : INTEGER) : BOOLEAN;
    nextPrime(n : INTEGER) : INTEGER;
  END;

END Sieve.
