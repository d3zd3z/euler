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
;;; 748317

(defpackage #:pr037
  (:use #:cl #:mr-prime #:euler)
  (:export #:euler-37))
(in-package #:pr037)

(defun add-primes (numbers)
  (loop with result = '()
        for n in numbers
        do (loop for d in '(1 3 7 9)
                 for new = (+ (* 10 n) d)
                 when (mr-prime-p new)
                 do (setf result (cons new result)))
        finally (return result)))

(defun right-truncatable-primes ()
  (loop for set = '(2 3 5 7) then (add-primes set)
        while set
        appending set))

(defun left-truncatable-p (number)
  (loop while (plusp number)
        always (and (> number 1) (mr-prime-p number))
        do (setf number (reverse-number (truncate (reverse-number number) 10)))))

(defun euler-37 ()
  (loop for p in (right-truncatable-primes)
        when (and (> p 9) (left-truncatable-p p))
        sum p))
(setf (get 'euler-37 :euler-answer) 748317)
