import Data.List.Split (splitOn)
import Debug.Trace (trace)

type FromToRange = (Int, Int, Int)

main = do
    inputAsT <- chunks <$> readFile "input.txt"
    let input = map lines inputAsT
        seeds = getSeeds input
        ranges = getRanges input
    print $ minimum $ map (\s -> calculateLocation s ranges) seeds

-- PART 1
calculateLocation :: Int -> [[FromToRange]] -> Int
calculateLocation currSeedVal [] = currSeedVal
calculateLocation currSeedVal (mapper:mappers) = calculateLocation (getNewValue currSeedVal $ mapper) mappers
    where
        isValidRange :: Int -> FromToRange -> Bool
        isValidRange seed range = if (seed >= second range && seed <= second range + third range) then True else False

        getNewFromValidRange :: Int -> FromToRange -> Int
        getNewFromValidRange seed range = first range + seed - (second range)

        getNewValue :: Int -> [FromToRange] -> Int
        getNewValue seed ranges = if (validRanges == []) then seed else getNewFromValidRange currSeedVal $ head $ validRanges
            where
                validRanges = filter (\r -> first r /= -1) $ map (\range -> if isValidRange seed range then range else (-1,-1,-1)) ranges

-- PART 2


-- PARSING & HELPERMETHODS
first :: (a, b, c) -> a  
first (x, _, _) = x  
  
second :: (a, b, c) -> b  
second (_, y, _) = y  
  
third :: (a, b, c) -> c  
third (_, _, z) = z  

getSeeds :: [[String]] -> [Int]
getSeeds input = map (\n -> read n) $ drop 1 $ words $ head $ head input

getRanges :: [[String]] -> [[FromToRange]]
getRanges = map (map ((\[a, b, c] -> (a, b, c)) . map read . words) . drop 1) . drop 1

chunks :: String -> [String]
chunks input = splitOn "\n\n" input