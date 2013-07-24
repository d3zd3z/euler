#! /usr/local/bin/guile -s
!#

;;; Problem 4
;;;
;;; 16 November 2001
;;;
;;;
;;; A palindromic number reads the same both ways. The largest palindrome made
;;; from the product of two 2-digit numbers is 9009 = 91 x 99.
;;;
;;; Find the largest palindrome made from the product of two 3-digit numbers.
;;;
;;; 906609

(define (reverse-digits number)
  (let loop ((result 0)
             (number number))
    (if (zero? number)
      result
      (loop (+ (* result 10) (remainder number 10))
            (quotient number 10)))))

(define (palindrome? number)
  (= number (reverse-digits number)))

(define (euler-4)
  (let loop ((a 100)
             (best 0))
    (if (> a 999) best
      (loop (1+ a)
            (let iloop ((b a)
                        (best best))
              (if (> b 999) best
                (let* ((c (* a b))
                       (new-best
                         (if (and (> c best) (palindrome? c))
                           c best)))
                  (iloop (1+ b) new-best))))))))

(define (main)
  (display (euler-4))
  (newline))
(main)
