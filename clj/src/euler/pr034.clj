;;; Problem 34
;;;
;;; 03 January 2003
;;;
;;; 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
;;;
;;; Find the sum of all numbers which are equal to the sum of the factorial of
;;; their digits.
;;;
;;; Note: as 1! = 1 and 2! = 2 are not sums they are not included.
;;;
;;; 40730

(ns euler.pr034)

(def ^:private factorials
  (loop [result [1]
	 i 1
	 fact 1]
    (if (< i 10)
      (recur (conj result fact)
	     (inc i)
	     (* fact (inc i)))
      result)))

(defn euler034 []
  (let [total (atom -3)
	last-fact (last factorials)]
    (letfn [(chain [number fact-sum]
		(when (and (pos? number) (= number fact-sum))
		  (swap! total #(+ number %)))
		(when (<= (* number 10) (+ fact-sum last-fact))
		  (doseq [i (range (if (pos? number) 0 1) 10)]
		    (chain (+ (* number 10) i)
			   (+ fact-sum (get factorials i))))))]
      (chain 0 0)
      @total)))
