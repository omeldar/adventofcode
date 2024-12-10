module Common (countOccs, getMiddle, createGrid, Grid, inBounds, Point, createIntGrid, IntGrid) where

import qualified Data.Array.Unboxed as UA

type Grid = UA.UArray (Int, Int) Char
type IntGrid = UA.UArray (Int, Int) Int
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

createIntGrid :: String -> IntGrid
createIntGrid content = 
    let rows = length (lines content)
        cols = length (head $ lines content)
        intList = map (read . (:[])) $ concat $ lines content
    in UA.listArray ((0, 0), (rows - 1, cols - 1)) intList

inBounds :: Point -> (Int, Int) -> Bool
inBounds (x, y) (rows, cols) = x >= 0 && x <= rows && y >= 0 && y <= cols
