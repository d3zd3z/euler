;;; Problem 37
;;; 
;;; 14 February 2003
;;; 
;;; The number 3797 has an interesting property. Being prime itself, it is
;;; possible to continuously remove digits from left to right, and remain
;;; prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
;;; right to left: 3797, 379, 37, and 3.
;;; 
;;; Find the sum of the only eleven primes that are both truncatable from left
;;; to right and right to left.
;;; 
;;; NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
;;; 

(defpackage #:pr37
  (:use #:cl #:mr-prime #:iterate #:euler)
  (:export #:euler-37))
(in-package #:pr37)

(defun add-primes (numbers)
  (iter outer
	(for n in numbers)
	(iter (for d in '(1 3 7 9))
	      (for new = (+ (* 10 n) d))
	      (when (mr-prime-p new)
		(in outer (collect new))))))

(defun right-truncatable-primes ()
  (iter (for set first '(2 3 5 7) then (add-primes set))
	(while set)
	(appending set)))

(defun left-truncatable-p (number)
  (iter (while (plusp number))
	(always (and (> number 1) (mr-prime-p number)))
	(setf number (reverse-number (truncate (reverse-number number) 10)))))

(defun euler-37 ()
  (iter (for p in (right-truncatable-primes))
	(when (and (> p 9) (left-truncatable-p p))
	  (sum p))))
