module Day4 (run) where

import qualified Data.Array.Unboxed as UA
import Data.Ix (range, inRange)
import Data.List (foldl')

type Grid = UA.UArray (Int, Int) Char
type Position = (Int, Int)

run :: String -> IO ()
run filePath = do
    content <- lines <$> readFile filePath
    let grid = UA.listArray ((0,0), (length content - 1, length (head content) - 1)) $ concat content
    print $ sum $ map snd $ findAllXmas grid
    print $ findMasXShape grid

directions :: [(Int, Int)]
directions = [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (-1, -1), (1, -1), (-1, 1)]

inBounds :: (Position, Position) -> Position -> Bool
inBounds = inRange

findXmasFrom :: Grid -> (Position, Position) -> Position -> (Int, Int) -> Bool
findXmasFrom grid bounds (x, y) (dx, dy) =
    let positions = [(x + i * dx, y + i * dy) | i <- [0..3]]
    in all (inBounds bounds) positions && map (grid UA.!) positions == "XMAS"

findAllXmas :: Grid -> [(Position, Int)]
findAllXmas grid =
    let ((minX, minY), (maxX, maxY)) = UA.bounds grid
        allPositions = range ((minX, minY), (maxX, maxY))
        countOccurrences pos = length [(dx, dy) | (dx, dy) <- directions, findXmasFrom grid ((minX, minY), (maxX, maxY)) pos (dx, dy)]
        addOccurrence acc pos = let count = countOccurrences pos in if count > 0 then (pos, count) : acc else acc
    in foldl' addOccurrence [] allPositions

findMasXShape :: Grid -> Int
findMasXShape grid =
    let ((minX, minY), (maxX, maxY)) = UA.bounds grid
        allPositions = range ((minX + 1, minY + 1), (maxX - 1, maxY - 1)) -- Start from (1, 1) to (maxX-1, maxY-1) to avoid boundary issues
        isMasXShape (x, y) =
            let diagonal1 = [(x-1, y-1), (x, y), (x+1, y+1)] -- Diagonal from top-left to bottom-right
                diagonal2 = [(x-1, y+1), (x, y), (x+1, y-1)] -- Diagonal from top-right to bottom-left
                checkPattern patterns =
                    any (\pattern -> map (grid UA.!) diagonal1 == pattern) patterns &&
                    any (\pattern -> map (grid UA.!) diagonal2 == pattern) patterns
                validPatterns = ["MAS", "SAM"]
            in all (inBounds ((minX, minY), (maxX, maxY))) diagonal1 &&
               all (inBounds ((minX, minY), (maxX, maxY))) diagonal2 &&
               checkPattern validPatterns
    in length [pos | pos <- allPositions, isMasXShape pos]