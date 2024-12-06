module Day6 (run) where

import Data.Array.Unboxed (assocs, bounds, inRange, (!), (//))
import Data.List (nub)
import Common (createGrid, Grid)

type Position = (Int, Int)
type Direction = (Int, Int)

run :: String -> IO ()
run filePath = do
    grid <- createGrid <$> readFile filePath
    print $ part1 grid
    print $ part2 grid  -- ~6 min

part1 :: Grid -> Int
part1 grid = length $ getVisited grid (startPos '^' grid) (-1, 0) []

part2 :: Grid -> Int
part2 grid = length $ filter (\g -> isLoop g (startPos '^' g) (-1, 0) []) $ allPossibilities grid

getVisited :: Grid -> Position -> Direction -> [Position] -> [Position]
getVisited grid (y,x) dir visited
    | isNextOut grid (y,x) dir = nub ((y,x) : visited)
    | otherwise = getVisited grid (y + fst newDir', x + snd newDir') newDir' ((y,x) : visited)
    where newDir' = newDir grid (y, x) dir

isLoop :: Grid -> Position -> Direction -> [(Position, Direction)] -> Bool
isLoop grid (y,x) dir visited
    | isNextOut grid (y,x) dir = False
    | ifCurrVisited = True
    | otherwise = isLoop grid (y + fst newDir', x + snd newDir') newDir' (((y, x), dir) : visited)
    where
        ifCurrVisited = any (\r -> r == ((y,x), dir)) visited
        newDir' = newDir grid (y, x) dir

allPossibilities :: Grid -> [Grid]
allPossibilities grid = [grid // [(pos, '#')] | (pos,val) <- assocs grid, val == '.']

newDir :: Grid -> Position -> Direction -> Direction
newDir grid (y,x) dir = if (nextChar grid (y,x) dir) == '#' then turnRight dir else dir

nextChar :: Grid -> Position -> Direction -> Char
nextChar grid (y,x) dir = grid ! (y + fst dir, x + snd dir)

isNextOut :: Grid -> Position -> Direction -> Bool
isNextOut grid (y, x) dir = not $ inRange (bounds grid) (y + fst dir, x + snd dir)

turnRight :: Direction -> Direction
turnRight (0, 1) = (1, 0)
turnRight (1, 0) = (0, -1)
turnRight (0, -1) = (-1, 0)
turnRight (-1, 0) = (0, 1)

startPos :: Char -> Grid -> Position
startPos target grid = head [coord | (coord, val) <- assocs grid, val == target]
    