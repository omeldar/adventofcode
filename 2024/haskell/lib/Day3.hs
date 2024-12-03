module Day3 (run) where

import Text.Regex.PCRE ((=~))

expression :: String
expression = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"

run :: String -> IO()
run filePath = do
    content <- readFile filePath
    let muls = content =~ expression :: [[String]]
    print $ sum $ map parseAndMultiply muls

parseAndMultiply :: [String] -> Int
parseAndMultiply [_, x, y] = read x * read y