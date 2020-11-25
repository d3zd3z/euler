;;; Problem 15
;;;
;;; 19 April 2002
;;;
;;; Starting in the top left corner of a 2×2 grid, there are 6 routes (without
;;; backtracking) to the bottom right corner.
;;;
;;; [p_015]
;;;
;;; How many routes are there through a 20×20 grid?
;;;
;;; 137846528820

(defpackage #:pr015
  (:use #:cl #:iterate)
  (:export #:euler-15))
(in-package #:pr015)

(defun base (n)
  (iter (repeat (1+ n))
	(collect 1 result-type vector)))

(defun bump (seq)
  (iter (for i from 0 below (1- (length seq)))
	(incf (aref seq (1+ i))
	      (aref seq i)))
  seq)

(defun routes (n)
  (iter (for seq first (base n) then (bump seq))
	(repeat n)
	(finally (return (aref seq (1- (length seq)))))))

(defun euler-15 ()
  (routes 20))
(setf (get 'euler-15 :euler-answer) 137846528820)
