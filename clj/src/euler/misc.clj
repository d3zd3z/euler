;;; Misc euler utilities.

(ns euler.misc
  (:use clojure.math.numeric-tower))

;;; lazy-permutations produces all of the permutations of a sequence,
;;; but not in a lexicographical order.  It will also return duplicate
;;; results if there are duplicate elements.  However, it can also be
;;; used on infinite lazy sequences and will begin returning results
;;; after only evaluating the beginning of the sequence.
;;;
;;; TODO: Not really needed, since clojure.math.combinatorics has a
;;; permutation function.  This would be needed if we need to be able
;;; to do it with unbounded sequences.

(defn digits->num
  "Given a sequence of digits (0 to 9) as numbers, return the integer
formed by taking those in order.  For example (digits->num [1 3 5 7])
returns 1357."
  [digits]
  (loop [result 0
	 n digits]
    (if (empty? n)
      result
      (recur (+' (*' result 10) (first n))
	     (rest n)))))

(defn digit-power-sum
  "Returns the sum of the digits each raised to power."
  [number power]
  (loop [number number
	 sum 0]
    (if (zero? number)
      sum
      (recur (quot number 10)
	(+' sum (expt (rem number 10) power))))))

(defn max-key-of
  "Like 'max-key', but takes a collection rather than applying to it's
arguments."
  [k col]
  (cond
   (empty? col) (throw (Exception. "Bogus use"))
   (= (count col) 1) (first col)
   :else (let [first-key (k (first col))
	       first-item (first col)]
	   (second (reduce (fn [best item]
			     (let [kh (k item)]
			       (if (> kh (first best))
				 [kh item]
				 best)))
			   [first-key first-item]
			   (rest col))))))

(defn reverse-digits
  "Reverse the digits in the given decimal number."
  ([n] (reverse-digits n 10))
  ([n base]
     (loop [n n
	 result 0]
    (if (zero? n) result
	(recur (quot n base)
	       (+ (* result base) (rem n base)))))))

(defn palindrome-number?
  ([n] (palindrome-number? n 10))
  ([n base]
     (= n (reverse-digits n base))))
