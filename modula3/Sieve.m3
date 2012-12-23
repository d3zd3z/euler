(* Prime number sieve. *)

MODULE Sieve;

TYPE
  PBooleans = REF ARRAY OF BOOLEAN;

REVEAL
  T = PUBLIC BRANDED OBJECT
    size : INTEGER;
    primes : PBooleans;
  OVERRIDES
    init := Init;
    isPrime := IsPrime;
    nextPrime := NextPrime;
  END;

PROCEDURE Fill(self: T; size: INTEGER) =
  VAR
    pos := 2;
    n : INTEGER;
  BEGIN
    self.size := size;
    self.primes := NEW(PBooleans, size);

    FOR i := 0 TO size - 1 DO
      self.primes[i] := TRUE;
    END;
    self.primes[0] := FALSE;
    self.primes[1] := FALSE;

    WHILE pos < size DO
      IF self.primes[pos] THEN
        n := pos + pos;
        WHILE n < size DO
          self.primes[n] := FALSE;
          n := n + pos;
        END;
        IF pos = 2 THEN
          pos := 3;
        ELSE
          pos := pos + 2;
        END;
      ELSE
        pos := pos + 2;
      END;
    END;
  END Fill;

PROCEDURE Init(self: T): T =
  BEGIN
    Fill(self, 1024);
    RETURN self;
  END Init;

PROCEDURE NewLength(self: T; n : INTEGER) =
  VAR
    cur := NUMBER(self.primes^);
  BEGIN
    WHILE n >= cur DO
      cur := cur * 8;
    END;
    Fill(self, cur);
  END NewLength;

PROCEDURE IsPrime(self: T; n : INTEGER) : BOOLEAN =
  BEGIN
    IF n > NUMBER(self.primes^) THEN
      NewLength(self, n);
    END;

    RETURN self.primes[n];
  END IsPrime;

PROCEDURE NextPrime(self: T; n : INTEGER) : INTEGER =
  BEGIN
    IF n = 2 THEN
      RETURN 3;
    END;

    LOOP
      n := n + 2;
      IF IsPrime(self, n) THEN
        RETURN n;
      END;
    END;
      
  END NextPrime;

BEGIN
END Sieve.
