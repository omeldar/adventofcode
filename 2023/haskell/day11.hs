import Data.List (transpose, tails, intersect)

type Coord = (Int, Int)
type GridElement = (Coord, Int)

main = do
    input <- lines <$> readFile "input.txt"
    let grid = createGrid input
        galaxyCombinations = combinations (galaxyLocations grid [])
        emptyXandY = getEmptyXandY input
    print $ sum $ map (\comb -> calcScaledDistance comb emptyXandY 2) galaxyCombinations
    print $ sum $ map (\comb -> calcScaledDistance comb emptyXandY 1000000) galaxyCombinations  -- both parts in ~3.35 secs

-- calculate scale based on empty line crossings and the normal distance
calcScaledDistance :: (Coord, Coord) -> ([Int], [Int]) -> Int -> Int
calcScaledDistance ((x1, y1), (x2, y2)) (xEmpty, yEmpty) rangePerEmpty =  expandedSpaceDistance + normalDistance
    where
        normalDistance = calcDistance ((x1, y1), (x2, y2))
        expandedSpaceDistance = xIntersectRange * (rangePerEmpty - 1) + yIntersectRange * (rangePerEmpty - 1)
        xIntersectRange = length $ [(min x1 x2+1)..(max x1 x2)] `intersect` xEmpty
        yIntersectRange = length $ [(min y1 y2+1)..(max y1 y2)] `intersect` yEmpty

-- get all indexes for empty lines horizontally and vertically
getEmptyXandY :: [[Char]] -> ([Int], [Int])
getEmptyXandY input = (xIndexs, yIndexs)
    where
        yIndexs = emptyRowIndxs input
        xIndexs = emptyRowIndxs (transpose input)

-- get indexes of empty lines (no '#')
emptyRowIndxs :: [[Char]] -> [Int]
emptyRowIndxs grid = [index | (line, index) <- zip grid [0..], '#' `notElem` line]

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
createGrid chars = [((x,y), if ((chars !! y) !! x) == '#' then 0 else 1) | y <- [0..(length chars - 1)], x <- [0..(length (head chars) - 1)]]