module Day10 (run) where

import Common (createIntGrid, IntGrid)
import qualified Data.Array.Unboxed as UA
import qualified Data.Set as Set

type Position = (Int, Int)
type PValue = (Position, Int)

run :: String -> IO ()
run filePath = do
    grid <- createIntGrid <$> readFile filePath
    print $ trails grid

trails :: IntGrid -> Int
trails grid = 
    let startPositions = zeroes grid
        trailheadScores = map (scoreTrailhead grid) startPositions
    in sum trailheadScores

scoreTrailhead :: IntGrid -> Position -> Int
scoreTrailhead grid startPos =
    let reachableNines = findNines grid (startPos, 0)
    in Set.size reachableNines

findNines :: IntGrid -> PValue -> Set.Set Position
findNines grid (currPos, currValue)
    | currValue == 9 = Set.singleton currPos -- Stop at 9 and collect the position
    | otherwise = 
        let nextPositions = allOneHigher grid (currPos, currValue)
        in Set.unions [findNines grid (nextPos, currValue + 1) | nextPos <- nextPositions]

allOneHigher :: IntGrid -> PValue -> [Position]
allOneHigher grid (currPos, currVal) = filter (\pos -> (grid UA.! pos) == currVal + 1) $ getPosAround grid currPos

getPosAround :: IntGrid -> Position -> [Position]
getPosAround grid (y, x) = filter (UA.inRange $ UA.bounds grid) [(y, x-1), (y, x+1), (y-1, x), (y+1, x)]

zeroes :: IntGrid -> [Position]
zeroes grid = [pos | pos <- UA.range $ UA.bounds grid, grid UA.! pos == 0]
