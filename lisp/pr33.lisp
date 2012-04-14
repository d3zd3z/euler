;;; Problem 33
;;; 
;;; 20 December 2002
;;; 
;;; The fraction ^49/[98] is a curious fraction, as an inexperienced
;;; mathematician in attempting to simplify it may incorrectly believe that ^
;;; 49/[98] = ^4/[8], which is correct, is obtained by cancelling the 9s.
;;; 
;;; We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
;;; examples.
;;; 
;;; There are exactly four non-trivial examples of this type of fraction, less
;;; than one in value, and containing two digits in the numerator and
;;; denominator.
;;; 
;;; If the product of these four fractions is given in its lowest common
;;; terms, find the value of the denominator.
;;; 

(defpackage #:pr33
  (:use #:cl #:iterate)
  (:export #:euler-33))
(in-package #:pr33)

(defun frac-a-p (a b)
  (multiple-value-bind (an am) (floor a 10)
    (multiple-value-bind (bn bm) (floor b 10)
      (or (and (= an bm)
	       (plusp bn)
	       (= (/ am bn) (/ a b)))
	  (and (= am bn)
	       (plusp bm)
	       (= (/ an bm) (/ a b)))))))

(defun euler-33 ()
  (denominator (iter outer
		     (for a from 10 to 99)
		     (iter (for b from (1+ a) to 99)
			   (and (frac-a-p a b)
				(in outer (multiply (/ a b))))))))
