;;; Setup for interactive use.

;;; Make sure this gets defined in 'user
(in-ns 'user)

(defn enter
  "Takes a number loads that euler problem, and enters it's namespace.
Also pulls in the 'enter' symbol into this ns so the command can be
used again."
  [n]
  (let [name (if (symbol? n)
	       n
	       (symbol (format "euler.pr%03d" n)))]
    (in-ns 'user)
    (require name :verbose :reload)
    (in-ns name)
    (refer 'user :only '[enter])))
