module Day10 (run) where

import Common (createIntGrid, IntGrid)
import qualified Data.Array.Unboxed as UA
import qualified Data.Set as Set
import Data.List (foldl')

type Position = (Int, Int)
type PValue = (Position, Int)

run :: String -> IO ()
run filePath = do
    grid <- createIntGrid <$> readFile filePath
    print $ trails grid

trails :: IntGrid -> Int
trails grid = 
    let findRoutes pos = traverseFrom grid (pos, 0)
    in sum $ map length $ map (Set.toList . Set.fromList) $ map findRoutes $ zeroes grid

traverseFrom :: IntGrid -> PValue -> [[Position]]
traverseFrom grid (currPos, currValue)
    | currValue == 9 = [[currPos]]
    | otherwise = [currPos : route | nextPos <- allOneHigher grid (currPos, currValue), route <- traverseFrom grid (nextPos, currValue + 1)]

allOneHigher :: IntGrid -> PValue -> [Position]
allOneHigher grid (currPos, currVal) = filter (\pos -> (grid UA.! pos) == currVal + 1) $ getPosAround grid currPos

getPosAround :: IntGrid -> Position -> [Position]
getPosAround grid (y,x) = filter (UA.inRange $ UA.bounds grid) $ [(y, x-1), (y, x+1), (y-1, x), (y+1, x)] 

zeroes :: IntGrid -> [Position]
zeroes grid = [pos | pos <- UA.range $ UA.bounds grid, grid UA.! pos == 0]