;;; Problem 51
;;; 
;;; 29 August 2003
;;; 
;;; By replacing the 1^st digit of *3, it turns out that six of the nine
;;; possible values: 13, 23, 43, 53, 73, and 83, are all prime.
;;; 
;;; By replacing the 3^rd and 4^th digits of 56**3 with the same digit, this
;;; 5-digit number is the first example having seven primes among the ten
;;; generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663,
;;; 56773, and 56993. Consequently 56003, being the first member of this
;;; family, is the smallest prime with this property.
;;; 
;;; Find the smallest prime which, by replacing part of the number (not
;;; necessarily adjacent digits) with the same digit, is part of an eight
;;; prime value family.
;;; 

(defpackage #:pr51
  (:use #:cl #:iterate #:euler.sieve)
  (:export #:euler-51))
(in-package #:pr51)

(defparameter *limit* 1000000
  "The guess as to the largest number we would be interested in.")

(defun digits-of (n)
  "Return N as a vector of its digits."
  (iter (while (plusp n))
	(for (values num den) = (truncate n 10))
	(collect den into result at start)
	(setf n num)
	(finally (return #+nope (coerce result '(vector (integer 0 9)))
			 (coerce result 'vector)
			 ))))

(defun to-digits (digits &aux (result 0))
  "Turn the vector of digits back into a number."
  (iter (for d in-vector digits)
	(setf result (+ (* result 10) d)))
  result)

;;; Scan a pair of digits (assuming the same length), to determine if
;;; the numbers differ by only a single numeric digit in one or more
;;; places.
(defun compare-digits (a b)
  (iter (with matched = 0)
	(with match-a = nil)
	(with match-b = nil)
	(for pos index-of-sequence a)
	(for aa = (aref a pos))
	(for bb = (aref b pos))
	(when (/= aa bb)
	  (if match-a
	      (if (or (/= match-a aa)
		      (/= match-b bb))
		  (return nil)
		  (setf (ldb (byte 1 pos) matched) 1))
	      (setf match-a aa
		    match-b bb))
	  (setf (ldb (byte 1 pos) matched) 1))
	(finally (return (and (plusp matched)
			      (values matched match-a match-b))))))

(defun scan-groups (prime other-primes count)
  "Scan the primes for group matches, and return any that have COUNT or more elements."
  (let ((result (make-hash-table)))
    (iter (for other in other-primes)
	  (for (values matched a b) = (compare-digits prime other))
	  (declare (ignorable a))
	  (when matched
	    (push b (gethash matched result))))
    (iter (for (matched indices) in-hashtable result)
	  (when (>= (length indices) (1- count))
	    (collect matched)))))

(defun search-group (numbers length)
  "Scan for a group of matching numbers in the given numbers that is a group of at least LENGTH."
  (setf numbers (mapcar #'digits-of numbers))
  (iter (for items on numbers)
	(for base = (car items))
	(for groups = (scan-groups base (cdr items) length))
	(when groups
	  (return (to-digits base)))))

(defun primes-of-digits (digits)
  "Return all of the primes that have DIGITS digits."
  (primes-from-to (expt 10 (1- digits))
		  (1- (expt 10 digits))))

(defun euler-51 ()
  (iter (for digits from 1 to 7)
	(for base = (search-group (primes-of-digits digits) 8))
	(when base
	  (return base))))

;;; This algorithm seems quite a bit slower than the solution I used
;;; in the Haskell version.  That version only looks at numbers with a
;;; repeat of 0, 1, or 2, and a trick that the solution must have an
;;; odd number of repeats > 1.  If we start with the '1' repeat, we
;;; can skip the search for the others.
