;;; Problem 53
;;;
;;; 26 September 2003
;;;
;;; There are exactly ten ways of selecting three from five, 12345:
;;;
;;; 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
;;;
;;; In combinatorics, we use the notation, ^5C[3] = 10.
;;;
;;; In general,
;;;
;;; ^nC[r] = n!       ,where r ≤ n, n! = nx(n−1)x...x3x2x1, and 0! = 1.
;;;          r!(n−r)!
;;;
;;; It is not until n = 23, that a value exceeds one-million: ^23C[10] =
;;; 1144066.
;;;
;;; How many, not necessarily distinct, values of  ^nC[r], for 1 ≤ n ≤ 100,
;;; are greater than one-million?
;;;
;;; 4075

;;; The number of combinations in this table is exactly the same as
;;; pascal's triangle.  It isn't necessary to compute the large
;;; numbers, as we can simply represent the overflowed results by some
;;; kind of tag, such as 'overflow'.

(defpackage #:pr053
  (:use #:cl #:iterate)
  (:export #:euler-53))
(in-package #:pr053)

(defparameter *counter* 0
  "A counter of the number of overflowed values.")

(defun sat-+ (a b)
  "Perform a saturating addition.  The values can be either integers,
or the symbol 'overflow.  If either value is 'overflow, or the result
exceeds the limit of 1 million, the result returned will be 'overflow,
otherwise it will be the sum of the two values.  The *COUNTER* is
incremented any time the function returns an overflow."
  (let ((result (if (or (eq a 'overflow)
			(eq b 'overflow))
		    'overflow
		    (let ((result (+ a b)))
		      (if (<= result 1000000)
			  result
			  'overflow)))))
    (when (eq result 'overflow)
      (incf *counter*))
    result))

(defun pascal-next (line)
  "Given a list of numbers for a line of the pascal's triangle, return
the next line."
  (iter (for n on line)
	(collect (sat-+ (car n)
			(or (cadr n) 0))
	  into result)
	(finally (return (cons (car line)
			       result)))))

(defun euler-53 ()
  (let ((*counter* 0))
    (do ((i 2 (1+ i))
	 (row '(1) (pascal-next row)))
	((= i 102)
	 *counter*))))
