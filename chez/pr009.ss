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
;;; 31875000

#!r6rs

(import
  (rnrs base)
  (rnrs io simple)
  (util))

(define (euler-9)
  (let oloop ((a 1))
    (let iloop ((b a))
      (cond ((>= b 1000)
             (oloop (add1 a)))
            (else
             (let ((c (- 1000 a b)))
               (if (and (> c b)
                        (= (* c c) (+ (* a a) (* b b))))
                   (* a b c)
                   (iloop (add1 b)))))))))

(define (main . argv)
  (display (euler-9))
  (newline))

(main)
