module Day1 (run) where

import Data.List (sort, nub)

run :: String -> IO()
run filePath = do
    contents <- readFile filePath
    let (left, right) = parse contents
    print $ show $ calcDistance (sort left, sort right) 0
    print $ show $ calcSimilarity (sort $ nub left, sort right) 0

calcDistance :: ([Int], [Int]) -> Int -> Int
calcDistance ([], []) dist = dist
calcDistance (left:ls, right:rs) dist = calcDistance (ls, rs) $ dist + abs (left - right)

calcSimilarity :: ([Int], [Int]) -> Int -> Int
calcSimilarity ([], _) sim = sim
calcSimilarity (left:ls, right) sim = calcSimilarity (ls, right) newSim
    where newSim = sim + left * countOccurences left right

countOccurences :: Eq a => a -> [a] -> Int
countOccurences x = length . filter (== x)

parse :: String -> ([Int], [Int])
parse inp = unzip $ map ((\[a, b] -> (read a, read b)) . words ) (lines inp)
