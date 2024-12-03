module Day3 (run) where

import Text.Regex.PCRE ((=~))
import Data.List.Split (splitOn)

expression :: String
expression = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"

run :: String -> IO ()
run filePath = do
    content <- readFile filePath
    print $ sum $ map (\[_, x, y] -> read x * read y) $ content =~ expression -- part 1
    print $ sum $ map (\[_, x, y] -> read x * read y) $ (onlyDo's content) =~ expression -- part 2

onlyDo's :: String -> String
onlyDo's str = 
    let newInp = "do()" ++ str
        parts = splitOn "don't()" newInp
    in concatMap (concat . drop 1 . splitOn "do()") parts


