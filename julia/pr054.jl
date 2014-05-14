# Problem 54
#
# 10 October 2003
#
#
# In the card game poker, a hand consists of five cards and are ranked, from
# lowest to highest, in the following way:
#
#   • High Card: Highest value card.
#   • One Pair: Two cards of the same value.
#   • Two Pairs: Two different pairs.
#   • Three of a Kind: Three cards of the same value.
#   • Straight: All cards are consecutive values.
#   • Flush: All cards of the same suit.
#   • Full House: Three of a kind and a pair.
#   • Four of a Kind: Four cards of the same value.
#   • Straight Flush: All cards are consecutive values of same suit.
#   • Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
#
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
#
# If two players have the same ranked hands then the rank made up of the
# highest value wins; for example, a pair of eights beats a pair of fives
# (see example 1 below). But if two ranks tie, for example, both players
# have a pair of queens, then highest cards in each hand are compared (see
# example 4 below); if the highest cards tie then the next highest cards are
# compared, and so on.
#
# Consider the following five hands dealt to two players:
#
# Hand   Player 1            Player 2              Winner
# 1      5H 5C 6S 7S KD      2C 3S 8S 8D TD        Player 2
#        Pair of Fives       Pair of Eights
# 2      5D 8C 9S JS AC      2C 5C 7D 8S QH        Player 1
#        Highest card Ace    Highest card Queen
# 3      2D 9C AS AH AC      3D 6D 7D TD QD        Player 2
#        Three Aces          Flush with Diamonds
#        4D 6S 9H QH QC      3D 6D 7H QD QS
# 4      Pair of Queens      Pair of Queens        Player 1
#        Highest card Nine   Highest card Seven
#        2H 2D 4C 4D 4S      3C 3D 3S 9S 9D
# 5      Full House          Full House            Player 1
#        With Three Fours    with Three Threes
#
# The file, poker.txt, contains one-thousand random hands dealt to two
# players. Each line of the file contains ten cards (separated by a single
# space): the first five are Player 1's cards and the last five are Player
# 2's cards. You can assume that all hands are valid (no invalid characters
# or repeated cards), each player's hand is in no specific order, and in
# each hand there is a clear winner.
#
# How many hands does Player 1 win?
#
# 376

import Base: show

value_names = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
name_value = let
   m = Dict{Char, Int8}()
   for v in 1:endof(value_names)
      m[value_names[v]] = v
   end
   m
end

immutable Card
   value :: Int8
   suit  :: Char

   function Card(text :: String)
      if length(text) != 2
         error("Invalid card: Expecting 2 characters")
      end
      new(name_value[text[1]], text[2])
   end
end

# Ranks.
RoyalFlush, StraightFlush, FourOfAKind, FullHouse, Flush,
    Straight, ThreeOfAKind, TwoPairs, OnePair, HighCard = [1:10]

# Each test takes a hand, sorted by value in descending order, and
# returns either 'nothing', indicating that the hand doesn't match, or
# (Symbol, Card) indicating a particular rank of card.  The Card
# returned is the highest card of the particular ranking (not sure if
# this is right).

matchers = Function[]

function matcher(body)
    push!(matchers, body)
    nothing
end

function same_suit(cards)
    s = cards[1].suit
    all(c -> c.suit == s, cards[2:end])
end

# These should be added in order of priority, since the best match is
# always taken.

#   • Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
matcher() do hand
    if same_suit(hand) && hand[1].value == 13 &&
            hand[2].value == 12 &&
            hand[3].value == 11 &&
            hand[4].value == 10 &&
            hand[5].value == 9
        return (RoyalFlush, hand[1])
    end
end

#   • Straight Flush: All cards are consecutive values of same suit.
function is_straight(hand)
    v = hand[1].value - 1
    for c in hand[2:end]
        if c.value != v
            return false
        end
        v -= 1
    end
    true
end

matcher() do hand
    if !same_suit(hand)
        return nothing
    end
    if is_straight(hand)
        (StraightFlush, hand[1])
    else
        nothing
    end
end

#   • Four of a Kind: Four cards of the same value.

