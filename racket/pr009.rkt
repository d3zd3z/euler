#lang racket

;;; Problem 9
;;; 
;;; 25 January 2002
;;; 
;;; A Pythagorean triplet is a set of three natural numbers, a < b < c, for
;;; which,
;;; 
;;; a^2 + b^2 = c^2
;;; 
;;; For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
;;; 
;;; There exists exactly one Pythagorean triplet for which a + b + c = 1000.
;;; Find the product abc.
;;; 

(define (euler-9)
  (let/ec return
    (for ([a (in-range 1 1000)])
         (for ([b (in-range a 1000)])
              (let ([c (- 1000 a b)])
                (when (and (> c b)
                           (= (+ (sqr a) (sqr b)) (sqr c)))
                  (return (* a b c))))))
    (error "No solution")))