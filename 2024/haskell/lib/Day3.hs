module Day3 (run) where

import Text.Regex.PCRE ((=~))
import Data.List.Split (splitOn)

expression :: String
expression = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"

run :: String -> IO ()
run filePath = do
    content <- readFile filePath
    print $ part1 content
    print $ part2 content

part1 :: String -> Int
part1 content = sum $ map (\[_, x, y] -> read x * read y) $ content =~ expression

part2 :: String -> Int
part2 content = sum $ map (\[_, x, y] -> read x * read y) $ (onlyDo's content) =~ expression

onlyDo's :: String -> String
onlyDo's str = 
    let newInp = "do()" ++ str
        parts = splitOn "don't()" newInp
    in concatMap (concat . drop 1 . splitOn "do()") parts
