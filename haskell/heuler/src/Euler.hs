module Euler (
   Problem(..),
   problems
) where

import Euler.Problem
import Euler.Pr001
import Euler.Pr002
import Euler.Pr003
import Euler.Pr004
import Euler.Pr005
import Euler.Pr006
import Euler.Pr007
import Euler.Pr008
import Euler.Pr009
import Euler.Pr010
import Euler.Pr011
import Data.IntMap (IntMap)
import qualified Data.IntMap as M

problems :: IntMap Problem
problems = M.fromList $ map (\p -> (prNumber p, p)) [
   pr001, pr002, pr003, pr004, pr005, pr006, pr007, pr008, pr009, pr010,
   pr011 ]
