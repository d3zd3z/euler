;;; Problem 1
;;;
;;; 05 October 2001
;;;
;;; If we list all the natural numbers below 10 that are multiples of 3 or 5,
;;; we get 3, 5, 6 and 9. The sum of these multiples is 23.
;;;
;;; Find the sum of all the multiples of 3 or 5 below 1000.
;;;
;;; 233168

(ns euler.pr001)

(defn euler001
  []
  (let [nums (range 1 1000)
	valids (filter (fn [x] (or (zero? (mod x 3))
				   (zero? (mod x 5))))
		       nums)]
    (reduce + valids)))
