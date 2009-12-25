#lang scheme

;;; In the card game poker, a hand consists of five cards and are ranked, from
;;; lowest to highest, in the following way:
;;; 
;;;   • High Card: Highest value card.
;;;   • One Pair: Two cards of the same value.
;;;   • Two Pairs: Two different pairs.
;;;   • Three of a Kind: Three cards of the same value.
;;;   • Straight: All cards are consecutive values.
;;;   • Flush: All cards of the same suit.
;;;   • Full House: Three of a kind and a pair.
;;;   • Four of a Kind: Four cards of the same value.
;;;   • Straight Flush: All cards are consecutive values of same suit.
;;;   • Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
;;; 
;;; The cards are valued in the order:
;;; 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
;;; 
;;; If two players have the same ranked hands then the rank made up of the
;;; highest value wins; for example, a pair of eights beats a pair of fives
;;; (see example 1 below). But if two ranks tie, for example, both players
;;; have a pair of queens, then highest cards in each hand are compared (see
;;; example 4 below); if the highest cards tie then the next highest cards are
;;; compared, and so on.
;;; 
;;; Consider the following five hands dealt to two players:
;;; 
;;; Hand   Player 1            Player 2              Winner
;;; 1      5H 5C 6S 7S KD      2C 3S 8S 8D TD        Player 2
;;;        Pair of Fives       Pair of Eights
;;; 2      5D 8C 9S JS AC      2C 5C 7D 8S QH        Player 1
;;;        Highest card Ace    Highest card Queen
;;; 3      2D 9C AS AH AC      3D 6D 7D TD QD        Player 2
;;;        Three Aces          Flush with Diamonds
;;;        4D 6S 9H QH QC      3D 6D 7H QD QS
;;; 4      Pair of Queens      Pair of Queens        Player 1
;;;        Highest card Nine   Highest card Seven
;;;        2H 2D 4C 4D 4S      3C 3D 3S 9S 9D
;;; 5      Full House          Full House            Player 1
;;;        With Three Fours    with Three Threes
;;; 
;;; The file, poker.txt, contains one-thousand random hands dealt to two
;;; players. Each line of the file contains ten cards (separated by a single
;;; space): the first five are Player 1's cards and the last five are Player
;;; 2's cards. You can assume that all hands are valid (no invalid characters
;;; or repeated cards), each player's hand is in no specific order, and in
;;; each hand there is a clear winner.
;;; 
;;; How many hands does Player 1 win?

(require (planet schematics/macro:1:2/macro))

