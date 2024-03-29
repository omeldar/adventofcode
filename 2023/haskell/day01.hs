import Data.Char (isDigit)
import Data.List (findIndex, isPrefixOf)

main = do
    input <- lines <$> readFile "test.txt"
    print $ sum $ map getNumber input

-- PART 1
getNumber :: String -> Int
getNumber calStr = read [head digits, last digits]
    where
        digits = [c | c <- calStr, isDigit c]

-- PART 2
numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]