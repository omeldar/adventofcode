module Day5 (run) where

import Data.List.Split ( splitOn )
import qualified Data.Map as Map
import Data.Map ( Map )
import Common ( getMiddle )

type Rules = Map.Map Int [Int]

run :: String -> IO ()
run filePath = do
    [rulesS, updatesS] <- map lines . splitOn "\n\n" <$> readFile filePath
    let rules = parseRules rulesS
        updates = map (map read . splitOn ",") updatesS
    print $ sum $ map getMiddle $ filter (isValidRow rules) updates

isValidRow :: Map Int [Int] -> [Int] -> Bool
isValidRow rulesMap row = all (\(key, values) -> 
    case lookup key positions of
            Just keyPos -> all (\v-> maybe True (> keyPos) (lookup v positions)) values
            Nothing -> True
        ) (Map.toList rulesMap)
    where positions = zip row [0..]

parseRules :: [String] -> Map Int [Int]
parseRules rulesList = Map.fromListWith (++) [(read key, [read value]) | rule <- rulesList, let [key, value] = splitOn "|" rule]