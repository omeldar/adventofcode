module Day5 (run) where

import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)
import Data.List (elemIndex, sortBy)
import Common (getMiddle)
import qualified Data.Map as Map

type RuleMap = Map.Map Int [Int]

run :: String -> IO ()
run filePath = do
    (ruleMap, updates) <- parseInput <$> readFile filePath
    print $ part1 ruleMap updates
    print $ part2 ruleMap updates

part1 :: RuleMap -> [[Int]] -> Int
part1 ruleMap updates = sum $ map getMiddle $ filter (\row -> row == reverse (dynamicSort ruleMap row)) updates

part2 :: RuleMap -> [[Int]] -> Int
part2 ruleMap updates = sum $ map (getMiddle . dynamicSort ruleMap) (filter (\row -> row /= reverse (dynamicSort ruleMap row)) updates)

customCompare :: RuleMap -> Int -> Int -> Ordering
customCompare rules x y = if x `elem` Map.findWithDefault [] y rules then LT else GT

dynamicSort :: RuleMap -> [Int] -> [Int]
dynamicSort rules = sortBy (customCompare rules)

-- parsing
parseInput :: String -> (RuleMap, [[Int]])
parseInput input = let [rulesS, updatesS] = map lines (splitOn "\n\n" input) in (parseRules rulesS, map (map read . splitOn ",") updatesS)

parseRules :: [String] -> RuleMap
parseRules = foldr (\rule m -> let [key, value] = map read (splitOn "|" rule) in Map.insertWith (++) key [value] m) Map.empty
