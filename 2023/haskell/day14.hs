import Data.List (intercalate, sortBy, transpose)
import Data.List.Split (splitOn)
import Data.Ord (Down(Down), comparing)
import qualified Data.Map as M

main = do
    input <- lines <$> readFile "input.txt"
    print $ calcNorthLoad input
    print $ calcForIter input -- both in ~4.5s (interpreted), both in ~1.5s (compiled)

-- calculate laod on north beams after one tilt to north (Part 1)
calcNorthLoad :: [[Char]] -> Int
calcNorthLoad grid = load (tilt grid 0)

-- calculate load by grid (sum of product of row indices and O char count in each row)
load :: [[Char]] -> Int
load = sum . zipWith (*) [1..] . map (length . filter (== 'O')) . reverse

-- calculate load on north beams after 1B iterations complete by finding a cycle (Part 2)
calcForIter :: [[Char]] -> Int
calcForIter grid = load completedIterations
    where
        (start, cycleL) = detectCycle grid 0 M.empty
        cyclesNeeded = start + mod (1_000_000_000 - start) cycleL
        completedIterations = iterate fullRotation grid !! cyclesNeeded

-- detects cycles by keeping track of visited configurations
detectCycle :: [[Char]] -> Int -> M.Map [[Char]] Int -> (Int, Int)
detectCycle grid count visited = case M.lookup grid visited of
    Just start  -> (start, count - start)
    Nothing     -> detectCycle (fullRotation grid) (count + 1) (M.insert grid count visited)

-- executing a shift in all directions once
fullRotation :: [[Char]] -> [[Char]]
fullRotation grid = foldl tilt grid [0..3]

-- applying dir-ward shifts in grid
tilt :: [[Char]] -> Int -> [[Char]]
tilt grid dir
    | dir == 0 || dir == 2 = transpose $ map f $ transpose grid -- (0 = up, 2 = left)
    | dir == 1 || dir == 3 = map f grid                         -- (1 = down, 3 = right)
    where
        f = if dir <= 1 then toLeft else toRight

-- leftward shift in string
toLeft :: [Char] -> [Char]
toLeft = intercalate "#" . map (sortBy (comparing Data.Ord.Down)) . splitOn "#"

-- rightward shift in string
toRight :: [Char] -> [Char]
toRight = reverse . toLeft . reverse