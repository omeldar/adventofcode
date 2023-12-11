main = do
    input <- map (map read . words) . lines <$> readFile "input.txt"
    print $ sum $ map getNext input
    print $ sum $ map (getNext . reverse) input

getNext :: [Int] -> Int
getNext nums = if all (== 0) nums then 0 else last nums + getNext (zipWith (-) (tail nums) nums)