#lang racket

(require data/gvector)
(require data/heap)

(provide make-sieve)
(provide sieve-next)

;;; TODO: Move this sieve implementation into it's own module.
(struct node (next (steps #:mutable)) #:transparent #:constructor-name make-node)
(struct sieve ((prime #:mutable) nodes heap)
        #:constructor-name %sieve
        #:transparent)

(define (node<= a b)
  (<= (node-next a) (node-next b)))

(define (make-sieve)
  (%sieve 2
          (make-hasheqv)
          (make-heap node<=)))

(define (add-node sieve next step)
  (define node (hash-ref! (sieve-nodes sieve) next
                          (lambda ()
                            (define node (make-node next '()))
                            (heap-add! (sieve-heap sieve) node)
                            node)))
  (set-node-steps! node (cons step (node-steps node))))

;; Update the lowest keyed node in the heap.
(define (update-first sieve)
  (define heap (sieve-heap sieve))
  (define head (begin0
                   (heap-min heap)
                 (heap-remove-min! heap)))
  (define next (node-next head))
  (hash-remove! (sieve-nodes sieve) next)
  (for ([step (in-list (node-steps head))])
       (add-node sieve (+ next step) step)))

(define (sieve-next sieve)
  (case (sieve-prime sieve)
    [(2)
     (set-sieve-prime! sieve 3)
     2]
    [(3)
     (set-sieve-prime! sieve 5)
     (add-node sieve 9 6)
     3]
    [else
     ;; Advance the potential prime until done.
     (let loop ()
       (define peek (heap-min (sieve-heap sieve)))
       (define cur (sieve-prime sieve))

       ;; If the 'next' divisor is greater than our current number,
       ;; the current one is prime.
       (if (< cur (node-next peek))
           (begin
             (set-sieve-prime! sieve (+ cur 2))
             (add-node sieve (* cur cur) (+ cur cur))
             cur)
           ;; Otherwise, it is composite, advance the next values, and move on.
           (begin
             (update-first sieve)
             (set-sieve-prime! sieve (+ (sieve-prime sieve) 2))
             (loop))))]))
