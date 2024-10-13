import Debug.Trace ( trace )
import Data.Array.Unboxed

type Coord = (Int, Int)
type Grid = UArray Coord Int

data Direction = North | West | South | East deriving (Show, Eq, Enum)

main = do
    input <- lines <$> readFile "test.txt"
    let grid = gridMap input (length input) (length (head input))
    print $ show grid


gridMap :: [[Char]] -> Int -> Int -> Grid
gridMap input numRows numCols = array bounds hlValues
    where
        bounds = ((0,0), (numRows - 1, numCols - 1))
        hlValues = [((x, y), read [char] :: Int) | (y, line) <- zip [0..] input, (x, char) <- zip [0..] line]