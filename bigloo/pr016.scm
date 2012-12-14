;;; Problem 16
;;;
;;; 03 May 2002
;;;
;;; 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
;;;
;;; What is the sum of the digits of the number 2^1000?
;;;
;;; 1366

(module pr016
  (main main))

;;; It seems that 'expt' in Bigloo doesn't promote to a bignum, and
;;; just gives zero for a large value.  Here's a simple implementation
;;; of expt that works with integer powers.

(define (integer-expt base power)
  (let loop ((base base)
	     (power power)
	     (result 1))
    (if (zero? power)
      result
      (loop (* base base)
	    (quotient power 2)
	    (if (odd? power)
	      (* result base)
	      result)))))

(define (sum-digits n)
  (let loop ((n n)
	     (total 0))
    (if (zero? n) total
      (loop (quotient n 10)
	    (+ total (remainder n 10))))))

(define (euler-16)
  (sum-digits (integer-expt 2 1000)))

(define (main argv)
  (display (euler-16))
  (newline))
