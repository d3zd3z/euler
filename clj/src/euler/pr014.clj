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
;;;
;;; 837799

(ns euler.pr014)

;;; Simple properly-tail recursive non-cached version.
(defn chain-length [n]
  (loop [length 1
	 n n]
    (cond (= n 1) length
	  (even? n) (recur (inc length) (quot n 2))
	  :else (recur (inc length) (inc (* n 3))))))

;;; Non-proper tail recursive one, but one with memoization.
(defn cached-chain-length []
  (letfn [(next [chain n]
		(cond (= n 1) 1
		      (even? n) (inc (chain (quot n 2)))
		      :else (inc (chain (inc (* n 3))))))]
    (let [cached-next (memoize next)]
      (letfn [(chain [n] (cached-next chain n))]
	#(next chain %)))))

;;; Solve for the given chain-length function.
(defn solve [chain-length]
  (apply max-key chain-length (range 1 1000000)))

;;; Non, 'apply' version.
(defn solve2 [chain-length]
  (loop [longest 0
	 longest-n nil
	 n 1]
    (if (>= n 1000000)
      longest-n
      (let [this-len (chain-length n)]
	(if (> this-len longest)
	  (recur this-len n (inc n))
	  (recur longest longest-n (inc n)))))))

(defn euler014 []
  (solve2 (cached-chain-length)))
