#lang racket

;;; Problem 17
;;;
;;; 17 May 2002
;;;
;;; If the numbers 1 to 5 are written out in words: one, two, three, four,
;;; five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
;;;
;;; If all the numbers from 1 to 1000 (one thousand) inclusive were written
;;; out in words, how many letters would be used?
;;;
;;; NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
;;; forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
;;; 20 letters. The use of "and" when writing out numbers is in compliance
;;; with British usage.
;;;

(require (planet neil/numspell:1:2))

;;; The numspell library doesn't use the "and" (it is American style,
;;; although it supports the British style long numbers.

(define (needs-and? number)
  (let-values ([(upper lower) (quotient/remainder (remainder number 1000) 100)])
    (and (positive? upper) (positive? lower))))

(define (boolean->number b)
  (if b 1 0))

(define (count-letters text)
  (for/sum ([ch (in-string text)])
    (boolean->number (char-alphabetic? ch))))

(define (letters-in-number number)
  (+ (count-letters (number->english number))
     (* (boolean->number (needs-and? number)) 3)))

(define (euler-17)
  (for/sum ([i (in-range 1 1001)])
    (letters-in-number i)))

(display (euler-17))
(newline)
