module Day6 (run) where

import Data.Array.Unboxed (assocs, bounds, inRange, (!))
import Data.List (nub)
import Common (createGrid, Grid)

type Position = (Int, Int)
type Direction = (Int, Int)

run :: String -> IO ()
run filePath = do
    grid <- createGrid <$> readFile filePath
    print $ part1 grid

part1 :: Grid -> Int
part1 grid = length $ getVisited grid (startPos '^' grid) (-1, 0) []

getVisited :: Grid -> Position -> Direction -> [Position] -> [Position]
getVisited grid (y,x) dir visited
    | isNextOut = nub ((y,x) : visited)
    | otherwise = getVisited grid (y + fst newDir, x + snd newDir) newDir ((y,x) : visited)
    where 
        isNextOut = not $ inRange (bounds grid) (y + fst dir, x + snd dir)
        nextChar = grid ! (y + fst dir, x + snd dir)
        newDir = if nextChar == '#' then turnRight dir else dir

turnRight :: Direction -> Direction
turnRight (0, 1) = (1, 0)
turnRight (1, 0) = (0, -1)
turnRight (0, -1) = (-1, 0)
turnRight (-1, 0) = (0, 1)

startPos :: Char -> Grid -> Position
startPos target grid = head [coord | (coord, val) <- assocs grid, val == target]
    