;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 6
;;
;; 14 December 2001
;;
;; The sum of the squares of the first ten natural numbers is,
;;
;; 1^2 + 2^2 + ... + 10^2 = 385
;;
;; The square of the sum of the first ten natural numbers is,
;;
;; (1 + 2 + ... + 10)^2 = 55^2 = 3025
;;
;; Hence the difference between the sum of the squares of the first ten
;; natural numbers and the square of the sum is 3025 − 385 = 2640.
;;
;; Find the difference between the sum of the squares of the first one
;; hundred natural numbers and the square of the sum.
;;
;; 25164150
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage #:pr006
  (:use #:cl)
  (:export #:euler-6))
(in-package #:pr006)

(defun sum-of-squares (limit)
  (loop for i from 1 to limit
        sum (* i i)))

(defun square-of-sums (limit)
  (loop for i from 1 to limit
        sum i into accum
        finally (return (* accum accum))))

(defun euler-6 ()
  (let ((limit 100))
    (- (square-of-sums limit)
       (sum-of-squares limit))))
(setf (get 'euler-6 :euler-answer) 25164150)
