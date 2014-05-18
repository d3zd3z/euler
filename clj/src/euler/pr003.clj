;;; Problem 3
;;;
;;; 02 November 2001
;;;
;;; The prime factors of 13195 are 5, 7, 13 and 29.
;;;
;;; What is the largest prime factor of the number 600851475143 ?
;;;
;;; 6857

(ns euler.pr003)

(defn largest
  [n]
  (loop [n n
         p 3]
    (cond (= n 1) p
          (zero? (rem n p)) (recur (quot n p) p)
          :else (recur n (+ p 2)))))

(defn euler003
  []
  (largest 600851475143))
