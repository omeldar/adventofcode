import Data.List (transpose, intercalate, tails)
import Debug.Trace (trace)

type Coord = (Int, Int)
type GridElement = (Coord, Int)

main = do
    input <- lines <$> readFile "test.txt"
    let galaxiesExpanded = expandGalaxy input
        grid = createGrid galaxiesExpanded

        -- [Coord] of all coordinates where galaxies lie
        galaxyCoordinates = galaxyLocations grid [] 

        -- [(Coord, Coord)] a list of all possible combinations to calculate distance for
        galaxyCombinations = combinations galaxyCoordinates

    --writeFile "out.txt" $ intercalate "\n" $ galaxiesExpanded
    print $ sum $ map calcDistance galaxyCombinations

-- PART 1
-- calculate shortest distance with x distance + y distance
calcDistance :: (Coord, Coord) -> Int
calcDistance ((x1, y1), (x2, y2)) = abs (x2 - x1) + abs (y2 - y1)

-- all combinations of galaxies to get shortest distance for (unique elements)
combinations :: [Coord] -> [(Coord, Coord)]
combinations xs = [ (x,y) | (x:rest) <- tails xs , y <- rest ]
        
-- all galaxy coordinates
galaxyLocations :: [GridElement] -> [Coord] -> [Coord]
galaxyLocations [] coords = coords
galaxyLocations (el:grid) coords = galaxyLocations grid newCoords
    where
        newCoords = if snd el == 0 then coords ++ [fst el] else coords

-- expand the galaxy rows and columns if no galaxy inside, then parse to grid
createGrid :: [[Char]] -> [GridElement]
createGrid chars = [((x,y), if ((chars !! y) !! x) == '#' then 0 else 1) | y <- [0..((length chars) - 1)], x <- [0..((length $ head chars) - 1)]]

-- I did not use transpose because transposing and then applying would
expandGalaxy :: [[Char]] -> [[Char]]
expandGalaxy input = expandColumns (expandRows input [])

expandRows :: [[Char]] -> [[Char]] -> [[Char]]
expandRows [] newRows = newRows
expandRows (row:rows) newRows = expandRows rows addedRows
    where
        addedRows = if '#' `elem` row then newRows ++ [row] else newRows ++ [expandedRow] ++ [row]
        expandedRow = replicate (length row) '.'

expandColumns :: [[Char]] -> [[Char]]
expandColumns grid = transpose $ expandRows (transpose grid) []