;;; System definition for Euler problems
;;;
;;; vim: ft=lisp

(defsystem "euler"
  :description "euler: Lisp solutions to project Euler problems"
  :version "0.0.1"
  :author "David Brown <davidb@davidb.org>"
  :license "MIT"
  :depends-on ("iterate" "alexandria" "simple-date" "split-sequence"
               "cl-ppcre")
  :components ((:file "pr001")
               (:file "pr002")
               (:file "pr003" :depends-on ("sieve"))
               (:file "pr004")
               (:file "pr005")
               (:file "pr006")
               (:file "pr007" :depends-on ("sieve"))
               (:file "pr008")
               (:file "pr009")
               (:file "pr010" :depends-on ("big-sieve"))
               (:file "pr011")
               (:file "pr012" :depends-on ("sieve"))
               (:file "pr013")
               (:file "pr014")
               (:file "pr015")
               (:file "pr016" :depends-on ("euler"))
               (:file "pr017")
               (:file "pr018")
               (:file "pr019")
               (:file "pr020" :depends-on ("euler"))
               (:file "pr021" :depends-on ("sieve"))
               (:file "pr022")
               (:file "pr023" :depends-on ("sieve"))
               (:file "pr024")
               (:file "pr025")
               (:file "pr026" :depends-on ("sieve" "euler"))
               (:file "pr027" :depends-on ("sieve"))
               (:file "pr028")
               (:file "pr029")
               (:file "pr030" :depends-on ("euler"))
               (:file "pr031")
               (:file "pr032")
               (:file "pr033")
               (:file "pr034")
               (:file "pr035")
               (:file "pr036")
               (:file "pr037" :depends-on ("primes"))

               (:file "sieve" :depends-on ("heap"))
               (:file "heap")
               (:file "big-sieve")
               (:file "euler")
               (:file "problems")
               (:file "primes")
               ))
