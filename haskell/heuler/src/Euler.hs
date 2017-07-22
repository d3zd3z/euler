module Euler (
   Problem(..),
   problems
) where

import Euler.Problem
import Euler.Pr001
import Euler.Pr002
import Euler.Pr003
import Data.IntMap (IntMap)
import qualified Data.IntMap as M

problems :: IntMap Problem
problems = M.fromList $ map (\p -> (prNumber p, p)) [ pr001, pr002, pr003 ]
