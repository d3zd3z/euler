;;; Problem 17
;;;
;;; 17 May 2002
;;;
;;; If the numbers 1 to 5 are written out in words: one, two, three, four,
;;; five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
;;;
;;; If all the numbers from 1 to 1000 (one thousand) inclusive were written
;;; out in words, how many letters would be used?
;;;
;;; NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
;;; forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
;;; 20 letters. The use of "and" when writing out numbers is in compliance
;;; with British usage.
;;;
;;; 21124

(ns euler.pr017)

(defn- count-letters [text]
  (reduce + (for [i (range (count text))
		  :let [ch (get text i)]]
	      (if (java.lang.Character/isLetter ch) 1 0))))

(def ^:private one-names
     ["one" "two" "three" "four" "five" "six" "seven" "eight" "nine"
      "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen"
      "seventeen" "eighteen" "nineteen"])

(def ^:private ten-names
     ["ten" "twenty" "thirty" "forty" "fifty" "sixty" "seventy"
      "eighty" "ninety"])

(defn- ones [n] (get one-names (dec n)))
(defn- tens [n] (get ten-names (dec n)))

(defn- textify [n]
  (cond
   (> n 1000) (throw (Exception. "Number out of range"))
   (= n 1000) "one thousand"
   (>= n 100) (let [num (mod n 100)
		    and-text (if (pos? num) "and " "")]
		(str (ones (quot n 100))
		     " hundred " and-text
		     (textify num)))
   (>= n 20) (let [num (mod n 10)
		   hyphen (if (pos? num) "-" " ")]
	       (str (tens (quot n 10)) hyphen
		    (textify num)))
   (>= n 1) (ones n)
   :else ""))

(defn euler017 []
  (reduce + (for [x (range 1 1001)
		  :let [text (textify x)]]
	      (count-letters text))))
