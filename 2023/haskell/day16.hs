import qualified Data.Map as M

type Grid = M.Map (Int, Int) Char
type Energized = M.Map (Int, Int) Direction

data Direction = DLeft | DRight | DUp | DDown | DEnd deriving (Show, Eq, Enum)

main = do
    input <- lines <$> readFile "test.txt"
    let grid = gridMap input M.empty 0
    print $ traverseGrid grid (0,0) DRight M.empty

traverseGrid :: Grid -> (Int, Int) -> Direction -> Energized -> Energized
traverseGrid _ _ DEnd energized = energized
traverseGrid grid currPos direction energized = traverseGrid grid newPos newDir newEnergized
    where
        newPos = (0,0)  -- needs to be implemented
        newDir = DRight -- needs to be implemented
        newEnergized = M.insert currPos direction energized

-- PARSE
gridMap :: [[Char]] -> Grid -> Int -> Grid
gridMap [] grid _ = grid
gridMap (line:lines) grid y = gridMap lines newGrid (y + 1)
    where
        updateGrid g (x, char) = M.insert (x,y) char g
        newGrid = foldl updateGrid grid $ zip [0..] line