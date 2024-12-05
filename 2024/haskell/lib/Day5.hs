module Day5 (run) where

import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)
import Data.List (elemIndex, delete, nub, sortBy)
import Common (getMiddle)
import qualified Data.Map as Map

-- Type definitions
type Rule = (Int, Int)
type Rules = [Rule]
type RuleMap = Map.Map Int [Int]

run :: String -> IO ()
run filePath = do
    [rulesS, updatesS] <- map lines . splitOn "\n\n" <$> readFile filePath
    let rules = parseRules rulesS
        updates = map (map read . splitOn ",") updatesS
        
    print $ sum $ map getMiddle $ filter (isValidRow rules) updates
    print $ sum $ map getMiddle $ map (dynamicSort $ buildRuleMap rules) $ filter (not . isValidRow rules) updates

isValidRow :: Rules -> [Int] -> Bool
isValidRow rules row = all (\(a, b) -> case elemIndex a row of
                                         Just posA -> maybe True (> posA) (elemIndex b row)
                                         Nothing -> True) rules

customCompare :: RuleMap -> Int -> Int -> Ordering
customCompare rules x y
  | x `comesBefore` y = LT
  | y `comesBefore` x = GT
  | otherwise         = EQ
  where
    comesBefore a b = elem b (Map.findWithDefault [] a rules)

dynamicSort :: RuleMap -> [Int] -> [Int]
dynamicSort rules xs = sortBy (customCompare rules) xs

-- parsing

parseRules :: [String] -> Rules
parseRules rulesList = [(read key, read value) | rule <- rulesList, let [key, value] = splitOn "|" rule]

buildRuleMap :: [Rule] -> RuleMap
buildRuleMap rules =
  foldr (\(a, b) m -> Map.insertWith (++) a [b] m) Map.empty rules
