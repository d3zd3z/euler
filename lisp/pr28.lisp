;;; Problem 28
;;; 
;;; 11 October 2002
;;; 
;;; Starting with the number 1 and moving to the right in a clockwise
;;; direction a 5 by 5 spiral is formed as follows:
;;; 
;;; 21 22 23 24 25
;;; 20  7  8  9 10
;;; 19  6  1  2 11
;;; 18  5  4  3 12
;;; 17 16 15 14 13
;;; 
;;; It can be verified that the sum of the numbers on the diagonals is 101.
;;; 
;;; What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
;;; formed in the same way?
;;; 

(defpackage #:pr28
  (:use #:cl #:iterate)
  (:export #:euler-28))
(in-package #:pr28)

(defun ring-sum (n)
  (+ (* 4 n n) (* -6 n) 6))

(defun euler-28 ()
  (1+ (iter (for i from 3 to 1001 by 2)
	    (sum (ring-sum i)))))
