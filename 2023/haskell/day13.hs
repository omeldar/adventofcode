import Data.List (transpose, findIndices)
import Data.List.Split (splitOn)

main = do
    input <- map lines . splitOn "\n\n" <$> readFile "input.txt"
    print $ sum $ map (`searchPattern` 0) input
    print $ sum $ map (`searchPattern` 1) input

searchPattern :: [String] -> Int -> Int
searchPattern pattern mistakes
    | horMirror /= 0 = horMirror
    | otherwise = mirrorIndex (transpose pattern) 0 True mistakes
    where
        horMirror = mirrorIndex pattern 0 False mistakes

mirrorIndex :: [String] -> Int -> Bool -> Int -> Int
mirrorIndex pattern i isV mistakes
    | i >= (length pattern-1) = 0
    | mismatches <= mistakes && diffToBounds == mistakes = value i isV
    | otherwise = mirrorIndex pattern (i+1) isV mistakes
    where
        mismatches = length (indices (pattern !! i) (pattern !! (i+1)))
        diffToBounds = differences pattern (i, i+1) 0

differences :: [String] -> (Int, Int) -> Int -> Int
differences pattern (up, down) diffCount
    | up < 0 || down > (length pattern-1) = diffCount
    | otherwise = differences pattern (up-1, down+1) (diffCount + length (indices (pattern !! up) (pattern !! down)))

value :: Int -> Bool -> Int
value index isV = if isV then index+1 else (index+1)*100

indices :: String -> String -> [Int]
indices str1 str2 = findIndices (uncurry (/=)) $ zip str1 str2