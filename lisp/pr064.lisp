;;; Problem 64
;;;
;;; 27 February 2004
;;;
;;; All square roots are periodic when written as continued fractions and can
;;; be written in the form:
;;;
;;; √N = a[0] + 1
;;;             a[1] + 1
;;;                    a[2] + 1
;;;                           a[3] + ...
;;;
;;; For example, let us consider √23:
;;;
;;; √23 = 4 + √23 — 4 = 4 +  1      = 4 +  1
;;;                          1             1 +  √23 – 3
;;;                          √23—4              7
;;;
;;; If we continue we would get the following expansion:
;;;
;;; √23 = 4 + 1
;;;           1 + 1
;;;               3 + 1
;;;                   1 + 1
;;;                       8 + ...
;;;
;;; The process can be summarised as follows:
;;;
;;; a[0] = 4,   1      =  √23+4     = 1 +  √23—3
;;;             √23—4     7                7
;;; a[1] = 1,   7      =  7(√23+3)  = 3 +  √23—3
;;;             √23—3     14               2
;;; a[2] = 3,   2      =  2(√23+3)  = 1 +  √23—4
;;;             √23—3     14               7
;;; a[3] = 1,   7      =  7(√23+4)  = 8 +  √23—4
;;;             √23—4     7
;;; a[4] = 8,   1      =  √23+4     = 1 +  √23—3
;;;             √23—4     7                7
;;; a[5] = 1,   7      =  7(√23+3)  = 3 +  √23—3
;;;             √23—3     14               2
;;; a[6] = 3,   2      =  2(√23+3)  = 1 +  √23—4
;;;             √23—3     14               7
;;; a[7] = 1,   7      =  7(√23+4)  = 8 +  √23—4
;;;             √23—4     7
;;;
;;; It can be seen that the sequence is repeating. For conciseness, we use the
;;; notation √23 = [4;(1,3,1,8)], to indicate that the block (1,3,1,8) repeats
;;; indefinitely.
;;;
;;; The first ten continued fraction representations of (irrational) square
;;; roots are:
;;;
;;; √2=[1;(2)], period=1
;;; √3=[1;(1,2)], period=2
;;; √5=[2;(4)], period=1
;;; √6=[2;(2,4)], period=2
;;; √7=[2;(1,1,1,4)], period=4
;;; √8=[2;(1,4)], period=2
;;; √10=[3;(6)], period=1
;;; √11=[3;(3,6)], period=2
;;; √12= [3;(2,6)], period=2
;;; √13=[3;(1,1,1,1,6)], period=5
;;;
;;; Exactly four continued fractions, for N ≤ 13, have an odd period.
;;;
;;; How many continued fractions for N ≤ 10000 have an odd period?
;;;
;;; 1322

(defpackage #:pr064
  (:use #:cl #:iterate)
  (:export #:euler-64 #:root-series #:perfect-squarep))
(in-package #:pr064)

;;; One step of the continued fraction expansion.  S is the number we
;;; are rooting, and A0 is the integer part of the result.
(defun root-step (s a0 m d a)
  (let* ((m2 (- (* d a) m))
	 (d2 (floor (- s (expt m2 2))
		    d))
	 (a2 (floor (+ a0 m2)
		    d2)))
    (values m2 d2 a2)))

;;; Compute the square root of S, as a continued fraction expansion.
;;; The series repeats from the second term to the end.  Calling with
;;; a perfect square will result in a division by zero.
(defun root-series (s)
  (let ((a0 (isqrt s)))
    (multiple-value-bind (m1 d1 a1)
	(root-step s a0 0 1 a0)
      (iter (for (values m d a)
		 first (root-step s a0 m1 d1 a1)
		 then (root-step s a0 m d a))
	    (when (and (= m m1)
		       (= d d1)
		       (= a a1))
	      (collect a into result)
	      (finish))
	    (collect a into result)
	    (finally (return (cons a0 result)))))))

(defun perfect-squarep (n)
  "T if N is a perfect square."
  (= n (expt (isqrt n) 2)))

;;; With the initial number (roots always have a single value before
;;; the repeat of the sequence), we actually want to look for an even
;;; length result from root-series.

(defun euler-64 ()
  (iter (for i from 2 to 10000)
	(unless (perfect-squarep i)
	  (counting (evenp (length (root-series i)))))))
