import qualified Data.Map as M
import Data.Maybe (fromJust, fromMaybe)

type Grid = M.Map (Int, Int) Char
type Energized = M.Map (Int, Int) [Direction]

data Direction = LEFT | RIGHT | UP | DOWN | END deriving (Show, Eq, Enum)

-- DOES NOT WORK, RETURNS EMPTY LIST

main = do
    input <- lines <$> readFile "test.txt"
    let grid = gridMap input M.empty 0
        (xBounds, yBounds) = (length $ head input, length input)
    print $ traverseGrid grid (0,0) RIGHT M.empty (xBounds, yBounds)

traverseGrid :: Grid -> (Int, Int) -> Direction -> Energized -> (Int,Int) -> Energized
traverseGrid _ _ END energized _ = energized
traverseGrid grid currPos@(x,y) direction energized (xB, yB)
    | isDirInEnergized = energized
    | xB - 1 >= x || yB - 1 >= y = energized
    | otherwise = M.unionsWith combineDirections $ map (\((nx, ny), nDir) -> traverseGrid grid (nx, ny) nDir newEnergized (xB, yB)) nextSteps
    where
        nextSteps = move currPos (fromJust $ M.lookup currPos grid) direction
        newEnergized = M.insert currPos (energizedDirections ++ [direction]) energized
        energizedDirections = fromMaybe [] (M.lookup currPos energized)
        combineDirections ds1 ds2 = ds1 ++ ds2
        isDirInEnergized = case M.lookup currPos energized of
            Just directions -> direction `elem` directions
            Nothing -> False

move :: (Int, Int) -> Char -> Direction -> [((Int, Int), Direction)]
move (x,y) c dir = map (getNextPos (x, y) dir,) $ getNextDir c dir

getNextPos :: (Int, Int) -> Direction -> (Int, Int)
getNextPos (x,y) dir = case dir of
    UP -> (x, y - 1)
    DOWN -> (x, y + 1)
    LEFT -> (x - 1, y - 1)
    RIGHT -> (x + 1, y - 1)

getNextDir :: Char -> Direction -> [Direction]
getNextDir c dir = case (c, dir) of
    ('.', LEFT) -> [RIGHT]
    ('.', RIGHT) -> [LEFT]
    ('.', UP) -> [DOWN]
    ('.', DOWN) -> [UP]
    ('/', LEFT) -> [UP]
    ('/', RIGHT) -> [DOWN]
    ('/', UP) -> [LEFT]
    ('/', DOWN) -> [RIGHT]
    ('\\', LEFT) -> [DOWN]
    ('\\', RIGHT) -> [UP]
    ('\\', UP) -> [RIGHT]
    ('\\', DOWN) -> [LEFT]
    ('-', LEFT) -> [RIGHT]
    ('-', RIGHT) -> [LEFT]
    ('-', UP) -> [LEFT, RIGHT]
    ('-', DOWN) -> [LEFT, RIGHT]
    ('|', LEFT) -> [UP, DOWN]
    ('|', RIGHT) -> [UP, DOWN]
    ('|', UP) -> [DOWN]
    ('|', DOWN) -> [UP]

-- PARSE
gridMap :: [[Char]] -> Grid -> Int -> Grid
gridMap [] grid _ = grid
gridMap (line:lines) grid y = gridMap lines newGrid (y + 1)
    where
        updateGrid g (x, char) = M.insert (x,y) char g
        newGrid = foldl updateGrid grid $ zip [0..] line