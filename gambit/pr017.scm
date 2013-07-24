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
;;; 21124

(import util)

(define ones '#("one" "two" "three" "four" "five" "six" "seven"
		"eight" "nine" "ten" "eleven" "twelve" "thirteen"
		"fourteen" "fifteen" "sixteen" "seventeen" "eighteen"
		"nineteen"))

(define tens '#("ten" "twenty" "thirty" "forty" "fifty" "sixty"
		"seventy" "eighty" "ninety"))

(define (convert number)
  (define work number)
  (define add-space? #f)
  (define words '())
  (define (add word)
    (when add-space?
      (set! words (cons " " words)))
    (set! words (cons word words))
    (set! add-space? #t))

  (when (> work 1000)
    (raise "Number too large"))

  (if (= work 1000)
    "one thousand"

    (begin
      (when (>= work 100)
        (add (vector-ref ones (- (quotient work 100) 1)))
        (add "hundred")
        (set! work (remainder work 100))
        (when (positive? work)
          (add "and")))

      (when (>= work 20)
        (add (vector-ref tens (- (quotient work 10) 1)))
        (set! work (remainder work 10))
        (when (positive? work)
          (set! add-space? #f)
          (add "-")
          (set! add-space? #f)))

      (when (positive? work)
        (add (vector-ref ones (- work 1))))

      (apply string-append (reverse words)))))

(define (count-letters text)
  (define stop (string-length text))
  (define count 0)
  (do ((i 0 (+ i 1)))
      ((= i stop)
       count)
    (when (char-alphabetic? (string-ref text i))
      (set! count (+ count 1)))))

(define (euler-17)
  (define total 0)
  (do ((i 1 (+ i 1)))
      ((= i 1001) total)
    (let* ((text (convert i))
           (len (count-letters text)))
      (set! total (+ total len)))))

(display (euler-17))
(newline)
