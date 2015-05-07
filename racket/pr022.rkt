#lang racket

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
;;; COLIN would obtain a score of 938 × 53 = 49714.
;;;
;;; What is the total of all the name scores in the file?

(define (read-names path)
  (call-with-input-file* path
    (lambda (port)
      (define line (read-line port))
      (sort (regexp-match* #px"[A-Z]+" line)
            string<?))))

(define (name->value name)
  (for/sum ([ch (in-string name)])
    (add1 (- (char->integer ch) (char->integer #\A)))))

(define (euler-22)
  (define names (read-names "../haskell/names.txt"))
  (for/sum ([i (in-naturals 1)]
            [name (in-list names)])
    (* i (name->value name))))

(module* main #f
  (euler-22))
