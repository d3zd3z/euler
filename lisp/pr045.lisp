;;; Problem 45
;;;
;;; 06 June 2003
;;;
;;; Triangle, pentagonal, and hexagonal numbers are generated by the following
;;; formulae:
;;;
;;; Triangle     T[n]=n(n+1)/2    1, 3, 6, 10, 15, ...
;;; Pentagonal   P[n]=n(3n−1)/2   1, 5, 12, 22, 35, ...
;;; Hexagonal    H[n]=n(2n−1)     1, 6, 15, 28, 45, ...
;;;
;;; It can be verified that T[285] = P[165] = H[143] = 40755.
;;;
;;; Find the next triangle number that is also pentagonal and hexagonal.

;;; All Hexagonal numbers are Triangle numbers, so that isn't really useful.
;;; To get the nth pentagonal number P(n-1) + (3n-2)
;;; To get the nth hexagonal number H(n-1) + (4n-3)
;;;
;;; 1533776805

(defpackage #:pr045
  (:use #:cl #:iterate)
  (:export #:euler-45))
(in-package #:pr045)

(defun euler-45 ()
  (let ((pn 1)
	(hn 1)
	(pentagonal 1)
	(hexagonal 1))
    (loop (cond ((and (= pentagonal hexagonal)
		      (> pentagonal 40755))
		 (return pentagonal))
		((< pentagonal hexagonal)
		 (incf pn)
		 (incf pentagonal (- (* pn 3) 2)))
		(t
		 (incf hn)
		 (incf hexagonal (- (* hn 4) 3)))))))