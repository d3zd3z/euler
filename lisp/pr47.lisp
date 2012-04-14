;;; Problem 47
;;; 
;;; 04 July 2003
;;; 
;;; The first two consecutive numbers to have two distinct prime factors are:
;;; 
;;; 14 = 2 × 7
;;; 15 = 3 × 5
;;; 
;;; The first three consecutive numbers to have three distinct prime factors
;;; are:
;;; 
;;; 644 = 2² × 7 × 23
;;; 645 = 3 × 5 × 43
;;; 646 = 2 × 17 × 19.
;;; 
;;; Find the first four consecutive integers to have four distinct primes
;;; factors. What is the first of these numbers?
;;; 

(defpackage #:pr47
  (:use #:cl #:iterate #:euler.sieve #:alexandria)
  (:export #:euler-47))
(in-package #:pr47)

(defun products (list)
  (mapcar #'(lambda (pair)
	      (* (car pair) (cdr pair)))
	  lis
	  t))

(defun all-unique (lists)
  "Given a list of lists, return T iff none of the elements of the sublists are EQL."
  (iter (with table = (make-hash-table))
	(for list in lists)
	(iter (for elt in list)
	      (when (gethash elt table)
		(return-from all-unique nil))
	      (setf (gethash elt table) t)))
  t)

(defun all-len-n (n lists)
  "Return T if all of the lists have exactly N elements."
  (iter (for list in lists)
	(always (length= n list))))

(defun euler-47 ()
  (iter (with span = 4)
	(with factors = (iter (for i from 10 to (+ 10 span -1))
			      (collect (products (factorize i)))))
	(for base from 10)
	(when (and (all-len-n span factors)
		   (all-unique factors))
	  (return base))

	;; Shift the factors down.
	(setf factors (nconc (rest factors)
			     (list (products (factorize (+ base span))))))))

;;; Bleh, this is very slow, as well as being ugly.
#|
(defun euler-47 ()
  (macrolet ((mustlen (list len)
	       `(unless (length= ,list ,len)
		  (next-iteration))))
    (iter (for base from 100)
	  (for f1 = (factorize base))
	  (mustlen f1 4)
	  (for f2 = (factorize (1+ base)))
	  (mustlen f2 4)
	  (for u2 = (union (firsts f1) (firsts f2)))
	  (mustlen u2 8)
	  (for f3 = (factorize (+ base 2)))
	  (mustlen f3 4)
	  (for f4 = (factorize (+ base 3)))
	  (mustlen f4 4)
	  (for large = (union u2
			      (union (firsts f3) (firsts f4))))
	  (when (length= large 12)
	    (return base)))))
|#
