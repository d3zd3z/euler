;#!/usr/bin/env gsi

;;; Problem 22
;;;
;;; 19 July 2002
;;;
;;; Using names.txt (right click and 'Save Link/Target As...'), a 46K text
;;; file containing over five-thousand first names, begin by sorting it into
;;; alphabetical order. Then working out the alphabetical value for each name,
;;; multiply this value by its alphabetical position in the list to obtain a
;;; name score.
;;;
;;; For example, when the list is sorted into alphabetical order, COLIN, which
;;; is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
;;; COLIN would obtain a score of 938 x 53 = 49714.
;;;
;;; What is the total of all the name scores in the file?
;;;
;;; 871198282

(import (srfi sorting))

(define (read-names)
  (define (reader inp)

    (define (open-quote result)
      (define ch (read-char inp))
      (cond ((eof-object? ch)
             (error "Empty input"))
            ((char=? ch #\")
             (name result '()))
            (else (error "Illegal character"))))

    (define (name result buf)
      (define ch (read-char inp))
      (cond ((eof-object? ch)
             (error "Unexpected EOF"))
            ((char=? ch #\")
             (comma (cons (list->string (reverse buf)) result)))
            ((char-upper-case? ch)
             (name result (cons ch buf)))
            (else (error "Illegal character"))))

    (define (comma result)
      (define ch (read-char inp))
      (cond ((eof-object? ch)
             result)
            ((char=? ch #\,)
             (open-quote result))
            (else (error "Illegal character"))))

    (open-quote '()))

  (call-with-input-file "../haskell/names.txt" reader))

(define (name-value name)
  (define len (string-length name))
  (let loop ((pos 0)
             (sum 0))
    (if (= pos len)
        sum
        (loop (+ pos 1)
              (+ sum (char->integer (string-ref name pos))
                 (- (char->integer #\A))
                 1)))))

(define (euler-22)
  (define names (sort (read-names) string<?))
  (let loop ((names names)
             (total 0)
             (pos 1))
    (if (null? names)
        total
        (loop (cdr names)
              (+ total (* pos (name-value (car names))))
              (+ pos 1)))))

(define (main . argv)
  (display (euler-22))
  (newline))

(main)
