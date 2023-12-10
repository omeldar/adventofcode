import Data.Char (isDigit)
import Data.List (nub)

type Coord = (Int, Int)

main = do
    input <- lines <$> readFile "input.txt"
    print $ processGrid input
    print $ processGrid2 input

neighbours :: Coord -> [Coord]
neighbours (x, y) =
    [(x + dx, y + dy) | dy <- [-1, 0, 1], dx <- [-1, 0, 1], (dx, dy) /= (0, 0)]

withinBounds :: Int -> Int -> Coord -> Bool
withinBounds xMax yMax (x, y) = x >= 0 && x < xMax && y >= 0 && y < yMax

valueAt :: [String] -> Coord -> Char
valueAt input (x, y)
    | withinBounds (length (head input)) (length input) (x, y) = (input !! y) !! x
    | otherwise = '.'

isSymbol :: Char -> Bool
isSymbol c = not (isDigit c || c == '.')

getToBounds :: Char -> Coord -> Int -> [Coord]
getToBounds op coord inpLength
    | op == 'L' = [(x,snd coord) | x <- [0..(fst coord - 1)]]
    | op == 'R' = [(x,snd coord) | x <- [(fst coord + 1)..inpLength]]

buildConnectedDigits :: [String] -> Coord -> Int
buildConnectedDigits input coord = read (reverse leftDigits ++ [valueAt input coord] ++ rightDigits)
    where
        leftDigits = takeWhile isDigit $ reverse $ map (\c -> valueAt input c) (getToBounds 'L' coord (length (head input)))
        rightDigits = takeWhile isDigit $ map (\c -> valueAt input c) (getToBounds 'R' coord (length (head input)))

findSumAdjacentNumbers :: [String] -> Coord -> Int
findSumAdjacentNumbers input coord =  
    let adjacentCoords = filter (withinBounds (length (head input)) (length input)) (neighbours coord)
        adjacentDigitCoords = [coord | coord <- adjacentCoords, isDigit $ valueAt input coord]
        adjacentValues = map (\c -> buildConnectedDigits input c) adjacentDigitCoords -- map char of adjacent coords (reading values)
    in sum $ nub adjacentValues

-- processes the grid and returns all the coordinates of the symbols, then collects all the numbers adjacent to symbols
-- in a last step, it sums all those numbers
processGrid :: [String] -> Int
processGrid input =
    let symbolCoords = [(x, y) | y <- [0..length input - 1], x <- [0..length (head input) - 1], isSymbol (valueAt input (x, y))]
        numbersAdjacentToSymbols = map (findSumAdjacentNumbers input) symbolCoords
    in sum numbersAdjacentToSymbols

-- PART 2, only functions that needed to be adjusted, have been adjusted

isSymbol2 :: Char -> Bool
isSymbol2 c = c == '*'

findSumAdjacentNumbers2 :: [String] -> Coord -> Int
findSumAdjacentNumbers2 input coord =  
    let adjacentCoords = filter (withinBounds (length (head input)) (length input)) (neighbours coord)
        adjacentDigitCoords = [coord | coord <- adjacentCoords, isDigit $ valueAt input coord]
        adjacentValues = nub $ map (\c -> buildConnectedDigits input c) adjacentDigitCoords -- map char of adjacent coords (reading values)
    in if length adjacentValues == 2 then product adjacentValues else 0

-- processes the grid and returns all the coordinates of the symbols, then collects all the numbers adjacent to symbols
-- in a last step, it sums all those numbers
processGrid2 :: [String] -> Int
processGrid2 input =
    let symbolCoords = [(x, y) | y <- [0..length input - 1], x <- [0..length (head input) - 1], isSymbol2 (valueAt input (x, y))]
        numbersAdjacentToSymbols = map (findSumAdjacentNumbers2 input) symbolCoords
    in sum numbersAdjacentToSymbols

-- ----------------------------------------------------------------------------------------------------------------------
-- !! This is not needed to run the solution, but I used it in the beginning to get an idea on how to work with a grid !!
buildGrid :: [String] -> [Coord]
buildGrid input = [(x, y) | y <- [0..yLength], x <- [0..xLength]]
    where
        xLength = maximum $ map length input
        yLength = length input