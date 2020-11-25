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
;; 232792560
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr005
  (:use #:cl)
  (:export #:euler-5))
(in-package #:pr005)

(defun euler-5 ()
  (apply #'lcm (loop for i from 1 to 20 collect i)))
(setf (get 'euler-5 :euler-answer) 232792560)
