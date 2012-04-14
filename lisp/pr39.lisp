;;; Problem 39
;;; 
;;; 14 March 2003
;;; 
;;; If p is the perimeter of a right angle triangle with integral length
;;; sides, {a,b,c}, there are exactly three solutions for p = 120.
;;; 
;;; {20,48,52}, {24,45,51}, {30,40,50}
;;; 
;;; For which value of p ≤ 1000, is the number of solutions maximised?
;;; 

(defpackage #:pr39
  (:use #:cl #:iterate #:euler.triangles)
  (:export #:euler-39))
(in-package #:pr39)

(defun euler-39 ()
  (let ((buckets (make-hash-table)))
    (generate-triples 1000
		      (lambda (triple p)
			(declare (ignorable triple))
			(setf (gethash p buckets)
			      (1+ (gethash p buckets 0)))))
    (iter (for (p count) in-hashtable buckets)
	  (finding p maximizing count))))
