;;; Problem 43
;;;
;;; 09 May 2003
;;;
;;; The number, 1406357289, is a 0 to 9 pandigital number because it is made
;;; up of each of the digits 0 to 9 in some order, but it also has a rather
;;; interesting sub-string divisibility property.
;;;
;;; Let d[1] be the 1^st digit, d[2] be the 2^nd digit, and so on. In this
;;; way, we note the following:
;;;
;;;   • d[2]d[3]d[4]=406 is divisible by 2
;;;   • d[3]d[4]d[5]=063 is divisible by 3
;;;   • d[4]d[5]d[6]=635 is divisible by 5
;;;   • d[5]d[6]d[7]=357 is divisible by 7
;;;   • d[6]d[7]d[8]=572 is divisible by 11
;;;   • d[7]d[8]d[9]=728 is divisible by 13
;;;   • d[8]d[9]d[10]=289 is divisible by 17
;;;
;;; Find the sum of all 0 to 9 pandigital numbers with this property.
;;;
;;; 16695334890

(defpackage #:pr043
  (:use #:cl #:pr024)
  (:export #:euler-43))
(in-package #:pr043)

(defun decode-number (digits &aux (result 0))
  (loop for i across digits
        do (setf result (+ (* result 10) i)))
  result)

(defun valid-number (digits)
  "Is the number represented by the given digits value according to the rules."
  (labels ((divisible (number div)
	     (zerop (mod number div)))
	   (get-digits (from to &aux (result 0))
             (loop for i from from to to
                   do (setf result (+ (* result 10)
                                      (aref digits (1- i)))))
	     result)
           (part (from to div)
             (divisible (get-digits from to) div)))
    (and (part 2 4 2)
	 (part 3 5 3)
	 (part 4 6 5)
	 (part 5 7 7)
	 (part 6 8 11)
	 (part 7 9 13)
	 (part 8 10 17))))

;;; We don't count numbers that start with '0', since that wouldn't be
;;; considered a number.  This is most easily done by just starting
;;; with the first permutation not starting with a zero.

(setf (get 'euler-43 :euler-answer) 16695334890)
(defun euler-43 ()
  (loop for digits = (copy-seq #(1 0 2 3 4 5 6 7 8 9))
          then (next-permutation digits)
        while digits
        when (valid-number digits)
          sum (decode-number digits)))
