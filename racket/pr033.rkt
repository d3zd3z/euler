#lang racket

;;; Problem 33
;;;
;;; 20 December 2002
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

(define (frac-a-p? a b)
  (let-values ([(an am) (quotient/remainder a 10)]
               [(bn bm) (quotient/remainder b 10)])
    (or (and (= an bm)
             (positive? bn)
             (= (/ am bn) (/ a b)))
        (and (= am bn)
             (positive? bm)
             (= (/ an bm) (/ a b))))))

(define (euler-33)
  (denominator (for*/product ([a (in-range 10 100)]
                              [b (in-range (add1 a) 100)]
                              #:when (frac-a-p? a b))
                 (/ a b))))

(module* main #f
  (euler-33))
