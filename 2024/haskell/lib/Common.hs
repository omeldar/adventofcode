module Common (countOccs) where

countOccs :: Eq a => a -> [a] -> Int
countOccs x = length . filter (== x)