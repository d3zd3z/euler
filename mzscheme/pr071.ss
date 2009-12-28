#lang scheme

;;; Consider the fraction, n/d, where n and d are positive integers. If n
;;; <d and HCF(n,d)=1, it is called a reduced proper fraction.
;;; 
;;; If we list the set of reduced proper fractions for d ≤ 8 in ascending
;;; order of size, we get:
;;; 
;;; 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8,
;;; 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
;;; 
;;; It can be seen that 2/5 is the fraction immediately to the left of 3/
;;; 7.
;;; 
;;; By listing the set of reduced proper fractions for d ≤ 1,000,000 in
;;; ascending order of size, find the numerator of the fraction
;;; immediately to the left of 3/7.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Another way of thinking of this problem is what is the largest
;;; proper fraction less than 3/7.  Finding the value is easy.

;;; Aside from the fairly obvious answer, we can search for it via
;;; brute force.

(define (answer)
  (let loop ([fmin 0]
	     [index 1000000])
    (if (zero? index)
      fmin
      (let* ([numer (floor (* 3/7 index))]
	     [numb (/ numer index)])
	(if (and (>= numb fmin)
		 (< numb 3/7))
	  (loop numb (sub1 index))
	  (loop fmin (sub1 index)))))))
