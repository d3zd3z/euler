;;; Problem 34
;;;
;;; 03 January 2003
;;;
;;; 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
;;;
;;; Find the sum of all numbers which are equal to the sum of the factorial of
;;; their digits.
;;;
;;; Note: as 1! = 1 and 2! = 2 are not sums they are not included.
;;;
;;; 40730

(defpackage #:pr034
  (:use #:cl #:alexandria)
  (:export #:euler-34))
(in-package #:pr034)

(defun factorials (n)
  "Return a vector of the factorials indexed by n, with n at the top"
  (loop for i from 0 to n
        for fact = 1 then (* fact i)
        collect fact into result
        finally (return (coerce result '(vector fixnum)))))

(defun euler-34 ()
  (let* ((total -3)			; To eliminate 1 and 2.
	 (facts (factorials 9))
	 (last-fact (last-elt facts)))
    (labels ((chain (number fact-sum)
	       (when (and (plusp number) (= number fact-sum))
		 ;; (format t "~S~%" number)
		 (incf total number))
	       (when (<= (* number 10) (+ fact-sum last-fact))
                 (loop for i from (if (plusp number) 0 1) to 9
                       do (chain (+ (* number 10) i)
                                 (+ fact-sum (aref facts i)))))))
      (chain 0 0))
    total))
(setf (get 'euler-34 :euler-answer) 40730)
