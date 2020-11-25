;;; Problem 32
;;;
;;; 06 December 2002
;;;
;;; We shall say that an n-digit number is pandigital if it makes use of all
;;; the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
;;; 1 through 5 pandigital.
;;;
;;; The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
;;; multiplicand, multiplier, and product is 1 through 9 pandigital.
;;;
;;; Find the sum of all products whose multiplicand/multiplier/product
;;; identity can be written as a 1 through 9 pandigital.
;;;
;;; HINT: Some products can be obtained in more than one way so be sure to
;;; only include it once in your sum.
;;;
;;; 45228

(defpackage #:pr032
  (:use #:cl #:iterate)
  (:export #:euler-32))
(in-package #:pr032)

;;; We need to be able to generate permutations.
(declaim (inline swap))
(defun swap (array i j)
  (rotatef (aref array i) (aref array j)))

(defun reverse-subseq (array i j)
  "Reverse the elements of array from i to j (inclusive)."
  (loop while (< i j)
        do (swap array i j)
        do (incf i)
        do (decf j)))

;;; This is right out of Wikipedia for permutations of a sequence.
(defun next-permutation (array &key (less #'<))
  "Destructively modify the array to return the next lexicographic
permutation.  Returns the array if there was one, or NIL if this is
the last permutation."
  (let ((last (1- (length array)))
	k l)
    (loop for x from 0 below last
          when (funcall less (aref array x) (aref array (1+ x)))
          do (setf k x))
    (unless k
      (return-from next-permutation nil))
    (loop for x from (1+ k) to last
          when (funcall less (aref array k) (aref array x))
          do (setf l x))
    (swap array k l)
    (reverse-subseq array (1+ k) last)
    array))

;;; Divide a number into all of the ways of making 3 groups of at
;;; least one digit.
(defun make-groupings (digits)
  (let ((len (length digits))
        (result '()))
    (loop for i from 1 below (- len 2)
          do (loop for j from (1+ i) below (1- len)
                   for a = (parse-integer digits :start 0 :end i)
                   for b = (parse-integer digits :start i :end j)
                   for c = (parse-integer digits :start j)
                   when (= (* a b) c)
                   do (setf result (cons c result))))
    result))

(defun euler-32 ()
  (let ((products '()))
    (loop for digits = (copy-seq "123456789")
          then (next-permutation digits :less #'char<)
          while digits
          do (setf products (nunion products (make-groupings digits))))
    (reduce #'+ products)))
(setf (get 'euler-32 :euler-answer) 45228)
