import Data.Maybe (fromJust, fromMaybe)
import Data.List (nub)
import Debug.Trace (trace)
import qualified Data.Map as M

type Coord = (Int, Int)
type Grid = M.Map (Int, Int) Char
type Energized = M.Map (Int, Int) [Direction]

data Direction = LEFT | RIGHT | UP | DOWN | END deriving (Show, Eq, Enum)

main = do
    input <- lines <$> readFile "input.txt"
    let grid = gridMap input M.empty 0
        (xBounds, yBounds) = (length $ head input, length input)
    print $ length $ traverseGrid grid (0,0) LEFT M.empty (xBounds, yBounds)

traverseGrid :: Grid -> (Int, Int) -> Direction -> Energized -> (Int,Int) -> Energized
traverseGrid _ _ END energized _ = energized
traverseGrid grid currPos@(x,y) direction energized (xB, yB)
    | isStateInEnergized = energized
    | x >= xB || y >= yB || x < 0 || y < 0 = energized
    | otherwise = foldl (\energ (currCord, currDir) -> traverseGrid grid currCord currDir energ (xB, yB)) newEnergized nextSteps
    where
        nextSteps = move currPos (fromJust $ M.lookup currPos grid) direction
        newEnergized = M.insert currPos (energizedDirections ++ [direction]) energized
        energizedDirections = fromMaybe [] (M.lookup currPos energized)
        combineDirections ds1 ds2 = nub (ds1 ++ ds2)
        isStateInEnergized = case M.lookup currPos energized of
            Just directions -> direction `elem` directions
            Nothing -> False

move :: Coord -> Char -> Direction -> [(Coord, Direction)]
move (x,y) c dir = case (c, dir) of
    ('.', LEFT) -> [((x + 1, y),LEFT)]
    ('.', RIGHT) -> [((x - 1, y),RIGHT)]
    ('.', UP) -> [((x, y + 1),UP)]
    ('.', DOWN) -> [((x, y - 1),DOWN)]
    ('/', LEFT) -> [((x, y - 1),DOWN)]
    ('/', RIGHT) -> [((x, y + 1),UP)]
    ('/', UP) -> [((x - 1, y),RIGHT)]
    ('/', DOWN) -> [((x + 1, y),LEFT)]
    ('\\', LEFT) -> [((x, y + 1),UP)]
    ('\\', RIGHT) -> [((x, y - 1),DOWN)]
    ('\\', UP) -> [((x + 1, y),LEFT)]
    ('\\', DOWN) -> [((x - 1, y),RIGHT)]
    ('-', LEFT) -> [((x + 1, y),LEFT)]
    ('-', RIGHT) -> [((x - 1, y),RIGHT)]
    ('-', UP) -> [((x - 1, y),RIGHT),((x + 1, y),LEFT)]
    ('-', DOWN) -> [((x - 1, y),RIGHT),((x + 1, y),LEFT)]
    ('|', LEFT) -> [((x, y + 1),UP),((x, y - 1),DOWN)]
    ('|', RIGHT) -> [((x, y + 1),UP),((x, y - 1),DOWN)]
    ('|', UP) -> [((x, y + 1),UP)]
    ('|', DOWN) -> [((x, y -1),DOWN)]

gridMap :: [[Char]] -> Grid -> Int -> Grid
gridMap [] grid _ = grid
gridMap (line:lines) grid y = gridMap lines newGrid (y + 1)
    where
        updateGrid g (x, char) = M.insert (x,y) char g
        newGrid = foldl updateGrid grid $ zip [0..] line