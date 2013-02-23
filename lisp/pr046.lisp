;;; Problem 46
;;;
;;; 20 June 2003
;;;
;;; It was proposed by Christian Goldbach that every odd composite number can
;;; be written as the sum of a prime and twice a square.
;;;
;;; 9 = 7 + 2×1^2
;;; 15 = 7 + 2×2^2
;;; 21 = 3 + 2×3^2
;;; 25 = 7 + 2×3^2
;;; 27 = 19 + 2×2^2
;;; 33 = 31 + 2×1^2
;;;
;;; It turns out that the conjecture was false.
;;;
;;; What is the smallest odd composite that cannot be written as the sum of a
;;; prime and twice a square?
;;;
;;; 5777

(defpackage #:pr046
  (:use #:cl #:iterate #:euler.sieve)
  (:export #:euler-46))
(in-package #:pr046)

(defun perfect-root (number)
  "Return (isqrt NUMBER) if NUMBER is a perfect square, otherwise return NIL."
  (let ((root (isqrt number)))
    (and (= number (expt root 2))
	 root)))

(defun goldbach (number)
  "Return the first goldbach prime for the given number, or NIL if it
can't be written this way.  The NUMBER must be an odd composite."
  (iter (for p in (primes-upto (1- number)))
	(when (oddp p)
	  (for comp = (perfect-root (/ (- number p) 2)))
	  (when comp
	    (return p)))))

(defun euler-46 ()
  (iter (for n from 9 by 2)
	(when (primep n)
	  (next-iteration))
	(unless (goldbach n)
	  (return n))))