(define-struct card (rank suit) #:transparent)

(define qh (make-card 12 'hearts))

(define rank-hash
  (make-immutable-hasheq
    '([#\2 . 2] [#\3 . 3] [#\4 . 4] [#\5 . 5] [#\6 . 6] [#\7 . 7]
		[#\8 . 8] [#\9 . 9] [#\T . 10] [#\J . 11] [#\Q . 12]
		[#\K . 13] [#\A . 14])))
(define suit-hash
  (make-immutable-hasheq
    '([#\H . 'hearts]
      [#\D . 'diamonds]
      [#\S . 'spades]
      [#\C . 'clubs])))

(define (string->card textual)
  (define rank (hash-ref rank-hash (string-ref textual 0)))
  (define suit (hash-ref suit-hash (string-ref textual 1)))
  (make-card rank suit))

(define (card< a b)
  (< (card-rank a) (card-rank b)))
(define (card> a b)
  (> (card-rank a) (card-rank b)))

;(define test-line "8C TS KC 9H 4S 7D 2S 5D 3S AC")
;(define test-line "TC TS 4C TH 4S 7D 2S 5D 3S AC")
;(define test-line "TC TS 4C TH 4S 6D 2S 5D 3S 4D")

;(define test-line "2D 9C AS AH AC 3D 6D 7D TD QD") ; P2

;;; A bunch of test cases for developing the code.
(define (decode-cards textual)
  (sort (map string->card (regexp-split #rx" " textual))
	card>))
(define-syntax-rule (define-hand name cards)
		    (define name (decode-cards cards)))
(define-hand h1a "5H 5C 6S 7S KD") ; pair of fives.
(define-hand h1b "2C 3S 8S 8D TD") ; pair of eights
(define-hand h2a "5D 8C 9S JS AC") ; highest is ace
(define-hand h2b "2C 5C 7D 8S QH") ; highest is queen
(define-hand h3a "2D 9C AS AH AC") ; three aces
(define-hand h3b "3D 6D 7D TD QD") ; flush with diamonds
(define-hand h4a "4D 6S 9H QH QC") ; pair of queens highest 9
(define-hand h4b "3D 6D 7H QD QS") ; pair of queens highest 7
(define-hand h5a "2H 2D 4C 4D 4S") ; full house 4s
(define-hand h5b "3C 3D 3S 9S 9D") ; full house 3s
(define-hand h6a "2D 2H 5D 5C 9D") ; two pair
(define-hand h6b "2C 3C 4C 5D 6D") ; flush
(define-hand h7a "2C 2D 2S 2H 6D") ; four of a kind
(define-hand h8a "2C 3C 4C 5C 6C") ; straight flush
(define-hand h8b "JC TC QC AC KC") ; royal flush

(define (line->hands line)
  (define cards (map string->card (regexp-split #rx" " line)))
  (define-values (aa bb) (split-at cards 5))
  (values (sort aa card>) (sort bb card>)))

(define-values (aa bb) (line->hands test-line))

(define-struct ranking (key name cards) #:transparent)

;;; Rankings all assume the hands are sorted (as returned by
;;; line->hands).

;;; 1 • High Card: Highest value card.
(define (rank-highest hand)
  (make-ranking 1 'highest hand))

;;; 2 • One Pair: Two cards of the same value.

;;; Safely take n items from the list.  Returns the same as 'take' if
;;; there are at least n items in the list, otherwise returns #f.
(define (safe-take lst n)
  (cond [(zero? n) '()]
	[(pair? lst)
	 (let ([next (safe-take (cdr lst) (sub1 n))])
	   (if next
	     (cons (car lst) next)
	     #f))]
	[else #f]))

;;; Verify that two-arg function returns true for every pairing in the
;;; list.
(define (every-pair? lst func)
  (match lst
    [(list-rest a b _)
     (if (func a b)
       (every-pair? (cdr lst) func)
       #f)]
    [(list _) #t]
    [(list) #t]))

;;; Search for 'n' cards at the start of the hand where fun applied to
;;; the pred returns truth.  Returns the match cards as the first
;;; value, and the rest of the cards (kept in order) as the second
;;; value).  If there is no match, returns (values #f #f).
(define (find-card-pattern hand n func)
  (let loop ([prior '()]
	     [hand hand])
    (aif group (safe-take hand n)
      (if (every-pair? group func)
	(values group (append (reverse prior) (drop hand n)))
	(loop (cons (car hand) prior) (cdr hand)))
      (values #f #f))))

(define (rank=? a b)
  (= (card-rank a) (card-rank b)))
(define (consecurive? a b)
  (= (add1 (card-rank b)) (card-rank a)))
(define (suit=? a b)
  (eqv? (card-suit a) (card-suit b)))

(define (find-pair hand)
  (find-card-pattern hand 2 rank=?))
(define (find-triplet hand)
  (find-card-pattern hand 3 rank=?))

(define (rank-one-pair hand)
  (define-values (paired others) (find-pair hand))
  (if paired
    (make-ranking 2 'pair (append paired others))
    #f))

;;; 3 • Two Pairs: Two different pairs.
(define (rank-two-pair hand)
  (define-values (first-pair others) (find-pair hand))
  (if first-pair
    (let-values ([(second-pair rst) (find-pair others)])
      (if second-pair
	(make-ranking 3 'two-pair (append first-pair second-pair rst))
	#f))
    #f))

;;; 4 • Three of a Kind: Three cards of the same value.
(define (rank-three-of-a-kind hand)
  (define-values (triplet others) (find-triplet hand))
  (if triplet
    (make-ranking 4 'three-of-a-kind (append triplet others))
    #f))

;;; 5 • Straight: All cards are consecutive values.
(define (rank-straight hand)
  (define-values (all others) (find-card-pattern hand 5 consecurive?))
  (if all
    (make-ranking 5 'straight hand)
    #f))

;;; 6 • Flush: All cards of the same suit.
(define (rank-flush hand)
  (define-values (all others) (find-card-pattern hand 5 suit=?))
  (if all
    (make-ranking 6 'flush hand)
    #f))

;;; 7 • Full House: Three of a kind and a pair.
(define (rank-full-house hand)
  (define-values (triplet others1) (find-triplet hand))
  (if triplet
    (let-values ([(pair others2) (find-pair others1)])
      (if pair
	(make-ranking 7 'full-house (append triplet pair others2))
	#f))
    #f))

;;; 8 • Four of a Kind: Four cards of the same value.
(define (rank-four-of-a-kind hand)
  (define-values (fours others) (find-card-pattern hand 4 rank=?))
  (if fours
    (make-ranking 8 'four-of-a-kind (append fours others))
    #f))

;;; 9 • Straight Flush: All cards are consecutive values of same suit.
(define (rank-straight-flush hand)
  (if (and (rank-straight hand) (rank-flush hand))
    (make-ranking 9 'straight-flush hand)
    #f))

;;; 10 • Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
(define (rank-royal-flush hand)
  (if (and (= (card-rank (first hand)) 14)
	   (rank-straight-flush hand))
    (make-ranking 10 'royal-flush hand)
    #f))

(define rankings
  (list rank-royal-flush rank-straight-flush rank-four-of-a-kind
	rank-full-house rank-flush rank-straight rank-three-of-a-kind
	rank-two-pair rank-one-pair rank-highest))

(define (rank-hand hand)
  (let loop ([r rankings])
    (if (pair? r)
      (let ([rank ((first r) hand)])
	(if rank rank
	  (loop (rest r))))
      (error "Unable to rank hand"))))

(define (cards> a b)
  (unless (pair? a)
    (error "Unable to rank cards"))
  (unless (pair? b)
    (error "Unable to rank cards"))
  (let* ([card-a (first a)]
	 [card-b (first b)]
	 [rank-a (card-rank card-a)]
	 [rank-b (card-rank card-b)])
    (cond [(= rank-a rank-b)
	   (cards> (rest a) (rest b))]
	  [(> rank-a rank-b) #t]
	  [else #f])))

(define (ranking> a b)
  (let ([key-a (ranking-key a)]
	[key-b (ranking-key b)])
    (cond [(= key-a key-b)
	   (cards> (ranking-cards a) (ranking-cards b))]
	  [(> key-a key-b) #t]
	  [else #f])))

(define (hand-reader inp)
  (for/fold ([a-wins 0])
    ([line (in-lines inp)])
    (let-values ([(p1 p2) (line->hands line)])
      (if (ranking> (rank-hand p1) (rank-hand p2)) (add1 a-wins) a-wins))))
(define (read-hands)
  (call-with-input-file "poker.txt" hand-reader))

(display (read-hands))
(newline)
