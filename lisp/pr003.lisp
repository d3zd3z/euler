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
(defun euler-3b ()
  (iter (with number = 600851475143)
	(for p from 3 by 2)
	(iter (for (values n r) = (floor number p))
	      (until (plusp r))
	      (setf number n))
	(when (= number 1)
	  (return p))))

;;; The sieve version, but with ANSI loop, and the extra consing.
(defun euler-3c ()
  (loop
    with sieve = (make-sieve)
    with number = 600851475143
    for prime = (sieve-next sieve)
    when (= number prime) return prime
    do (loop for (n d) = (multiple-value-list (floor number prime))
             until (plusp d)
             do (setf number n))))

;;; ANSI LOOP doesn't understand multiple values.  It sort of
;;; non-portabally works to just use it, but instead we will use
;;; multiple-value-list, even though this results in extra consing.
(defun euler-3 ()
  (loop
    with number = 600851475143
    for p from 3 by 2
    do (loop for (n r) = (multiple-value-list (floor number p))
             until (plusp r)
             do (setf number n))
    when (= number 1) return p))
(setf (get 'euler-3 :euler-answer) 6857)
