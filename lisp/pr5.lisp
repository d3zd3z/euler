;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 5
;; 
;; 30 November 2001
;; 
;; 2520 is the smallest number that can be divided by each of the
;; numbers from 1 to 10 without any remainder.
;; 
;; What is the smallest positive number that is evenly divisible by all
;; of the numbers from 1 to 20?
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr5
  (:use #:cl #:iterate)
  (:export #:euler-5))
(in-package #:pr5)

(defun euler-5 ()
  (apply #'lcm (iter (for i from 1 to 20)
		     (collect i))))
