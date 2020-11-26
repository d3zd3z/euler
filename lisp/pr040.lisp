;;; Problem 40
;;;
;;; 28 March 2003
;;;
;;; An irrational decimal fraction is created by concatenating the positive
;;; integers:
;;;
;;; 0.123456789101112131415161718192021...
;;;
;;; It can be seen that the 12^th digit of the fractional part is 1.
;;;
;;; If d[n] represents the n^th digit of the fractional part, find the value
;;; of the following expression.
;;;
;;; d[1] × d[10] × d[100] × d[1000] × d[10000] × d[100000] × d[1000000]
;;;
;;; 210

(defpackage #:pr040
  (:use #:cl)
  (:export #:euler-40))
(in-package #:pr040)

;;; Each grouping of digits has 9, then 90, then 900, and so on numbers
;;; in it.  The number of digits is multiplied by the length (1*9,
;;; 2*90, 3*900, 4*9000, etc).  Given an index, this returns the number
;;; we are in, and the digit offset within that number (with 0 being
;;; the rightmost digit.
(defun get-pos (n)
  (loop for how-many = 9 then (* how-many 10)
        for width from 1
        for characters = (* how-many width)
        for base = 1 then (* base 10)
        when (< n characters)
          do (multiple-value-bind (pos offset) (floor n width)
               (return (values (+ base pos) offset)))
        do (setf n (- n characters))))

;;; Retrieve the digit in the magical number.
(defun get-digit (n)
  (multiple-value-bind (num digit) (get-pos n)
    (let ((textual (write-to-string num)))
      ;(format t "~&n=~a num=~a digit=~a textual=~a" n num digit textual)
      (- (char-code (aref textual digit))
         (char-code #\0)))))

(setf (get 'euler-40 :euler-answer) 210)
(defun euler-40 ()
  (loop with total = 1
        for e = 1 then (* e 10)
        repeat 7
        ;do (format t "~&e=~a digit=~a" e (get-digit (1- e)))
        do (setf total (* total (get-digit (1- e))))
        finally (return total)))
