(ns euler.sieve)

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

(def ^:private initial-state (sorted-map 9 '(6)))

;;; Peek at the next composite, and if it is greater than 'n', return
;;; that n is prime.
(defn- st-prime?
  [state n]
  (< n (first (first state))))

;;; Insert a new node into the state, returning the new state.  The
;;; 'step' is 2*p for the prime of concern.
(defn- st-insert
  [state comp step]
  (let [others (get state comp '())]
    (assoc state comp (cons step others))))

;;; When we've learned of a new prime number, update the state by
;;; adding the next composite and adding a step-value for it.  If this
;;; next composite is "fresh", just add the new value, otherwise,
;;; update the composite with another step value.
(defn- st-add-prime
  [state p]
  (st-insert state (* p p) (+ p p)))

;;; Once st-prime? returns true, eat the lowest composite number, and
;;; associate update the next composites based on the step values.
(defn- st-update
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; More traditional type of prime sieve.  But, using functional
;;; updates, just as a performance comparison.  It seems to be about 2x as fast.

(defn- empty-sieve [n]
  (vec (list* false false (repeat (- n 2) true))))

;;; Mark the composites in the sieve
(defn- mark-composites [sieve p]
  (reduce
   (fn [sieve n] (assoc sieve n false))
   sieve
   (range (+ p p) (count sieve) p)))

(defn- build-sieve [size]
  (loop [sieve (mark-composites (empty-sieve size) 2)
	 p 3]
    (cond
     (>= p size) sieve
     (get sieve p) (recur (mark-composites sieve p) (+ p 2))
     :else (recur sieve (+ p 2)))))

(defn make-sieve []
  (atom (build-sieve 1024)))

;;; Version with transients.  This gives about a 2x speedup.
(defn- t-mark-composites [sieve p]
  (reduce
   (fn [sieve n] (assoc! sieve n false))
   sieve
   (range (+ p p) (count sieve) p)))

(defn- t-build-sieve [size]
  (loop [sieve (t-mark-composites (transient (empty-sieve size)) 2)
	 p 3]
    (cond
     (>= p size) (persistent! sieve)
     (get sieve p) (recur (t-mark-composites sieve p) (+ p 2))
     :else (recur sieve (+ p 2)))))

;;; Return the sieve, after updating it to make sure there is enough
;;; room to query 'n'.
(defn- sieve-enough [sieve n]
  (let [sv @sieve]
    (if (> (count sv) n)
      sv
      (do
	(swap! sieve
	       (fn [sv]
		 (let [new-size (loop [size (count sv)]
				  (if (> size n)
				    size
				    (recur (* size 8))))]
		   (t-build-sieve new-size))))
	@sieve))))

(defn prime? [sieve n]
  (get (sieve-enough sieve n) n))

(defn next-prime [sieve n]
  (loop [n (if (= n 2) 3 (+ n 2))]
    (if (prime? sieve n) n
	(recur (+ n 2)))))

(defn- add-factor [result p count]
  (if (pos? count)
    (conj result [p count])
    result))

;;; Lazy prime generator based on a sieve.  Useful if code needs both
;;; a sequence, and tests.
(defn sieved-lazy-primes
  ([sieve] (sieved-lazy-primes sieve 2))
  ([sieve p]
     (cons p
	   (lazy-seq (sieved-lazy-primes sieve (next-prime sieve p))))))

;;; Compute the prime factors of n, with their powers.
(defn factorize [sieve n]
  (loop [result []
	 n n
	 p 2
	 count 0]
    (if (= n 1)
      (add-factor result p count)
      (if (zero? (mod n p))
	(recur result (quot n p) p (inc count))
	(recur (add-factor result p count)
	       n (next-prime sieve p) 0)))))

(defn divisor-count [sieve n]
  (reduce * (for [f (factorize sieve n)]
	      (inc (second f)))))

;;; Computing the divisors of the number.

(defn- spread [factors]
  (if (empty? factors)
    [1]
    (let [x (first factors)
	  x-prime (first x)
	  x-power (second x)
	  others (spread (rest factors))]
      (loop [result '()
	     power 1
	     i 0]
	(if (> i x-power)
	  result
	  (recur (concat result (map #(* % power) others))
		 (* power x-prime)
		 (inc i)))))))

(defn divisors [sieve n]
  (sort (spread (factorize sieve n))))

(defn proper-divisor-sum [sieve n]
  (- (reduce + (divisors sieve n)) n))
