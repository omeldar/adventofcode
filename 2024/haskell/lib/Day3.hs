module Day3 (run) where

import Text.Regex.PCRE ((=~))
import Data.List (unfoldr)

expression :: String
expression = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"

run :: String -> IO ()
run filePath = do
    content <- readFile filePath
    let allMuls = content =~ expression :: [[String]]
        segments = splitSegments content
    print $ sum $ map (\[_, x, y] -> read x * read y) allMuls -- part 1
    print $ segments -- still working on part 2

splitSegments :: String -> [String]
splitSegments str = initialSegment : map (!! 0) (str =~ regex)
  where
    regex = "(do\\(\\)|don't\\(\\)).*?(?=(do\\(\\)|don't\\(\\))|$)"
    initialSegment = takeWhile (`notElem` "do()") str

--splitOnDelimiters :: String -> String
--splitOnDelimiters input = head $ splitOneOf ["do()", "don't()"] input