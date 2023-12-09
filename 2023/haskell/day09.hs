main = do
    input <- map (map (read :: String -> Int) . words) . lines <$> readFile "input.txt"
    print $ sum $ map getNext input
    print $ sum $ map getNext $ map reverse input

getNext :: [Int] -> Int
getNext nums = if all (== 0) nums then 0 else last nums + (getNext $ zipWith (-) (tail nums) nums)