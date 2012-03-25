;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 2
;; 
;; 19 October 2001
;; 
;; Each new term in the Fibonacci sequence is generated by adding the
;; previous two terms. By starting with 1 and 2, the first 10 terms
;; will be:
;; 
;; 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
;; 
;; By considering the terms in the Fibonacci sequence whose values do
;; not exceed four million, find the sum of the even-valued terms.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr2
  (:use #:cl #:iterate)
  (:export #:euler-2))

(in-package #:pr2)

(defun euler-2 ()
  (iter (for a initially 1 then b)
	(for b initially 1 then (+ a b))
	(while (< b 4000000))
	(when (evenp b)
	  (sum b))))