----------------------------------------------------------------------
-- In the card game poker, a hand consists of five cards and are ranked, from
-- lowest to highest, in the following way:
--
--   • High Card: Highest value card.
--   • One Pair: Two cards of the same value.
--   • Two Pairs: Two different pairs.
--   • Three of a Kind: Three cards of the same value.
--   • Straight: All cards are consecutive values.
--   • Flush: All cards of the same suit.
--   • Full House: Three of a kind and a pair.
--   • Four of a Kind: Four cards of the same value.
--   • Straight Flush: All cards are consecutive values of same suit.
--   • Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
--
-- The cards are valued in the order:
-- 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
--
-- If two players have the same ranked hands then the rank made up of the
-- highest value wins; for example, a pair of eights beats a pair of fives
-- (see example 1 below). But if two ranks tie, for example, both players
-- have a pair of queens, then highest cards in each hand are compared (see
-- example 4 below); if the highest cards tie then the next highest cards are
-- compared, and so on.
--
-- Consider the following five hands dealt to two players:
--
-- Hand   Player 1            Player 2              Winner
-- 1      5H 5C 6S 7S KD      2C 3S 8S 8D TD        Player 2
--        Pair of Fives       Pair of Eights
-- 2      5D 8C 9S JS AC      2C 5C 7D 8S QH        Player 1
--        Highest card Ace    Highest card Queen
-- 3      2D 9C AS AH AC      3D 6D 7D TD QD        Player 2
--        Three Aces          Flush with Diamonds
--        4D 6S 9H QH QC      3D 6D 7H QD QS
-- 4      Pair of Queens      Pair of Queens        Player 1
--        Highest card Nine   Highest card Seven
--        2H 2D 4C 4D 4S      3C 3D 3S 9S 9D
-- 5      Full House          Full House            Player 1
--        With Three Fours    with Three Threes
--
-- The file, poker.txt, contains one-thousand random hands dealt to two
-- players. Each line of the file contains ten cards (separated by a single
-- space): the first five are Player 1's cards and the last five are Player
-- 2's cards. You can assume that all hands are valid (no invalid characters
-- or repeated cards), each player's hand is in no specific order, and in
-- each hand there is a clear winner.
--
-- How many hands does Player 1 win?
----------------------------------------------------------------------

module Main where

import Control.Applicative ((<$>))
import Data.List

data Suit = Hearts | Spades | Diamonds | Clubs
   deriving (Eq, Show, Ord)

-- We represent cards as a numeric value, with ace as 1, J=11, K=13.
data Card = Card { cardNum :: !Int, cardSuit :: !Suit }
   deriving (Eq, Show, Ord)

nums :: Int -> Char
nums 14 = 'A'
nums 10 = 'T'
nums 11 = 'J'
nums 12 = 'Q'
nums 13 = 'K'
nums n = toEnum (n + fromEnum '0')

{-
instance Show Card where
   showsPrec _ (Card num suit) =
      showString [nums num] . showString (take 1 $ show suit)
-}

-- TODO: Figure out how to make this a proper read.
toCard :: String -> Card
toCard txt = case txt of
   [n,s] -> Card (decodeNum n) (decodeSuit s)
   _ -> error $ "Malformed card: " ++ txt
   where
      decodeNum 'A' = 14
      decodeNum 'J' = 11
      decodeNum 'Q' = 12
      decodeNum 'K' = 13
      decodeNum 'T' = 10
      decodeNum n | n >= '2' && n <= '9' = fromEnum n - fromEnum '0'
      decodeNum n = error $ "Invalid card number: " ++ show n

      decodeSuit 'H' = Hearts
      decodeSuit 'S' = Spades
      decodeSuit 'D' = Diamonds
      decodeSuit 'C' = Clubs
      decodeSuit s = error $ "Invalid suit: " ++ show s

-- Hand, lowest first.
data HandKind = HighestCard | OnePair | TwoPairs | ThreeOfAKind | Straight | Flush
   | FullHouse | FourOfAKind | StraightFlush | RoyalFlush
   deriving (Eq, Ord, Show)

-- Each hand is described by the HandKind and the list of relevant
-- cards.
data Hand = Hand HandKind [Int]
   deriving (Eq, Show, Ord)

sameSuits :: [Card] -> Bool
sameSuits [] = undefined
sameSuits (Card _ s : rest) = all (\ (Card _ s2) -> s == s2) rest

decreasing :: [Int] -> Bool
decreasing [] = True
decreasing [_] = True
decreasing (a:b:bs) = a-1 == b && decreasing (b:bs)

fourSame :: [Int] -> Maybe [Int]
fourSame (a:b:c:d:_) | all (a==) [b,c,d] = Just [a,b,c,d]
fourSame [] = Nothing
fourSame (_:xs) = fourSame xs

threeSame :: [Int] -> Maybe [Int]
threeSame (a:b:c:_) | all (a==) [b,c] = Just [a,b,c]
threeSame [] = Nothing
threeSame (_:xs) = threeSame xs

-- Note that these are ranked by the triple, even if it is the lower
-- value cards.
fullHouse :: [Int] -> Maybe [Int]
fullHouse nums@[a,b,c,d,e]
   | (a == b && a == c && d == e) = Just [a,b,c]
   | (a == b && c == d && c == e) = Just [c,d,e]
   | otherwise = Nothing

twoPair :: [Int] -> Maybe [Int]
twoPair nums = case group nums of
   [[_], a@[_,_], b@[_,_]] -> Just $ a ++ b
   [a@[_,_], [_], b@[_,_]] -> Just $ a ++ b
   [a@[_,_], b@[_,_], [_]] -> Just $ a ++ b
   otherwise -> Nothing

onePair :: [Int] -> Maybe [Int]
onePair nums = scan $ group nums where
   scan (a@[_,_]:_) = Just a
   scan (a:as) = scan as
   scan [] = Nothing

cardsToHand :: [Card] -> Hand
cardsToHand cards = 
   let sortCards = reverse $ sort cards in
   let nums = map cardNum sortCards in
   case sortCards of
      [Card 14 aSuit, Card 13 bSuit, Card 12 cSuit, Card 11 dSuit, Card 10 eSuit]
         | sameSuits cards -> Hand RoyalFlush nums
      _ | sameSuits cards && decreasing nums -> Hand StraightFlush nums
      _ | Just fnums <- fourSame nums -> Hand FourOfAKind fnums
      _ | Just fnums <- fullHouse nums -> Hand FullHouse fnums
      _ | sameSuits cards -> Hand Flush nums
      _ | decreasing nums -> Hand Straight nums
      _ | Just fnums <- threeSame nums -> Hand ThreeOfAKind fnums
      _ | Just fnums <- twoPair nums -> Hand TwoPairs fnums
      _ | Just fnums <- onePair nums -> Hand OnePair fnums
      [Card a _,_,_,_,_] -> Hand HighestCard [a]
      _ -> error "Poker hand needs 5 cards"

compareHand :: [Card] -> [Card] -> Ordering
compareHand a b =
   let aSort = reverse $ sort a in
   let bSort = reverse $ sort b in
   (cardsToHand aSort, aSort) `compare` (cardsToHand bSort, bSort)

compareProblem :: String -> Ordering
compareProblem line =
   let (a, b) = splitAt 5 $ map toCard $ words line in
   a `compareHand` b

main :: IO ()
main = do
   lines <- lines <$> readFile "poker.txt"
   putStrLn $ show $ length $ filter (\line -> compareProblem line == GT) lines
