--  Miller-Rabin primality testing.

package Miller_Rabin is

   function Is_Prime (Number : Natural; K : Natural := 20) return Boolean;
   --  Perform the Miller-Rabin primality test on 'Number'.  If it returns
   --  False, Number is definitely not prime.  If it returns true, Number has
   --  a (1/4)**K probability of being prime.

end Miller_Rabin;
