module Day11 (run) where

import Data.Map as DM (fromList, findWithDefault)
import Common (rmLeadingZeroes)

run :: String -> IO ()
run filePath = do
    stones <- map (read :: String -> Int) . words <$> readFile filePath
    print $ sum $ map (blink 25) stones
    print $ sum $ map (blink 75) stones  -- ~2s

splitMiddle :: Int -> [Int]
splitMiddle toSplit = [read $ take newSize $ show toSplit, read $ drop newSize $ show toSplit]
    where newSize = length (show toSplit) `div` 2

turn :: Int -> [Int]
turn 0 = [1]
turn n 
  | even $ length $ show n = splitMiddle n
  | otherwise = [2024 * n]

blink :: Int -> Int -> Int
blink = calcMem
    where   
        cache = DM.fromList [((initial, steps), sum (map (calcMem (steps - 1)) (turn initial))) | initial <- [0..100], steps <- [0..75]]
        calcMem :: Int -> Int -> Int
        calcMem 0 _ = 1
        calcMem newSteps stone = DM.findWithDefault fallback (stone, newSteps) cache
            where 
                fallback = sum $ map (calcMem (newSteps - 1)) $ turn stone
