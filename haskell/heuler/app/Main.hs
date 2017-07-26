module Main where

import Data.Either (partitionEithers)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)
import Text.Read (readMaybe)
import qualified Data.IntMap as M

import Euler

main :: IO ()
main = do
   args <- getArgs
   case decode args of
      Left prob -> mapM_ runOne prob
      Right message -> putStrLn $ "error: " ++ message

allProblems :: [Int]
allProblems = M.keys problems

runOne :: Int -> IO ()
runOne num =
   case M.lookup num problems of
      Just Problem{prOp=op, prCorrect=correct} -> do
         putStr $ (show $ num) ++ ": "
         hFlush stdout
         value <- op
         putStr $ (show value)
         if value == correct then return ()
            else do
               putStr $ " expecting: " ++ show correct
         putStrLn ""
      Nothing -> putStrLn $ "Invalid problem: " ++ show num

-- Decode the command line arguments.  Either accept a single argument
-- of "all", or interpret each as a number.  Left thunk is the
-- operation to perform if it is valid, or Right string for an error
-- message.
decode :: [String] -> Either [Int] String
decode ["all"] = Left allProblems
decode args =
   case partitionEithers (map decodeOne args) of
      (xs, []) -> Left xs
      (_, (ee:_)) -> Right ee

decodeOne :: String -> Either Int String
decodeOne text =
   case readMaybe text of
      Just n -> Left n
      Nothing -> Right ("Invalid number: " ++ text)
