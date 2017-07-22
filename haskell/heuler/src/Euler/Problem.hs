{-# LANGUAGE ExistentialQuantification #-}

module Euler.Problem where

data Problem = forall a. (Show a, Eq a) => Problem {
   prNumber :: Int,
   prOp :: IO a,
   prCorrect :: a }
