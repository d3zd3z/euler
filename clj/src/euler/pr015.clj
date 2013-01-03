;;; Problem 15
;;;
;;; 19 April 2002
;;;
;;; Starting in the top left corner of a 2x2 grid, there are 6 routes (without
;;; backtracking) to the bottom right corner.
;;;
;;; [p_015]
;;;
;;; How many routes are there through a 20x20 grid?
;;;
;;; 137846528820

(ns euler.pr015)

(defn base [n] (repeat (inc n) 1))

;;; (Yes, count of lists is O(1) in clojure).
(defn bump [n]
  (cond (>= (count n) 2)
	(let [a (first n)
	      as (rest n)
	      b (first as)
	      bs (rest as)]
	  (cons a (bump (cons (+ a b) bs))))
	:else n))

(defn euler015 []
  (last (nth (iterate bump (base 20))
	     20)))