function kmatch(subhand)
    v = subhand[1].value
    if all(c -> c.value == v, subhand[2:end])
        @printf "Four of a kind: %s\n" subhand
        return (FourOfAKind, subhand[1])
    end
end

matcher() do hand
    m = kmatch(hand[1:4])
    if m != nothing
        return m
    end
    kmatch(hand[2:5])
end

#   • Full House: Three of a kind and a pair.
# Note that the "highest" card is the group of three, not whichever
# one is higher.
matcher() do hand
    if hand[1].value == hand[2].value && hand[2].value == hand[3].value &&
            hand[4].value == hand[5].value
        return (FullHouse, hand[1])
    end
    if hand[1].value == hand[2].value &&
            hand[3].value == hand[4].value && hand[4].value == hand[5].value
        return (FullHouse, hand[3])
    end
end

#   • Flush: All cards of the same suit.
matcher() do hand
    if same_suit(hand)
        return (Flush, hand[1])
    end
end

#   • Straight: All cards are consecutive values.
matcher() do hand
    if is_straight(hand)
        (Straight, hand[1])
    else
        nothing
    end
end

#   • Three of a Kind: Three cards of the same value.
matcher() do hand
    for base = 1:3
        if hand[base].value == hand[base+1].value &&
                hand[base+1].value == hand[base+2].value
            return (ThreeOfAKind, hand[base])
        end
    end
end

#   • Two Pairs: Two different pairs.
matcher() do hand
    for (a, b) in [(1, 3), (1, 4), (2, 4)]
        if hand[a].value == hand[a+1].value && hand[b].value == hand[b+1].value
            return (TwoPairs, hand[a])
        end
    end
end

#   • One Pair: Two cards of the same value.
matcher() do hand
    for a in 1:4
        if hand[a].value == hand[a+1].value
            return (OnePair, hand[a])
        end
    end
end

#   • High Card: Highest value card.
matcher() do hand
    (HighCard, hand[1])
end

function hand_rank(hand::Vector{Card})
    # Rank sort.
    hand = sort(hand, by=c->c.value, lt=(>))
    for m in matchers
        res = m(hand)
        if isa(res, Tuple)
            return res
        end
    end
    error("No match found.")
end

cardsort(cards) = sort(cards, by=c->c.value, lt=(>))

# Return the winner of the round.  Will call error if both players
# have the same hand.
function winner(a, b)
    a = cardsort(a)
    b = cardsort(b)
    (arank, abest) = hand_rank(a)
    (brank, bbest) = hand_rank(b)
    if arank < brank
        return 1
    elseif arank > brank
        return 2
    end
    if abest.value > bbest.value
        return 1
    elseif abest.value < bbest.value
        return 2
    end

    for c in 1:5
        if a[c].value > b[c].value
            return 1
        elseif a[c].value < b[c].value
            return 2
        end
    end
    error("No clear winner")
end

typealias HandInfo (Int, Card, Vector{Card})

# Utility, map the cards.  For testing.
# It's also interesting that the highest 4 hand rankings are not
# included in the sample set.
function deckmap(cards)
    # Don't compare yet, just collect the hands by mapping.
    result = Dict{Int, Array{HandInfo}}()
    for (a, b) in cards
        (rank, best) = hand_rank(a)
        push!(get!(result, rank, HandInfo[]), (rank, best, a))
    end
    result
end

function show(io::IO, c::Card)
   print(io, "Card(\"" * string(value_names[c.value]) * string(c.suit) * "\")")
end

function cards_decode(text)
    hand = split(text, ' ')
    foldl((a, b) -> push!(a, Card(b)), Card[], hand)
end

function load_cards()
   result = (Vector{Card}, Vector{Card})[]
   open("../haskell/poker.txt") do fd
      for line in eachline(fd)
         line = chomp(line)
         hand = split(line, ' ')
         cards = foldl((a, b) -> push!(a, Card(b)), Card[], hand)
         push!(result, (cards[1:5], cards[6:10]))
      end
   end
   result
end

function solve()
    count = 0
    hands = load_cards()
    for (a, b) in hands
        if winner(a, b) == 1
            count += 1
        end
    end
    count
end

println(solve())
