module Common (countOccs, getMiddle) where

countOccs :: Eq a => a -> [a] -> Int
countOccs x = length . filter (== x)

getMiddle :: [a] -> a
getMiddle xs = xs !! (length xs `div` 2)