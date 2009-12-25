#lang scheme

;;; In the hexadecimal number system numbers are represented using 16
;;; different digits:
;;; 
;;; 0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F
;;; 
;;; The hexadecimal number AF when written in the decimal number system equals
;;; 10x16+15=175.
;;; 
;;; In the 3-digit hexadecimal numbers 10A, 1A0, A10, and A01 the digits 0,1
;;; and A are all present.
;;; Like numbers written in base ten we write hexadecimal numbers without
;;; leading zeroes.
;;; 
;;; How many hexadecimal numbers containing at most sixteen hexadecimal digits
;;; exist with all of the digits 0,1, and A present at least once?
;;; Give your answer as a hexadecimal number.
;;; 
;;; (A,B,C,D,E and F in upper case, without any leading or trailing code that
;;; marks the number as hexadecimal and without leading zeroes , e.g. 1A3F and
;;; not: 1a3f and not 0x1a3f and not $1A3F and not #1A3F and not 0000001A3F)

(require srfi/13)

;;; First, a brute force implementation so that we can compare against
;;; the real one, at least for the small cases.
(define (valid-number? num)
  (define text (number->string num 16))
  (and (string-index text #\0)
       (string-index text #\a)
       (string-index text #\1)))

;;; Count number within a certain number of digits.
(define (brute-force digits)
  (let loop ([count 0]
	     [num (sub1 (arithmetic-shift 1 (* 4 digits)))])
    (if (negative? num)
      count
      (loop (if (valid-number? num) (add1 count) count)
	    (sub1 num)))))

;;; Non brute force method.

;;; Three cases for the leading digit, A, 1, or a non-zero digit.
(define (leading-digit digits)
  (if (< digits 3) 0
    (+ (* 2 (doublet (sub1 digits)))
       (* 13 (triplet (sub1 digits))))))

;;; Three cases.  Can start with A, 1, or 0, or none of the above.
(define (triplet digits)
  (if (< digits 3) 0
    (+ (* 3 (doublet (sub1 digits)))
       (* 13 (triplet (sub1 digits))))))

;;; For two digit possibilities.
(define (doublet digits)
  (if (< digits 2) 0
    (+ (* 2 (singlet (sub1 digits)))
       (* 14 (doublet (sub1 digits))))))

(define (singlet digits)
  (if (positive? digits)
    (+ (zerolet (sub1 digits))
       (* 15 (singlet (sub1 digits))))
    0))

(define (zerolet digits)
  (if (positive? digits)
    (expt 16 digits)
    1))

(define (how-many digits)
  (for/fold ([sum 0])
    ([i (in-range 3 (add1 digits))])
    (+ sum (leading-digit i))))

(provide main)
(define (main)
  (define many (how-many 16))
  (display (string-upcase (number->string many 16)))
  (newline))
