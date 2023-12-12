import Data.List.Split (splitOn)

type Record = (String, [Int])

main = do
    input <- lines <$> readFile "test.txt"
    let records = map parse input
    print records

parse :: String -> Record
parse input = (str, numbers)
    where
        str = head $ words input
        numbers =  map read $ splitOn "," $ last $ words input