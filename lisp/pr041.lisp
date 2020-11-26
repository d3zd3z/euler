;;; Problem 41
;;;
;;; 11 April 2003
;;;
;;; We shall say that an n-digit number is pandigital if it makes use of all
;;; the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
;;; and is also prime.
;;;
;;; What is the largest n-digit pandigital prime that exists?
;;;
;;; 7652413

(defpackage #:pr041
  (:use #:cl #:iterate #:pr024 #:mr-prime)
  (:export #:euler-41))
(in-package #:pr041)

(setf (get 'euler-41 :euler-answer) 7652413)
(defun euler-41 ()
  (iter (for item first (copy-seq "1234567") then (next-permutation item :less #'char<))
	(while item)
	(for num = (parse-integer item))
	(when (mr-prime-p num)
	  (maximize num))))
