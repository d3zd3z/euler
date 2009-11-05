;; Problem 69
;; 
;; 07 May 2004
;; 
;; 
;; Euler's Totient function, φ(n) [sometimes called the phi function], is used to
;; determine the number of numbers less than n which are relatively prime to n.
;; For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively
;; prime to nine, φ(9)=6.
;; 
;; ┌──┬────────────────┬────┬─────────┐
;; │n │Relatively Prime│φ(n)│n/φ(n)   │
;; ├──┼────────────────┼────┼─────────┤
;; │2 │1               │1   │2        │
;; ├──┼────────────────┼────┼─────────┤
;; │3 │1,2             │2   │1.5      │
;; ├──┼────────────────┼────┼─────────┤
;; │4 │1,3             │2   │2        │
;; ├──┼────────────────┼────┼─────────┤
;; │5 │1,2,3,4         │4   │1.25     │
;; ├──┼────────────────┼────┼─────────┤
;; │6 │1,5             │2   │3        │
;; ├──┼────────────────┼────┼─────────┤
;; │7 │1,2,3,4,5,6     │6   │1.1666...│
;; ├──┼────────────────┼────┼─────────┤
;; │8 │1,3,5,7         │4   │2        │
;; ├──┼────────────────┼────┼─────────┤
;; │9 │1,2,4,5,7,8     │6   │1.5      │
;; ├──┼────────────────┼────┼─────────┤
;; │10│1,3,7,9         │4   │2.5      │
;; └──┴────────────────┴────┴─────────┘
;; 
;; It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.
;; 
;; Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.

(ns pr69
  (:use clojure.contrib.lazy-seqs)
  (:use [clojure.contrib.math :only (expt)]))

(defn count-divides
  "Count the number of times d divides into n, d must be > 0, and n must be > 1.
  Returns [count new-div]"
  [n d]
  (loop [n n
         count 0]
    (if (zero? (mod n d))
      (recur (quot n d) (inc count))
      [count n])))

(defn factors
  "Compute prime factors, and their counts.  For example, (factors 12345678)
  is [[2 1] [3 2] [47 1] [14593 1]]"
  [#^Integer n]
  (loop [n n
         primes primes
         answer []]
    (if (== n 1)
      answer
      (let [prime (first primes)
            next-primes (rest primes)
            [num-divs new-num] (count-divides n prime)]
        (if (zero? num-divs)
          (recur n next-primes answer)
          (recur new-num next-primes (conj answer [prime num-divs])))))))

(defn prime-totient
  "Determine the totient of p^k where p is prime."
  [[p k]]
  (* (dec p) (expt p (dec k))))

(def next-progress (ref -1))
(defn progress [x]
  (dosync
    (when (> x @next-progress)
      (prn "at" x)
      (alter next-progress + 10000))))

(defn totient
  "Compute the value of the totient function"
  [n]
  (progress n)
  (reduce * (map prime-totient (factors n))))

(defn biggest-second
  [[na a :as aa] [nb b :as bb]]
  (if (> (/ na a) (/ nb b)) aa bb))

(defn answer [& bounds]
  (reduce biggest-second
          (map (fn [x] [x (totient x)]) (apply range bounds))))

; BTW, this solution is very slow (15 minutes on my machine).
; Reasoning I don't quite understand suggests that the correct answer
; should be the largest number in the given range that is made of the
; product of the first 'n' prime numbers.
(prn "Answer: " (time (answer 1 1000000)))
