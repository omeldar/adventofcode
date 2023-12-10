import qualified Data.Map as M
import qualified Data.Set as S
import Data.List (find, intercalate, transpose)
import Data.Maybe (fromJust)
import Debug.Trace (trace)

type Coord = (Int, Int)
type GridElement = (Coord, Char)

main = do
    input <- scale . lines <$> readFile "test.txt"
    let inputWithOuterOs = addOuterOs input
        grid = createGrid inputWithOuterOs
        xB = length $ head inputWithOuterOs
        yB = length inputWithOuterOs
        pipeMap = M.fromList grid
        startEl = fromJust $ find start grid
        coordsAdjToStart = filter (\c -> c `elem` pipeOpenings startEl) $ neighbours $ fst startEl
        pipesAdjToStart = map (\c -> (c, fromJust $ M.lookup c pipeMap)) coordsAdjToStart
        pipesOfLoop = loopPipe pipeMap (head $ pipesAdjToStart) startEl (head $ pipesAdjToStart) S.empty
        floodedSet = floodFill [(0,0)] (xB, yB) S.empty pipesOfLoop
        dotCount = allPoints inputWithOuterOs 0
        floodDotCount = floodedPoints (S.toList floodedSet) pipeMap 0
    writeFile "out.txt" $ intercalate "\n" $ inputWithOuterOs -- If you want to output a visualization - upscaled grid of pipes
    print $ (S.size pipesOfLoop) `div` 4
    print $ dotCount - floodDotCount

-- PART 1
loopPipe :: M.Map Coord Char -> GridElement -> GridElement -> GridElement -> S.Set Coord -> S.Set Coord
loopPipe pipes startEl prevEl currEl visited
    | (currEl == startEl) && not (S.null visited) = visited
    | otherwise = loopPipe pipes startEl currEl nextEl (S.insert (fst currEl) visited)
    where
        nextEl = nextPipe pipes prevEl currEl

nextPipe :: M.Map Coord Char -> GridElement -> GridElement -> GridElement
nextPipe pipes prevEl currEl = head $ filter (/= prevEl) adjacentPipes
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

-- PART 2
floodFill :: [Coord] -> Coord -> S.Set Coord -> S.Set Coord -> S.Set Coord
floodFill [] _ visited pipes = visited
floodFill (coord:coords) (xB, yB) visited pipes = floodFill (validNeighbours ++ coords) (xB, yB) (S.insert coord visited) pipes
    where
        validNeighbours = filter (\c -> c `S.notMember` pipes) neighboursNotVisited
        neighboursNotVisited = filter (\c -> c `S.notMember` visited) neighboursByBounds
        neighboursByBounds = filter (\(x,y) -> x < xB && x >= 0 && y < yB && y >= 0) $ neighbours coord

allPoints :: [String] -> Int -> Int 
allPoints [] dotCount = dotCount
allPoints (line:lines) dotCount = allPoints lines newDotCount
    where
        newDotCount = dotCount + (sum $ map (\c -> ifPoint c) line)
        ifPoint char = if char == '.' then 1 else 0

floodedPoints :: [Coord] -> M.Map Coord Char -> Int -> Int
floodedPoints [] _ count = count
floodedPoints (coord:coords) pipeMap count = floodedPoints coords pipeMap newDotCount
    where
        newDotCount = if '.' == (fromJust $ M.lookup coord pipeMap) then (count + 1) else count

addOuterOs :: [String] -> [String]
addOuterOs input = map (\line -> line ++ "o") input ++ [replicate xLength 'o']
    where
        xLength = 1 + (length $ head input)

-- PART 2 HELPER METHODS
scale :: [String] -> [String]
scale = transpose . map (addBefore upReplace) . transpose . map (addBefore leftReplace)
    where 
        addBefore :: (Char -> Char) -> [Char] -> [Char]
        addBefore f = concatMap (\c -> [f c, c])

upReplace :: Char -> Char
upReplace c
    | c == '|' || c == 'L' || c == 'J' = '|'
    | otherwise = 'o'

leftReplace :: Char -> Char
leftReplace c
    | c == '-' || c == 'J' || c == '7' = '-'
    | otherwise = 'o'

-- PART 1 & 2- HELPER METHODS
neighbours :: Coord -> [Coord]
neighbours (x, y) =
    [(x + dx, y + dy) | dy <- [-1, 0, 1], dx <- [-1, 0, 1], (dx, dy) /= (0, 0)]

-- PART 1 - HELPER METHODS
start :: GridElement -> Bool
start ((_,_), 'S') = True
start _ = False

-- PARSING
createGrid :: [[Char]] -> [GridElement] 
createGrid chars = [((x, y), c) | (y, row) <- zip [0..] chars, (x, c) <- zip [0..] row]