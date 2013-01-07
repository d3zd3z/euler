;;; Problem 9
;;;
;;; 25 January 2002
;;;
;;; A Pythagorean triplet is a set of three natural numbers, a < b < c, for
;;; which,
;;;
;;; a^2 + b^2 = c^2
;;;
;;; For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
;;;
;;; There exists exactly one Pythagorean triplet for which a + b + c = 1000.
;;; Find the product abc.
;;;
;;; 31875000

(ns euler.pr009)

(defn sqr [x] (* x x))

(defn euler009 []
  (first
   (for [a (range 1 1000)
	 b (range a 1000)
	 :let [c (- 1000 a b)]
	 :when (and (> c b)
		    (= (+ (sqr a) (sqr b)) (sqr c)))]
     (* a b c))))
