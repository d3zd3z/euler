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

(defpackage #:pr34
  (:use #:cl #:iterate #:alexandria)
  (:export #:euler-34))
(in-package #:pr34)

(defun factorials (n)
  "Return a vector of the factorials indexed by n, with n at the top"
  (iter (for i from 0 to n)
	(for fact first 1 then (* fact i))
	(collect fact result-type (vector fixnum))))

(defun euler-34 ()
  (let* ((total -3)			; To eliminate 1 and 2.
	 (facts (factorials 9))
	 (last-fact (last-elt facts)))
    (labels ((chain (number fact-sum)
	       (when (and (plusp number) (= number fact-sum))
		 ;; (format t "~S~%" number)
		 (incf total number))
	       (when (<= (* number 10) (+ fact-sum last-fact))
		 (iter (for i from (if (plusp number) 0 1) to 9)
		       (chain (+ (* number 10) i)
			      (+ fact-sum (aref facts i)))))))
      (chain 0 0))
    total))
