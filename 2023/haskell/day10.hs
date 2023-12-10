import qualified Data.Map as M
import Data.List (find)
import Data.Maybe (fromJust)

type Coord = (Int, Int)
type GridElement = (Coord, Char)

main = do
    input <- lines <$> readFile "input.txt"
    let grid = createGrid input
        pipeMap = M.fromList grid
        startEl = fromJust $ find start grid
    print $ (pipeLoopLength pipeMap startEl ((-1,-1), ' ') startEl 0) `div` 2

pipeLoopLength :: M.Map Coord Char -> GridElement -> GridElement -> GridElement -> Int -> Int
pipeLoopLength pipes startEl prevEl currEl steps
    | (currEl == startEl) && (steps /= 0) = steps
    | otherwise = pipeLoopLength pipes startEl currEl nextEl (steps +1)
    where
        nextEl = nextPipe pipes prevEl currEl

nextPipe :: M.Map Coord Char -> GridElement -> GridElement -> GridElement
nextPipe pipes prevEl currEl
    | fst prevEl == (-1,-1) = head adjacentPipes
    | otherwise = head $ filter (/= prevEl) adjacentPipes
    where
        adjacentPipes = map (\coord -> ((coord), fromJust $ M.lookup coord pipes)) $ pipeOpenings currEl

pipeOpenings :: GridElement -> [Coord]
pipeOpenings ((currX, currY), c)
    | c == 'S' = [(currX + 1, currY), (currX, currY + 1)] -- only working for inputs where S = F
    | c == '|' = [(currX, currY - 1), (currX, currY + 1)] -- |
    | c == '-' = [(currX - 1, currY), (currX + 1, currY)] -- -
    | c == 'L' = [(currX + 1, currY), (currX, currY - 1)] -- └
    | c == 'J' = [(currX - 1, currY), (currX, currY - 1)] -- ┘
    | c == '7' = [(currX - 1, currY), (currX, currY + 1)] -- ┐ 
    | c == 'F' = [(currX + 1, currY), (currX, currY + 1)] -- ┌

-- HELPER METHODS
start :: GridElement -> Bool
start ((_,_), 'S') = True
start _ = False

-- PARSING
createGrid :: [[Char]] -> [GridElement] 
createGrid chars = [((x, y), c) | (y, row) <- zip [0..] chars, (x, c) <- zip [0..] row]