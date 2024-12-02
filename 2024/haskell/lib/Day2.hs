module Day2 (run) where

import Data.List ( words )

run :: String -> IO()
run filePath = do
    contents <- readFile filePath
    let lists = map (map read . words) (lines contents) :: [[Int]]
    print $ part1 lists
    print $ part2 lists

part1 :: [[Int]] -> Int
part1 lists = length (filter isValidList lists)

part2 :: [[Int]] -> Int
part2 lists = length (filter isValidWithRemoval lists)

-- non-exposed

isValidWithRemoval :: [Int] -> Bool
isValidWithRemoval xs = isValidList xs || canBeMadeValid xs

removeOne :: [a] -> [[a]]
removeOne [] = [[]]
removeOne (x:xs) = xs : map (x :) (removeOne xs)

canBeMadeValid :: [Int] -> Bool
canBeMadeValid xs = any isValidList (removeOne xs)

isIncreasing :: [Int] -> Bool
isIncreasing (x:y:ys) = y > x && isIncreasing (y:ys)
isIncreasing _ = True

isDecreasing :: [Int] -> Bool
isDecreasing (x:y:ys) = y < x && isDecreasing (y:ys)
isDecreasing _ = True

validStep :: [Int] -> Bool
validStep (x:y:ys) = abs (y - x) >= 1 && abs (y - x) <= 3 && validStep (y:ys)
validStep _ = True

isValidList :: [Int] -> Bool
isValidList xs = (isIncreasing xs || isDecreasing xs) && validStep xs