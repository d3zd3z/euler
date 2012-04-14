;;; Problem 44
;;; 
;;; 23 May 2003
;;; 
;;; Pentagonal numbers are generated by the formula, P[n]=n(3n−1)/2. The first
;;; ten pentagonal numbers are:
;;; 
;;; 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...
;;; 
;;; It can be seen that P[4] + P[7] = 22 + 70 = 92 = P[8]. However, their
;;; difference, 70 − 22 = 48, is not pentagonal.
;;; 
;;; Find the pair of pentagonal numbers, P[j] and P[k], for which their sum
;;; and difference is pentagonal and D = |P[k] − P[j]| is minimised; what is
;;; the value of D?
;;; 

(defpackage #:pr44
  (:use #:cl #:iterate)
  (:export #:euler-44))
(in-package #:pr44)

(defun pentagonalp (number)
  "is NUMBER a pentagonal number?"
  (let* ((sqr (1+ (* number 24)))
	 (root (isqrt sqr)))
    (and (= (expt root 2) sqr)
	 (zerop (mod (1+ root) 6)))))

(defun nth-pentagonal (n)
  (/ (* n (1- (* n 3)))
     2))

(defun euler-44 ()
  (iter (for i from 2)
	(for pent-i = (nth-pentagonal i))
	(iter (for j from 1 below i)
	      (for pent-j = (nth-pentagonal j))
	      (and (pentagonalp (- pent-i pent-j))
		   (pentagonalp (+ pent-i pent-j))
		   (return-from euler-44 (- pent-i pent-j))))))
