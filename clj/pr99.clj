;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comparing two numbers written in index form like 2^(11) and 3^(7)
;; is not difficult, as any calculator would confirm that 2^(11) =
;; 2048 < 3^(7) = 2187.
;;
;; However, confirming that 632382^(518061) > 519432^(525806) would be
;; much more difficult, as both numbers contain over three million
;; digits.
;;
;; Using base_exp.txt (right click and 'Save Link/Target As...'), a
;; 22K text file containing one thousand lines with a base/exponent
;; pair on each line, determine which line number has the greatest
;; numerical value.
;;
;; NOTE: The first two lines in the file represent the numbers in the
;; example given above.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This isn't particularly hard, just take the log of both sides of
;; the equation, so that  a^b <> c^d becomes b*log(a) <> d*log(c)

(ns pr99
  (:use [clojure.contrib.duck-streams :only (reader read-lines)])
  (:use [clojure.contrib.str-utils]))

(defonce +numbers-name+ "base_exp.txt")

(defstruct node :base :exp :mag :line)

(defn conv [nums line]
  (let [pair (map #(Integer/parseInt %) (re-split #"," nums))
        base (first pair)
        exp (second pair)
        mag (* (Math/log base) exp)]
    (struct-map node
                :base base
                :exp exp
                :mag mag
                :line line)))

(defn get-numbers []
  (let [lines (read-lines (reader +numbers-name+))
        line-numbers (iterate inc 1)]
    (map conv lines line-numbers)))

(defn biggest-node
  "Return the node with the biggest magnitude"
  [a b]
  (if (> (get a :mag) (get b :mag)) a b))

(def largest
  (reduce biggest-node (get-numbers)))
(printf "Largest is on line: %d\n" (get largest :line))
