;;; Problem 22
;;;
;;; 19 July 2002
;;;
;;; Using names.txt (right click and 'Save Link/Target As...'), a 46K text
;;; file containing over five-thousand first names, begin by sorting it into
;;; alphabetical order. Then working out the alphabetical value for each name,
;;; multiply this value by its alphabetical position in the list to obtain a
;;; name score.
;;;
;;; For example, when the list is sorted into alphabetical order, COLIN, which
;;; is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
;;; COLIN would obtain a score of 938 x 53 = 49714.
;;;
;;; What is the total of all the name scores in the file?
;;;
;;; 871198282

(ns euler.pr022)

(defn- clean-quotes [name]
  (subs name 1 (dec (count name))))

(defn- read-names []
  (map clean-quotes
       (seq (.split (slurp "../haskell/names.txt") ","))))

(defn- name-value [name]
  (reduce + (map (fn [x] (- (int x) (int \A) -1)) name)))

(defn euler022 []
  (reduce + (map-indexed (fn [n name]
			   (* (inc n) (name-value name)))
			 (sort (read-names)))))
