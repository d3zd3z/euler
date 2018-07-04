;; Problem 34
;;
;; 03 January 2003
;;
;;
;; 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
;;
;; Find the sum of all numbers which are equal to the sum of the factorial of
;; their digits.
;;
;; Note: as 1! = 1 and 2! = 2 are not sums they are not included.
;;
;; 40730

(import
  (rnrs base (6))
  (rnrs control (6))
  (rnrs io simple (6)))

;;; Return the factorial of a given digit.
(define digit-factorial
  (let ()
    (define (make-facts)
      (do ([i 1 (+ i 1)]
	   [cur 1 (* cur i)]
	   [cum '() (cons cur cum)])
	[(= i 11)
	 (list->vector (reverse cum))]))
    (define *facts* (make-facts))

    (lambda (n)
      (vector-ref *facts* n))))

(define (euler-34)
  ;; Start with -3, since the problem states that 1! and 2! are not to
  ;; be included in the sum.
  (define total -3)
  (define last-fact (digit-factorial 9))

  (let chain ([number 0]
	      [fact-sum 0])
    (when (and (> number 0)
	       (= number fact-sum))
      (set! total (+ total number)))
    (when (<= (* number 10)
	      (+ fact-sum last-fact))
      (do ([i (if (positive? number) 0 1) (+ i 1)])
	[(= i 10) total]
	(chain (+ (* number 10) i)
	       (+ fact-sum (digit-factorial i)))))))

(define (main)
  (display (euler-34))
  (newline))
(main)
