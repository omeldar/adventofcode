module Common (countOccs, getMiddle, createGrid, Grid) where

import qualified Data.Array.Unboxed as UA

type Grid = UA.UArray (Int, Int) Char

countOccs :: Eq a => a -> [a] -> Int
countOccs x = length . filter (== x)

getMiddle :: [a] -> a
getMiddle xs = xs !! (length xs `div` 2)

createGrid :: String -> Grid
createGrid content = 
    let rows = length (lines content)
        cols = length (head $ lines content)
    in UA.listArray ((0, 0), (rows - 1, cols - 1)) $ concat $ lines content
