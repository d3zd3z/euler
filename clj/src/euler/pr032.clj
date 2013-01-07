;;; Problem 32
;;;
;;; 06 December 2002
;;;
;;; We shall say that an n-digit number is pandigital if it makes use of all
;;; the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
;;; 1 through 5 pandigital.
;;;
;;; The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing
;;; multiplicand, multiplier, and product is 1 through 9 pandigital.
;;;
;;; Find the sum of all products whose multiplicand/multiplier/product
;;; identity can be written as a 1 through 9 pandigital.
;;;
;;; HINT: Some products can be obtained in more than one way so be sure to
;;; only include it once in your sum.
;;;
;;; 45228

(ns euler.pr032
  (:use clojure.set)
  (:use clojure.math.combinatorics))

(defn- digit-permutations []
  (map #(apply str %) (permutations "123456789")))

(defn- string->number [text] (Integer/parseInt text))

;;; Find all of the groups that can be built out of this group of digits.
(defn- make-groupings [digits]
  (let [len (count digits)]
    (reduce union #{}
	    (for [i (range 1 (- len 2))
		  j (range (inc i) (dec len))]
	      (let [piece (fn [a b]
			    (string->number (subs digits a b)))
		    a (piece 0 i)
		    b (piece i j)
		    c (piece j len)]
		(if (= (* a b) c)
		  #{c}
		  #{}))))))

(defn euler032 []
  (reduce + (reduce union #{} (map make-groupings (digit-permutations)))))
