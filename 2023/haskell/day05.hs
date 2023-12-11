import Data.List.Split (splitOn, chunksOf)

type FromToRange = (Int, Int, Int)

main = do
    inputAsT <- chunks <$> readFile "input.txt"
    let input = map lines inputAsT
        ranges = getRanges input
        seeds = getSeeds input
    print $ minimum $ map (`calculateLocation` ranges) seeds -- ~0.01s
    print $ minimum $ forSeeds (chunksOf 2 seeds) ranges    -- ~2h15m (when compiled)

-- PART 1
calculateLocation :: Int -> [[FromToRange]] -> Int
calculateLocation currSeedVal [] = currSeedVal
calculateLocation currSeedVal (mapper:mappers) = calculateLocation (getNewValue currSeedVal mapper) mappers
    where
        isValidRange :: Int -> FromToRange -> Bool
        isValidRange seed range = seed >= second range && seed <= second range + third range

        getNewValue :: Int -> [FromToRange] -> Int
        getNewValue seed [] = seed
        getNewValue seed (range:ranges)
            | isValidRange seed range = first range + seed - second range
            | otherwise = getNewValue seed ranges

-- PART 2
forSeeds :: [[Int]] -> [[FromToRange]] -> [Int]
forSeeds seedChunks ranges = map (minimum . map (`calculateLocation` ranges)) seedRanges
    where
        seedRanges = map (\c -> [head c..((head c + last c) -1)]) seedChunks

-- PARSING & HELPERMETHODS
-- HELPER
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- PARSING
getSeeds :: [[String]] -> [Int]
getSeeds input = map read $ drop 1 $ words $ head $ head input

getRanges :: [[String]] -> [[FromToRange]]
getRanges = map (map ((\[a, b, c] -> (a, b, c)) . map read . words) . drop 1) . drop 1

chunks :: String -> [String]
chunks = splitOn "\n\n"