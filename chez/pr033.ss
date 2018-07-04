;;; Problem 33
;;;
;;; 20 December 2002
;;;
;;;
;;; The fraction ^49/[98] is a curious fraction, as an inexperienced
;;; mathematician in attempting to simplify it may incorrectly believe that ^
;;; 49/[98] = ^4/[8], which is correct, is obtained by cancelling the 9s.
;;;
;;; We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
;;; examples.
;;;
;;; There are exactly four non-trivial examples of this type of fraction, less
;;; than one in value, and containing two digits in the numerator and
;;; denominator.
;;;
;;; If the product of these four fractions is given in its lowest common
;;; terms, find the value of the denominator.
;;;
;;; 100

#!r6rs

(import
  (rnrs base (6))
  (rnrs io simple (6))
  (rnrs control (6)))

(define (frac? a b)
  (let ([an (div a 10)]
	[am (mod a 10)]
	[bn (div b 10)]
	[bm (mod b 10)])
    (or (and (= an bm) (> bn 0) (= (* am b) (* bn a)))
	(and (= am bn) (> bm 0) (= (* an b) (* bm a))))))

(define (euler-33)
  (define total 1)
  (let loop ([a 10]
	     [b 11])
    (cond ([= a 100] #f)
	  ([= b 100] (loop (+ a 1) (+ a 2)))
	  (else
	    (when (frac? a b)
	      (set! total (* total (/ a b))))
	    (loop a (+ b 1)))))
  (denominator total))

(define (main)
  (display (euler-33))
  (newline))
(main)
