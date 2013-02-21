;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 9
;;
;; 25 January 2002
;;
;; A Pythagorean triplet is a set of three natural numbers, a < b < c,
;; for which,
;;
;; a^2 + b^2 = c^2
;;
;; For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
;;
;; There exists exactly one Pythagorean triplet for which a + b + c =
;; 1000.
;; Find the product abc.
;;
;; 31875000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This one can easily be brute forced.

(defpackage #:pr009
  (:use #:cl #:iterate)
  (:export #:euler-9))
(in-package #:pr009)

(defun euler-9 ()
  (iter outer
	(for a from 1 to 999)
	(iter (for b from a to 999)
	      (for c = (- 1000 a b))
	      (when (and (> c b)
			 (= (+ (* a a) (* b b))
			    (* c c)))
		(in outer (maximize (* a b c)))))))
