;;; Problem 35
;;;
;;; 17 January 2003
;;;
;;; The number, 197, is called a circular prime because all rotations of the
;;; digits: 197, 971, and 719, are themselves prime.
;;;
;;; There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
;;; 71, 73, 79, and 97.
;;;
;;; How many circular primes are there below one million?
;;;
;;; 55

(defpackage #:pr035
  (:use #:cl #:euler.sieve)
  (:export #:euler-35))
(in-package #:pr035)

(defun number-of-digits (number)
  (loop while (plusp number)
        do (setf number (truncate number 10))
        counting t))

#|
;;; SBCL gives a warning that the (mod number 10) is unreachable.  It
;;; clearn isn't, and is even working, so I'm not sure what the issue
;;; is here.
(defun number-rotations (number &aux result)
  (do ((right (number-of-digits number) (1- right))
       (left 0 (1+ left))
       (accum 0 (+ accum (* (expt 10 left) (mod number 10))))
       (number number (truncate number 10)))
      ((zerop right) result)
    (push (+ number (* (expt 10 right) accum)) result)))
|#

(defun number-rotations (number)
  (loop for right from (1- (number-of-digits number)) downto 0
        for left from 0
        for accum = 0 then (+ accum (* (expt 10 left) (mod n 10)))
        for n = number then (truncate n 10)
        collect (+ n (* (expt 10 right) accum))))

(defun all-prime (numbers)
  (dolist (p numbers)
    (unless (primep p)
      (return-from all-prime nil)))
  t)

(defun euler-35 ()
  (loop for pbase in (primes-upto 1000000)
        count (all-prime (number-rotations pbase))))

(euler/problem-set:register-problem 35 #'euler-35 55)
