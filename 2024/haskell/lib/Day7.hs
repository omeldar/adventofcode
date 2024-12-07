module Day7 (run) where

import qualified Data.Map as Map
import Data.List.Split (splitOn)

run :: String -> IO ()
run filePath = do
    content <- parse <$> readFile filePath
    print $ part1 content
    print $ part2 content

part1 :: [(Int, [Int])] -> Int
part1 entries = sum $ map fst $ filter (\(target, numbers) -> isResolvableP1Dp numbers target) entries

part2 :: [(Int, [Int])] -> Int
part2 entries = sum $ map fst $ filter (\(target, numbers) -> isResolvableP2Dp numbers target) entries

isResolvableP1Dp :: [Int] -> Int -> Bool
isResolvableP1Dp numbers target = dfs 1 (head numbers) Map.empty
  where
    dfs :: Int -> Int -> Map.Map (Int, Int) Bool -> Bool
    dfs index currentValue memo
      | index == length numbers = currentValue == target
      | Map.member (index, currentValue) memo = memo Map.! (index, currentValue)
      | otherwise =
          let add = dfs (index + 1) (currentValue + numbers !! index) memo
              multiply = dfs (index + 1) (currentValue * numbers !! index) memo
              result = add || multiply
              newMemo = Map.insert (index, currentValue) result memo
          in result

isResolvableP2Dp :: [Int] -> Int -> Bool
isResolvableP2Dp numbers target = dfs 1 (head numbers) Map.empty
    where
        dfs :: Int -> Int -> Map.Map (Int, Int) Bool -> Bool
        dfs index currentValue memo
            | index == length numbers = currentValue == target
            | Map.member (index, currentValue) memo = memo Map.! (index, currentValue)
            | otherwise =
                let add = dfs (index + 1) (currentValue + numbers !! index) memo
                    multiply = dfs (index + 1) (currentValue * numbers !! index) memo
                    concatenate = dfs (index + 1) (read (show currentValue ++ show (numbers !! index))) memo
                    result = add || multiply || concatenate
                    newMemo = Map.insert (index, currentValue) result memo
                in result

parse :: String -> [(Int, [Int])]
parse = map (\line -> let [k, v] = splitOn ":" line in (read k, map read (words v))) . lines