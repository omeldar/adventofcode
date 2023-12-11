import qualified Data.Map as M
import qualified Data.Set as S
import Data.List (find, intercalate, transpose)
import Data.Maybe (fromJust)

type Coord = (Int, Int)
type GridElement = (Coord, Char)

-- no guarantee it works on every input

main = do
    input <- scale . lines <$> readFile "input.txt"
    let inputWithOuterOs = addOuterOs input
        grid = createGrid inputWithOuterOs
        xB = length $ head inputWithOuterOs
        yB = length inputWithOuterOs
        pipeMap = M.fromList grid
        startEl = fromJust $ find start grid

        coordsAdjToStart = filter (\c -> c `elem` pipeOpenings startEl) $ neighbours $ fst startEl
        pipesAdjToStart = map (\c -> (c, fromJust $ M.lookup c pipeMap)) coordsAdjToStart
        pipesOfLoop = loopPipe pipeMap (head $ pipesAdjToStart) startEl (head $ pipesAdjToStart) S.empty
        floodedSet = floodFill [(0,0)] ((xB + 1), (yB + 1)) pipesOfLoop
        inner = filter (\(p,c) -> p `S.notMember` floodedSet) grid
    writeFile "out.txt" $ intercalate "\n" $ inputWithOuterOs -- If you want to output a visualization - upscaled grid of pipes
    print $ (S.size pipesOfLoop) `div` 4
    print $ (`countElements` 0) $ map fst inner

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
    | c == 'S' = [(currX - 1, currY), (currX, currY + 1)] -- only working for inputs where S = 7
    | c == '|' = [(currX, currY - 1), (currX, currY + 1)] -- |
    | c == '-' = [(currX - 1, currY), (currX + 1, currY)] -- -
    | c == 'L' = [(currX + 1, currY), (currX, currY - 1)] -- └
    | c == 'J' = [(currX - 1, currY), (currX, currY - 1)] -- ┘
    | c == '7' = [(currX - 1, currY), (currX, currY + 1)] -- ┐ 
    | c == 'F' = [(currX + 1, currY), (currX, currY + 1)] -- ┌

-- PART 2
floodFill :: [Coord] -> Coord -> S.Set Coord -> S.Set Coord
floodFill [] _ visited = visited
floodFill (coord:coords) (xB, yB) visited = floodFill (neighboursNotVisited ++ coords) (xB, yB) (S.insert coord visited)
    where
        neighboursNotVisited = filter (\c -> c `S.notMember` visited) neighboursByBounds
        neighboursByBounds = filter (\(x,y) -> x < xB && x >= 0 && y < yB && y >= 0) $ neighbours coord

countElements :: [Coord] -> Int -> Int
countElements [] count = count
countElements ((x, y):ps) count = countElements ps val
    where
        val = if odd x && odd y then count + 1 else count

floodedPoints :: [Coord] -> M.Map Coord Char -> Int -> Int
floodedPoints [] _ count = count
floodedPoints (coord:coords) pipeMap count = floodedPoints coords pipeMap newDotCount
    where
        newDotCount = if ('.' == char) then (count + 1) else count
        char = fromJust $ M.lookup coord pipeMap

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
    | c == 'S' = '-'
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