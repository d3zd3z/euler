#! /usr/bin/guile -s
!#

;;; Problem 26
;;;
;;; 13 September 2002
;;;
;;;
;;; A unit fraction contains 1 in the numerator. The decimal representation of
;;; the unit fractions with denominators 2 to 10 are given:
;;;
;;;     ^1/[2]  =  0.5
;;;     ^1/[3]  =  0.(3)
;;;     ^1/[4]  =  0.25
;;;     ^1/[5]  =  0.2
;;;     ^1/[6]  =  0.1(6)
;;;     ^1/[7]  =  0.(142857)
;;;     ^1/[8]  =  0.125
;;;     ^1/[9]  =  0.(1)
;;;     ^1/[10] =  0.1
;;;
;;; Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can
;;; be seen that ^1/[7] has a 6-digit recurring cycle.
;;;
;;; Find the value of d < 1000 for which ^1/[d] contains the longest recurring
;;; cycle in its decimal fraction part.
;;;
;;; 983

;;; It is only necessary to search the primes.

(add-to-load-path (dirname (current-filename)))
(use-modules (sieve))

;;; Solve 10^k for 1 (mod n).
;;; Should only be called for n >= 7.  If (zero? (remainder 10 n)) it
;;; won't terminate.
(define (dlog n)
  (let loop ((k 1))
    (if (= 1 (remainder (expt 10 k) n))
      k
      (loop (1+ k)))))

(define (euler-26)
  (define sieve (make-sieve))
  (let loop ((p 7)
	     (largest 0)
	     (largest-p 0))
    (if (>= p 1000) largest-p
      (let ((digits (dlog p))
	    (next-p (next-prime sieve p)))
	(if (> digits largest)
	  (loop next-p digits p)
	  (loop next-p largest largest-p))))))

(define (main)
  (display (euler-26))
  (newline))
(main)
