;;; Problem 33
;;;
;;; 20 December 2002
;;;
;;; The fraction ^49/[98] is a curious fraction, as an inexperienced
;;; mathematician in attempting to simplify it may incorrectly believe that ^
;;; 49/[98] = ^4/[8], which is correct, is obtained by cancelling the 9s.
;;;
;;; We shall consider fractions like, ^30/[50] = ^3/[5], to be trivial
;;; examples.
;;;
;;; There are exactly four non-trivial examples of this type of fraction, less
;;; than one in value, and containing two digits in the numerator and
;;; denominator.
;;;
;;; If the product of these four fractions is given in its lowest common
;;; terms, find the value of the denominator.
;;;
;;; 100

(ns euler.pr033)

(defn- frac-a-p?
  "Is the fraction of a/b of the form described by the problem."
  [a b]
  (let [an (quot a 10)
	am (rem a 10)
	bn (quot b 10)
	bm (rem b 10)]
    (or (and (= an bm)
	     (pos? bn)
	     (= (/ am bn) (/ a b)))
	(and (= am bn)
	     (pos? bm)
	     (= (/ an bm) (/ a b))))))

(defn euler033 []
  (denominator
   (reduce *
	   (for [a (range 10 100)
		 b (range (inc a) 100)
		 :when (frac-a-p? a b)]
	     (/ a b)))))
