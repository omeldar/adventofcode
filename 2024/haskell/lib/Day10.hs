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
    print $ distinctTrails grid

trails :: IntGrid -> Int
trails grid = sum $ map (scoreTrailhead grid) $ zeroes grid

distinctTrails :: IntGrid -> Int
distinctTrails grid =
    let findRoutes pos = traverseFrom grid (pos, 0)
    in sum $ map ((length . Set.toList . Set.fromList) . findRoutes) (zeroes grid)

traverseFrom :: IntGrid -> PValue -> [[Position]]
traverseFrom grid (currPos, currValue)
    | currValue == 9 = [[currPos]]
    | otherwise = [currPos : route | nextPos <- allOneHigher grid (currPos, currValue), route <- traverseFrom grid (nextPos, currValue + 1)]

scoreTrailhead :: IntGrid -> Position -> Int
scoreTrailhead grid startPos = Set.size $ findNines grid (startPos, 0)

findNines :: IntGrid -> PValue -> Set.Set Position
findNines grid (currPos, currValue)
    | currValue == 9 = Set.singleton currPos
    | otherwise = Set.unions [findNines grid (nextPos, currValue + 1) | nextPos <- allOneHigher grid (currPos, currValue)]

allOneHigher :: IntGrid -> PValue -> [Position]
allOneHigher grid (currPos, currVal) = filter (\pos -> (grid UA.! pos) == currVal + 1) $ getPosAround grid currPos

getPosAround :: IntGrid -> Position -> [Position]
getPosAround grid (y, x) = filter (UA.inRange $ UA.bounds grid) [(y, x-1), (y, x+1), (y-1, x), (y+1, x)]

zeroes :: IntGrid -> [Position]
zeroes grid = [pos | pos <- UA.range $ UA.bounds grid, grid UA.! pos == 0]
