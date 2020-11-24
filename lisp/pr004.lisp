;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 4
;;
;; 16 November 2001
;;
;; A palindromic number reads the same both ways. The largest
;; palindrome made from the product of two 2-digit numbers is 9009 = 91
;; × 99.
;;
;; Find the largest palindrome made from the product of two 3-digit
;; numbers.
;;
;; 906609
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr004
  (:use #:cl #:iterate)
  (:export #:euler-4))
(in-package #:pr004)

(defun reverse-number-iter (number)
  "Reverse the digits of the positive number"
  (iter (with result = 0)
	(with n = number)
	(while (plusp n))
	(for (values num den) = (truncate n 10))
	(setf n num)
	(setf result (+ (* result 10) den))
	(finally (return result))))

(defun reverse-number (number)
  "Reverse the digits of the positive number"
  (loop with result = 0
        with n = number
        while (plusp n)
        for (num den) = (multiple-value-list (truncate n 10))
        do (setf n num)
        do (setf result (+ (* result 10) den))
        finally (return result)))

(defun palindromep (number)
  "Is this number a palindrome?"
  (= number (reverse-number number)))

(defun euler-4-iter ()
  (iter outer
	(for a from 100 to 999)
	(iter (for b from a to 999)
	      (for prod = (* a b))
	      (when (palindromep prod)
		(in outer (finding (list prod a b) maximizing prod))))))

;;; LOOP is a lot less powerful than iter, so we'll do the
;;; finding...maximizing part manual.
(defun euler-4-full ()
  (loop with best = 0
        with best-all = nil
        for a from 100 to 999
        do (loop for b from a to 999
                 for prod = (* a b)
                 when (palindromep prod)
                 do (when (> prod best)
                      (setf best prod)
                      (setf best-all (list prod a b))))
        finally (return best-all)))

;;; LOOP does have a simple maximize, which we can use in this case.
;;; The inner loop might not have a max if the number isn't a
;;; palindrome, but in this case, it seems to always work.
(defun euler-4 ()
  (loop for a from 100 to 999
        maximize (loop for b from a to 999
                       for prod = (* a b)
                       when (palindromep prod) maximize prod)))

(euler/problem-set:register-problem 4 #'euler-4 906609)
