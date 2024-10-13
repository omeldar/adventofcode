import Debug.Trace ( trace )
import qualified Data.Map as M

type Coord = (Int, Int)
type Grid = M.Map (Coord) Int
type Dijkgrid = M.Map (Coord) (Int, Direction, Int)   -- (x,y) ()

data Direction = North | West | South | East deriving (Show, Eq, Enum)

main = do
    input <- lines <$> readFile "test.txt"
    let grid = gridMap input M.empty 0
    print ""

dijk :: Grid -> 
dijk = 

gridMap :: [[Char]] -> Grid -> Int -> Grid
gridMap [] grid _ = grid
gridMap (line:lines) grid y = gridMap lines newGrid (y + 1)
    where
        updateGrid g (x, char) = M.insert (x, y) (read [char] :: Int) g
        newGrid = foldl updateGrid grid $ zip [0..] line