;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Problem 1
;;; 
;;; 05 October 2001
;;; 
;;; If we list all the natural numbers below 10 that are multiples of 3
;;; or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
;;; 
;;; Find the sum of all the multiples of 3 or 5 below 1000.
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ns euler.pr1)

(defn- divides-3-or-5
  [num]
  (or (zero? (mod num 3))
      (zero? (mod num 5))))

(defn pr1 []
  (reduce + (filter divides-3-or-5 (range 1 1000))))
