;;; Problem 40
;;; 
;;; 28 March 2003
;;; 
;;; An irrational decimal fraction is created by concatenating the positive
;;; integers:
;;; 
;;; 0.123456789101112131415161718192021...
;;; 
;;; It can be seen that the 12^th digit of the fractional part is 1.
;;; 
;;; If d[n] represents the n^th digit of the fractional part, find the value
;;; of the following expression.
;;; 
;;; d[1] × d[10] × d[100] × d[1000] × d[10000] × d[100000] × d[1000000]
;;; 

(defpackage #:pr40
  (:use #:cl #:iterate)
  (:export #:euler-40))
(in-package #:pr40)

;;; Naive, very memory hungry approach.

(defun digits (limit)
  (with-output-to-string (stream)
  (iter (for i from 1 to limit)
	(princ i stream))))

(defun euler-40 ()
  (let ((all (digits 200000)))
    (iter (for e first 1 then (* e 10))
	  (repeat 7)
	  (for ch = (aref all (1- e)))
	  (multiply (- (char-code ch)
		       (char-code #\0))))))
