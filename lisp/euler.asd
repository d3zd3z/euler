;;; System definition for Euler problems
;;;
;;; vim: ft=lisp

(defsystem "euler"
  :description "euler: Lisp solutions to project Euler problems"
  :version "0.0.1"
  :author "David Brown <davidb@davidb.org>"
  :license "MIT"
  :depends-on ("iterate" "alexandria" "simple-date" "split-sequence")
  :components ((:file "pr001" :depends-on ("problems"))
               (:file "pr002" :depends-on ("problems"))
               (:file "pr003" :depends-on ("problems" "sieve"))
               (:file "pr004" :depends-on ("problems"))
               (:file "pr005" :depends-on ("problems"))
               (:file "pr006" :depends-on ("problems"))
               (:file "pr007" :depends-on ("problems" "sieve"))
               (:file "pr008" :depends-on ("problems"))
               (:file "pr009" :depends-on ("problems"))
               (:file "pr010" :depends-on ("problems" "big-sieve"))
               (:file "pr011" :depends-on ("problems"))
               (:file "pr012" :depends-on ("problems" "sieve"))
               (:file "pr013" :depends-on ("problems"))
               (:file "pr014" :depends-on ("problems"))
               (:file "pr015" :depends-on ("problems"))
               (:file "pr016" :depends-on ("problems" "euler"))
               (:file "pr017" :depends-on ("problems"))
               (:file "pr018" :depends-on ("problems"))
               (:file "pr019" :depends-on ("problems"))
               (:file "pr020" :depends-on ("problems" "euler"))
               (:file "pr021" :depends-on ("problems" "sieve"))
               (:file "pr022" :depends-on ("problems"))
               (:file "pr023" :depends-on ("problems" "sieve"))
               (:file "pr024" :depends-on ("problems"))
               (:file "pr025" :depends-on ("problems"))
               (:file "sieve" :depends-on ("problems" "heap"))
               (:file "heap")
               (:file "big-sieve")
               (:file "euler")
               (:file "problems")
               ))
