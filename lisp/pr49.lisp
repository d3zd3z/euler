;;; Problem 49
;;; 
;;; 01 August 2003
;;; 
;;; The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
;;; increases by 3330, is unusual in two ways: (i) each of the three terms are
;;; prime, and, (ii) each of the 4-digit numbers are permutations of one
;;; another.
;;; 
;;; There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
;;; primes, exhibiting this property, but there is one other 4-digit
;;; increasing sequence.
;;; 
;;; What 12-digit number do you form by concatenating the three terms in this
;;; sequence?
;;; 

(defpackage #:pr49
  (:use #:cl #:iterate #:euler.sieve #:alexandria)
  (:export #:euler-49))
(in-package #:pr49)

(defun add-number (number table)
  "If the number is prime, add an entry to the hash table mapping from
the sorted digits to the NUMBER."
  (when (primep number)
    (let* ((unsorted (princ-to-string number))
	   (len (length unsorted))
	   (sorted (sort unsorted #'char<)))
      (when (length= len sorted)
	(push number (gethash (parse-integer sorted) table))))))

(defun build-table ()
  (iter (with table = (make-hash-table))
	(for number from 1001 to 9999 by 2)
	(add-number number table)
	(finally (return table))))

;;; Note that this recurses over the length of list, so isn't
;;; practical for very long lists.  Given that the result size will be
;;; the factorial of the length of the list, this really isn't a
;;; problem.  This would need to be lazy if we wanted larger (or
;;; infinite) lists.

(defun non-empty-subsequences (list)
  "Generate all of the non-empty subsequences of LIST."
  (when (consp list)
    (let ((x (first list)))
      (cons (list x)
	    (iter (for sublist in (non-empty-subsequences (rest list)))
		  (collect (cons x sublist))
		  (collect sublist))))))

(defun euler-49 ()
  (iter outer
	(for (key value) in-hashtable (build-table))
	(declare (ignorable key))
	(iter (for sublist in (non-empty-subsequences (sort (copy-seq value) #'<)))
	      (unless (length= sublist 3)
		(next-iteration))
	      (for (a b c) = sublist)
	      (when (and (= (- c b) (- b a))
			 (/= a 1487))
		(return-from outer
		  (+ (* a (expt 10 8))
		     (* b (expt 10 4))
		     c))))))
