;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 10
;;
;; 08 February 2002
;;
;; The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
;;
;; Find the sum of all the primes below two million.
;;
;; 142913828922
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr010
  (:use #:cl #:iterate #:euler.big-sieve)
  (:export #:euler-10))
(in-package #:pr010)

(defun euler-10 ()
  (iter (with sieve = (make-sieve))
	(for p first 2 then (next-prime sieve p))
	(until (>= p 2000000))
	(sum p)))

;;; Alternate implementation using the other euler-sieve
#+(or)
(defun euler-10b ()
  (iter (with sieve = (euler.sieve:make-sieve))
	(for p = (euler.sieve:sieve-next sieve))
	(until (>= p 2000000))
	(sum p)))
