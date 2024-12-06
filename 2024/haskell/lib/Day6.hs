module Day6 (run, part1, part2) where

import Data.Array.Unboxed (assocs, bounds, inRange, (!), (//))
import qualified Data.Set as Set
import Common (createGrid, Grid)

type Position = (Int, Int)
type Direction = (Int, Int)
type PositionSet = Set.Set Position

run :: String -> IO ()
run filePath = do
    grid <- createGrid <$> readFile filePath
    print $ part1 grid
    print $ part2 grid  -- ~3s compiled

part1 :: Grid -> Int
part1 grid = Set.size $ getVisited grid (startPos '^' grid) (-1, 0) Set.empty

part2 :: Grid -> Int
part2 grid = length $ filter (\g -> isLoop g (startPos '^' g) (-1, 0) Set.empty) $ allPossibilities grid

getVisited :: Grid -> Position -> Direction -> PositionSet -> PositionSet
getVisited grid p@(y,x) dir visited
    | isNextOut grid (y,x) dir = Set.insert p visited
    | otherwise = getVisited grid (y + fst newDir', x + snd newDir') newDir' (Set.insert p visited)
    where newDir' = newDir grid p dir

isLoop :: Grid -> Position -> Direction -> Set.Set (Position, Direction) -> Bool
isLoop grid p@(y,x) dir visited
    | isNextOut grid p dir = False
    | ifCurrVisited = True
    | otherwise = isLoop grid (y + fst newDir', x + snd newDir') newDir' (Set.insert (p, dir) visited)
    where
        ifCurrVisited = Set.member (p, dir) visited
        newDir' = newDir grid p dir

allPossibilities :: Grid -> [Grid]
allPossibilities grid = [grid // [(pos, '#')] | pos <- Set.toList $ getVisited grid (startPos '^' grid) (-1, 0) Set.empty, grid ! pos == '.']

newDir :: Grid -> Position -> Direction -> Direction
newDir grid pos dir
    | nextChar grid pos dir == '#' = newDir grid pos (turnRight dir)
    | otherwise = dir

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
    