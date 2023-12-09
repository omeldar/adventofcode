main = do
    input <- map (map (read :: String -> Int) . words) . lines <$> readFile "input.txt"
    print $ sum $ map getNext input
    print $ sum $ map getNext $ map reverse input

getNext :: [Int] -> Int
getNext nums
    | all (== 0) nums = 0
    | otherwise = last nums + (getNext $ zipWith (-) (tail nums) nums)