module Day5 (run) where

import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)
import Data.List (elemIndex, delete, nub, sortBy)
import Common (getMiddle)
import qualified Data.Map as Map

type RuleMap = Map.Map Int [Int]

run :: String -> IO ()
run filePath = do
    [rulesS, updatesS] <- map lines . splitOn "\n\n" <$> readFile filePath
    let ruleMap = parseRules rulesS
        updates = map (map read . splitOn ",") updatesS
        
    print $ sum $ map getMiddle $ filter (isValidRow ruleMap) updates
    print $ sum $ map (getMiddle . dynamicSort ruleMap) (filter (not . isValidRow ruleMap) updates)

isValidRow :: RuleMap -> [Int] -> Bool
isValidRow rules row = all (\(a, b) -> case elemIndex a row of
                                         Just posA -> maybe True (> posA) (elemIndex b row)
                                         Nothing -> True) (flattenRules rules)

customCompare :: RuleMap -> Int -> Int -> Ordering
customCompare rules x y
  | x `comesBefore` y = LT
  | y `comesBefore` x = GT
  | otherwise         = EQ
  where
    comesBefore a b = b `elem` (Map.findWithDefault [] a rules)

dynamicSort :: RuleMap -> [Int] -> [Int]
dynamicSort rules = sortBy (customCompare rules)

parseRules :: [String] -> RuleMap
parseRules rulesList = foldr (\rule m -> let [key, value] = map read (splitOn "|" rule) in Map.insertWith (++) key [value] m) Map.empty rulesList

flattenRules :: RuleMap -> [(Int, Int)]
flattenRules ruleMap = [(key, value) | (key, values) <- Map.toList ruleMap, value <- values]
