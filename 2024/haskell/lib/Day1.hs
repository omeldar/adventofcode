module Day1 (run, part1, part2, parse) where

import Data.List ( sort )
import Common ( countOccs )

run :: String -> IO()
run filePath = do
    contents <- readFile filePath
    let (left, right) = parse contents
    print $ part1 (left, right)
    print $ part2 (left, right)

part1 :: ([Int], [Int]) -> Int
part1 (left, right) = sum $ zipWith (\x y -> abs (x - y)) left right

part2 :: ([Int], [Int]) -> Int
part2 (left, right) = sum $ map (\x -> x * countOccs x right) left

parse :: String -> ([Int], [Int])
parse inp = let (left, right) = unzip $ map ((\[a, b] -> (read a, read b)) . words) (lines inp)
            in (sort left, sort right)
