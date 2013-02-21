;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 1
;;
;; 05 October 2001
;;
;; If we list all the natural numbers below 10 that are multiples of 3
;; or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
;;
;; Find the sum of all the multiples of 3 or 5 below 1000.
;;
;; 234168
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr001
  (:use #:cl #:iterate)
  (:export #:euler-1))

(in-package #:pr001)

(defun proper (num)
  (or (zerop (mod num 3))
      (zerop (mod num 5))))

(defun euler-1 ()
  (iter (for i from 1 to 1000)
	(when (proper i)
	  (sum i))))
