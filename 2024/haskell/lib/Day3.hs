module Day3 (run, part1, part2) where

import Text.Regex.PCRE ((=~))
import Data.List.Split (splitOn)

expression = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"

run :: String -> IO ()
run filePath = do
    content <- readFile filePath
    print $ part1 content
    print $ part2 content

part1 :: String -> Int
part1 content = sum $ map multiply $ content =~ expression

part2 :: String -> Int
part2 content = sum $ map multiply $ onlyDo's content =~ expression

multiply :: [String] -> Int
multiply [_, x, y] = read x * read y

onlyDo's :: String -> String
onlyDo's = concatMap (concat . drop 1 . splitOn "do()") . splitOn "don't()" . ("do()" ++)