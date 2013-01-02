;;; Problem 4
;;;
;;; 16 November 2001
;;;
;;; A palindromic number reads the same both ways. The largest palindrome made
;;; from the product of two 2-digit numbers is 9009 = 91 x 99.
;;;
;;; Find the largest palindrome made from the product of two 3-digit numbers.
;;;
;;; 906609

(ns euler.pr004)

(defn reverse-digits
  [n]
  (loop [n n
	 result 0]
    (if (zero? n) result
	(recur (quot n 10)
	       (+ (* result 10) (rem n 10))))))

(defn palindrome?
  [n]
  (= n (reverse-digits n)))

(defn euler004
  []
  (reduce max (for [a (range 100 1000)
		    b (range a 1000)
		    :let [c (* a b)]
		    :when (palindrome? c)]
		c)))
