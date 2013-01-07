;;; Invoke euler problems.

(ns euler.main
  (:import (java.io FileNotFoundException))
  (:gen-class))

;;; There isn't really a clean way to find out which file may be
;;; present.  Instead, scan all possible problems, and see what we
;;; happen to find.  A better approach would be to compute a list of
;;; them at build time, using some information available in Leinengen.

(defn- scan-problem
  "Look for an euler problem #n, and if it exists, invoke '(fun arg n
thunk)' where thunk is the function to invoke to run the problem.  If
the problem was not found, just returns arg."
  [n fun arg]
  (let [ns-name (symbol (format "euler.pr%03d" n))
	thunk-name (symbol (format "euler%03d" n))]
    (try
      (require ns-name)
      (when-let [the-ns (find-ns ns-name)]
	(when-let [thunk (ns-resolve the-ns thunk-name)]
	  (fun arg n thunk)))
      (catch FileNotFoundException e arg))))

(defn- scan-problems
  "Scan for all present euler problems."
  []
  (reduce (fn [mapping n]
	    (scan-problem n assoc mapping))
	  {}
	  (range 1 1000)))

(defn- run-test [num thunk]
  (print num ": ")
  (flush)
  (println (thunk)))

(defn- run-all []
  (doseq [test (scan-problems)]
    (run-test (key test) (val test))))

(defn- run-some [tests]
  (let [problems (scan-problems)]
    (doseq [test tests]
      (if-let [op (get problems (Integer/parseInt test))]
	(run-test test op)
	(println "Unknown test" test)))))

(defn -main
  "With no arguments, prints help.  A single argument of 'all' will
run all of them.  Otherwise, they should be the numbers"
  [& args]
  (cond (zero? (count args)) (println "Usage: euler {all|n n n n}")
	(and (= (count args) 1)
	     (= (first args) "all"))
	(run-all)
	:else (run-some args)))
