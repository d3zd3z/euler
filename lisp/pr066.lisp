;;; Problem 66
;;;
;;; 26 March 2004
;;;
;;; Consider quadratic Diophantine equations of the form:
;;;
;;; x^2 – Dy^2 = 1
;;;
;;; For example, when D=13, the minimal solution in x is 649^2 – 13x180^2 = 1.
;;;
;;; It can be assumed that there are no solutions in positive integers when D
;;; is square.
;;;
;;; By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the
;;; following:
;;;
;;; 3^2 – 2x2^2 = 1
;;; 2^2 – 3x1^2 = 1
;;; 9^2 – 5x4^2 = 1
;;; 5^2 – 6x2^2 = 1
;;; 8^2 – 7x3^2 = 1
;;;
;;; Hence, by considering minimal solutions in x for D ≤ 7, the largest x is
;;; obtained when D=5.
;;;
;;; Find the value of D ≤ 1000 in minimal solutions of x for which the largest
;;; value of x is obtained.
;;;
;;; 661

(defpackage #:pr066
  (:use #:cl #:iterate)
  (:export #:euler-66))
(in-package #:pr066)

;;; "Maths" tells us that the solution to the above equation (Pell's
;;; equation) will always be a term in the continued fraction
;;; expansion of the sqrt(D).  The minimal will be the first tem
;;; found.

;;; One step of the continued fraction expansion.  S is the number we
;;; are rooting, and A0 is the integer part of the result.
(defun root-step (s a0 m d a)
  (let* ((m2 (- (* d a) m))
	 (d2 (floor (- s (expt m2 2))
		    d))
	 (a2 (floor (+ a0 m2)
		    d2)))
    (values m2 d2 a2)))

;;; Generate the expansion of the square root of a number.  Calls FUNC
;;; with each successive expansion.  Does not terminate.
(defun root-expand (s func)
  (let ((a0 (isqrt s)))
    (funcall func (list a0))
    (iter (for (values m d a)
	       first (root-step s a0 0 1 a0)
	       then (root-step s a0 m d a))
	  (collect a into result)
	  (funcall func (cons a0 result)))))

;;; Expand the continued fraction specified
(defun expand-fraction (items)
  (iter (for num in (reverse items))
	(for step first num
	     then (+ (/ step) num))
	(finally (return step))))

;;; Does the rational approximation of a sqrt solve the Pell equation
;;; for a given D.
(defun pell-solution-p (d rat)
  (= (- (expt (numerator rat) 2)
	(* d (expt (denominator rat) 2)))
     1))

;;; Find the minimal solution to the Pell's equation for a given D.
(defun minimal-pell (d)
  (root-expand d #'(lambda (items)
		     (let ((rat (expand-fraction items)))
		       ; (format t "d=~S, rat=~S item=~S~%" d rat items)
		       (when (pell-solution-p d rat)
			 (return-from minimal-pell rat))))))

(defun perfect-square-p (n)
  (= n (expt (isqrt n) 2)))

(defun euler-66 ()
  (iter (for d from 2 to 1000)
	(when (not (perfect-square-p d))
	  (let ((x (numerator (minimal-pell d))))
	    (finding d maximizing x)))))
