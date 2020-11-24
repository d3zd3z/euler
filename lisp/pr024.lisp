;;; Problem 24
;;;
;;; 16 August 2002
;;;
;;; A permutation is an ordered arrangement of objects. For example, 3124 is
;;; one possible permutation of the digits 1, 2, 3 and 4. If all of the
;;; permutations are listed numerically or alphabetically, we call it
;;; lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
;;;
;;; 012   021   102   120   201   210
;;;
;;; What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
;;; 4, 5, 6, 7, 8 and 9?
;;;
;;; 2783915460

(defpackage #:pr024
  (:use #:cl #:iterate)
  (:export #:euler-24 #:next-permutation))
(in-package #:pr024)

;;; There is some playing with both loop and iter.  For these simple
;;; cases, they are quite similar.

(declaim (inline swap))
(defun swap (array i j)
  "Swap the Ith and Jth element of the ARRAY."
  (rotatef (aref array i) (aref array j)))

(defun reverse-subseq (array i j)
  "Reverse the elements of array from I to J."
  (iter (while (< i j))
	(swap array i j)
	(incf i)
	(decf j)))

(defun loop-reverse-subseq (array i j)
  "Reverse the elements of array from I to J."
  (loop while (< i j)
     do (swap array i j)
     (incf i)
     (decf j)))

(defun next-permutation (array &key (less #'<))
  (let ((last (1- (length array)))
	k l)
    (iter (for x from 0 below last)
	  (when (funcall less (aref array x) (aref array (1+ x)))
	    (setf k x)))
    (unless k
      (return-from next-permutation nil))
    (iter (for x from (1+ k) to last)
	  (when (funcall less (aref array k) (aref array x))
	    (setf l x)))
    (swap array k l)
    (reverse-subseq array (1+ k) last)
    array))

(defun loop-next-permutation (array &key (less #'<))
  (let ((last (1- (length array)))
	k l)
    (loop for x from 0 below last
	 when (funcall less (aref array x) (aref array (1+ x)))
	 do (setf k x))
    (unless k
      (return-from loop-next-permutation nil))
    (loop for x from (1+ k) to last
	 when (funcall less (aref array k) (aref array x))
	 do (setf l x))
    (swap array k l)
    (reverse-subseq array (1+ k) last)
    array))

(defun all-permutations (array &key (less #'<))
  (iter (for item first (copy-seq array) then (next-permutation array :less less))
	(while item)
	(collect item)))

(defun loop-all-permutations (array &key (less #'<))
  (loop for item = (copy-seq array) then (next-permutation array :less less)
       while item
       collect item))

(defun euler-24 ()
  (iter (repeat 1000000)
	(for num first (copy-seq "0123456789") then (next-permutation num :less #'char<))
	(finally (return num))))

(euler/problem-set:register-problem 24 #'euler-24 "2783915460")
