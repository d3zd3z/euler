;;; Problem 62
;;;
;;; 30 January 2004
;;;
;;; The cube, 41063625 (345^3), can be permuted to produce two other cubes:
;;; 56623104 (384^3) and 66430125 (405^3). In fact, 41063625 is the smallest
;;; cube which has exactly three permutations of its digits which are also
;;; cube.
;;;
;;; Find the smallest cube for which exactly five permutations of its digits
;;; are cube.
;;;
;;; 127035954683

(defpackage #:pr062
  (:use #:cl #:iterate)
  (:export #:euler-62))
(in-package #:pr062)

(defun digits-of (number)
  (sort (princ-to-string number) #'char<))

(defun euler-62 ()
  (iter (with block = (make-hash-table :test #'equal))
	(for n from 1)
	(for cube = (expt n 3))
	(for cube-text = (digits-of cube))
	(for group = (push cube (gethash cube-text block)))
	(when (= (length group) 5)
	  (return (car (last group))))))
