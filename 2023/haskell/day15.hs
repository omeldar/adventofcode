import Data.List.Split (splitOn)
import Data.Char (ord)
import qualified Data.Map as M

main = do
    input <- splitOn "," <$> readFile "input.txt"
    print $ sum $ map (\str -> hash str) input

hash :: String -> Int
hash = foldl (\acc c -> ((acc + (ord c)) * 17) `mod` 256) 0
