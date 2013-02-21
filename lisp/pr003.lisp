;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 3
;;
;; 02 November 2001
;;
;; The prime factors of 13195 are 5, 7, 13 and 29.
;;
;; What is the largest prime factor of the number 600851475143 ?
;;
;; 6857
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr003
  (:use #:cl #:iterate #:euler.sieve)
  (:export #:euler-3))
(in-package #:pr003)

(defun euler-3a ()
  (iter (with sieve = (make-sieve))
	(with number = 600851475143)
	(for prime = (sieve-next sieve))
	(when (= number prime)
	  (return prime))
	(iter (for (values n d) = (floor number prime))
	      (until (plusp d))
	      (setf number n))))

;;; The sieve appears to take longer to build and use than just doing
;;; this iteratively.  It also only returns the correct result if the
;;; largest factor is only present once.
(defun euler-3 ()
  (iter (with number = 600851475143)
	(for p from 3 by 2)
	(iter (for (values n r) = (floor number p))
	      (until (plusp r))
	      (setf number n))
	(when (= number 1)
	  (return p))))
