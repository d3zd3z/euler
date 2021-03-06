;;; Problem 20
;;;
;;; 21 June 2002
;;;
;;; n! means n × (n − 1) × ... × 3 × 2 × 1
;;;
;;; For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
;;; and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
;;; 27.
;;;
;;; Find the sum of the digits in the number 100!
;;;
;;; 648

(defpackage #:pr020
  (:use #:cl #:iterate #:euler)
  (:export #:euler-20))
(in-package #:pr020)

;; Admittedly, this is probably not what they are looking for,
;; probably assuming something more complex done, but that is
;; unnecessary with arbitrary precision numbers.

(defun euler-20 ()
  (sum-digits (factorial 100)))
(setf (get 'euler-20 :euler-answer) 648)
