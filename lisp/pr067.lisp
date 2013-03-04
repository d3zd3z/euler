;;; Problem 67
;;;
;;; 09 April 2004
;;;
;;; By starting at the top of the triangle below and moving to adjacent
;;; numbers on the row below, the maximum total from top to bottom is 23.
;;;
;;; 3
;;; 7 4
;;; 2 4 6
;;; 8 5 9 3
;;;
;;; That is, 3 + 7 + 4 + 9 = 23.
;;;
;;; Find the maximum total from top to bottom in triangle.txt (right click and
;;; 'Save Link/Target As...'), a 15K text file containing a triangle with
;;; one-hundred rows.
;;;
;;; NOTE: This is a much more difficult version of Problem 18. It is not
;;; possible to try every route to solve this problem, as there are 2^99
;;; altogether! If you could check one trillion (10^12) routes every second it
;;; would take over twenty billion years to check them all. There is an
;;; efficient algorithm to solve it. ;o)
;;;
;;; 7273

(defpackage #:pr067
  (:use #:cl #:iterate #:split-sequence)
  (:export #:euler-67))
(in-package #:pr067)

(defun fix-eol (line)
  (string-right-trim '(#\Return) line))

(defun load-triangle ()
  (iter (for line in-file "../haskell/triangle.txt" using #'read-line)
	(for numbers = (split-sequence #\space (fix-eol line)))
	(collect (mapcar #'parse-integer numbers))))

(defun combine-rows (b a)
  "Combine two rows.  A should have one more element than B, and the
result will have the length of A."
  (iter (for a-elt in a)
	(for b-head on b)
	(collect (+ a-elt (max (first b-head) (second b-head))))))

(defun euler-67 ()
  (first (reduce #'combine-rows (reverse (load-triangle)))))
