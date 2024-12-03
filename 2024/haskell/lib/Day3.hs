module Day3 (run) where

import Text.Regex.PCRE ((=~))
import Data.List.Split (splitOn)

expression :: String
expression = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"

run :: String -> IO ()
run filePath = do
    content <- readFile filePath
    let allMuls = content =~ expression :: [[String]]
        segments = splitSegments content
    print $ sum $ map (\[_, x, y] -> read x * read y) allMuls -- part 1
    print segments
    print $ sum $ map sumSegment segments

sumSegment :: String -> Int
sumSegment segment =
    let allMuls = segment =~ expression :: [[String]]
    in sum $ map (\[_, x, y] -> read x * read y) allMuls

splitSegments :: String -> [String]
splitSegments str = splitOnDelimiters str : filter (startsWithDo) (map (!! 0) (str =~ regex))
  where
    regex = "(do\\(\\)|don't\\(\\)).*?(?=(do\\(\\)|don't\\(\\))|$)"
    startsWithDo segment = take 4 segment == "do()"

splitOnDelimiters :: String -> String
splitOnDelimiters input = head $ splitOn "don't()" $ head $ splitOn "do()" input