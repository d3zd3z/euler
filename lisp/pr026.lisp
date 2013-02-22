;;; Problem 26
;;;
;;; 13 September 2002
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

(defpackage #:pr026
  (:use #:cl #:iterate #:euler.sieve)
  (:export #:euler-26))
(in-package #:pr026)

(defun dlog (n)
  "Solve 10^K = 1 (mod N)."
  (iter (for k from 1)
	(when (= 1 (mod (expt 10 k) n))
	  (return k))))

(defun euler-26 ()
  (iter
    (for p in (nthcdr 3 (primes-upto 1000)))
    (finding p maximizing (dlog p))))
