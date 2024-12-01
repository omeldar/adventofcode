module Day1 (run) where

import Data.List (sort, nub)

run :: String -> IO()
run filePath = do
    contents <- readFile filePath
    let (left, right) = parse contents
    print $ show $ sum $ zipWith (\x y -> abs (x - y)) left right
    print $ show $ sum $ map (\x -> x * countOccs x right) $ nub left

countOccs :: Eq a => a -> [a] -> Int
countOccs x = length . filter (== x)

parse :: String -> ([Int], [Int])
parse inp = let (left, right) = unzip $ map ((\[a, b] -> (read a, read b)) . words) (lines inp)
            in (sort left, sort right)
