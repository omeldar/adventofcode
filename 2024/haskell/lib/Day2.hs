module Day2 (run, part1, part2) where

run :: String -> IO()
run filePath = do
    lists <- (map (map read . words) . lines) <$> readFile filePath :: IO [[Int]]
    print $ part1 lists
    print $ part2 lists

part1 :: [[Int]] -> Int
part1 lists = length $ filter isValidList lists

part2 :: [[Int]] -> Int
part2 lists = length $ filter isValidWithRemoval lists

removeOne :: [a] -> [[a]]
removeOne [] = [[]]
removeOne (x:xs) = xs : map (x :) (removeOne xs)

isValidWithRemoval :: [Int] -> Bool
isValidWithRemoval xs = isValidList xs || any isValidList (removeOne xs)

isValidList :: [Int] -> Bool
isValidList xs = (and (zipWith (>) xs (tail xs)) || and (zipWith (<) xs (tail xs))) && validSteps xs
  where validSteps = all (\(a, b) -> abs (a - b) >= 1 && abs (a - b) <= 3) . zip xs . tail