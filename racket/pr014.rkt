#lang racket

;;; Problem 14
;;; 
;;; 05 April 2002
;;; 
;;; The following iterative sequence is defined for the set of positive
;;; integers:
;;; 
;;; n → n/2 (n is even)
;;; n → 3n + 1 (n is odd)
;;; 
;;; Using the rule above and starting with 13, we generate the following
;;; sequence:
;;; 
;;; 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
;;; 
;;; It can be seen that this sequence (starting at 13 and finishing at 1)
;;; contains 10 terms. Although it has not been proved yet (Collatz Problem),
;;; it is thought that all starting numbers finish at 1.
;;; 
;;; Which starting number, under one million, produces the longest chain?
;;; 
;;; NOTE: Once the chain starts the terms are allowed to go above one million.

;;; First, non-memoized version.

(define (chain-length n)
  (let loop ([length 1]
             [n n])
    (cond [(= n 1) length]
          [(even? n) (loop (add1 length) (/ n 2))]
          [else (loop (add1 length) (add1 (* n 3)))])))

(define cache (make-parameter #f))

(define (cached-chain-length n)
  (hash-ref! (cache) n
             (lambda ()
               (cond [(= n 1) 1]
                     [(even? n) (add1 (cached-chain-length (/ n 2)))]
                     [else (add1 (cached-chain-length (add1 (* n 3))))]))))

(define (euler-14)
  (parameterize ([cache (make-hasheqv)])
    (let loop ([largest 0]
               [largest-value #f]
               [n 1])
      (if (= n 1000000)
          largest-value
          (let ([temp (cached-chain-length n)])
            (if (> temp largest)
                (loop temp n (add1 n))
                (loop largest largest-value (add1 n))))))))
