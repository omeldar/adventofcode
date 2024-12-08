module Common (countOccs, getMiddle, createGrid, Grid, inBounds, Point) where

import qualified Data.Array.Unboxed as UA

type Grid = UA.UArray (Int, Int) Char
type Point = (Int, Int)

countOccs :: Eq a => a -> [a] -> Int
countOccs x = length . filter (== x)

getMiddle :: [a] -> a
getMiddle xs = xs !! (length xs `div` 2)

createGrid :: String -> Grid
createGrid content = 
    let rows = length (lines content)
        cols = length (head $ lines content)
    in UA.listArray ((0, 0), (rows - 1, cols - 1)) $ concat $ lines content

inBounds :: Point -> (Int, Int) -> Bool
inBounds (x, y) (rows, cols) = x >= 0 && x < rows && y >= 0 && y < cols
