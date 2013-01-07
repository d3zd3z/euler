;;; Problem 20
;;;
;;; 21 June 2002
;;;
;;; n! means n x (n − 1) x ... x 3 x 2 x 1
;;;
;;; For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
;;; and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 =
;;; 27.
;;;
;;; Find the sum of the digits in the number 100!
;;;
;;; 648

(ns euler.pr020)

(defn- digit-sum [n]
  (loop [n n
	 result 0]
    (if (zero? n)
      result
      (recur (quot n 10)
	     (+ result (int (mod n 10)))))))

(defn- fact [n]
  (reduce *' (range 1 (inc n))))

(defn euler020 []
  (digit-sum (fact 100)))
