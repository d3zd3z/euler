;;; Problem 7
;;;
;;; 28 December 2001
;;;
;;; By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
;;; that the 6th prime is 13.
;;;
;;; What is the 10 001st prime number?
;;;
;;; 104743

(ns euler.pr007)

;;; This is a functional lazy prime sieve, taken from the haskell version.

;;; The essential idea of this sieve, is that we maintain a data
;;; structure holding all of the iterators of the primes.  Each time
;;; we learn of a new prime, we add an entry to this structure for the
;;; next composite it encounters.  Storing this in a sorted-map keyed
;;; by the next composite value makes it easy to extract the next
;;; composite from the structure.
;;;
;;; As a shortcut, only consider the odd numbers, and skip the
;;; multiples of two in the factors.

(def initial-state (sorted-map 9 '(6)))

;;; Peek at the next composite, and if it is greater than 'n', return
;;; that n is prime.
(defn st-prime?
  [state n]
  (< n (first (first state))))

;;; Insert a new node into the state, returning the new state.  The
;;; 'step' is 2*p for the prime of concern.
(defn st-insert
  [state comp step]
  (let [others (get state comp '())]
    (assoc state comp (cons step others))))

;;; When we've learned of a new prime number, update the state by
;;; adding the next composite and adding a step-value for it.  If this
;;; next composite is "fresh", just add the new value, otherwise,
;;; update the composite with another step value.
(defn st-add-prime
  [state p]
  (st-insert state (* p p) (+ p p)))

;;; Once st-prime? returns true, eat the lowest composite number, and
;;; associate update the next composites based on the step values.
(defn st-update
  [state]
  (let [comp-pair (first state)
	comp (first comp-pair)
	rstate (dissoc state comp)
	steps (second comp-pair)]
    (reduce (fn [st step]
	      (st-insert st (+ comp step) step))
	    rstate
	    steps)))

(defn lazy-primes
  ([] (list* 2 3 (lazy-primes initial-state 5)))
  ([state n]
     (if (st-prime? state n)
       (cons n (lazy-seq (lazy-primes (st-add-prime state n) (+ n 2))))
       (lazy-primes (st-update state) (+ n 2)))))

(defn euler007 []
  (nth (lazy-primes) 10000))
