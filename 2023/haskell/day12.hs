import Data.List.Split (splitOn)
import Data.List (group)

type Record = (String, [Int])
type SplitRecord = ([String], [Int])

-- ???.### 1,1,3 - 1 arrangement
-- .??..??...?##. 1,1,3 - 4 arrangements
-- ?#?#?#?#?#?#?#? 1,3,1,6 - 1 arrangement
-- ????.#...#... 4,1,1 - 1 arrangement
-- ????.######..#####. 1,6,5 - 4 arrangements
-- ?###???????? 3,2,1 - 10 arrangements

main = do
    input <- lines <$> readFile "test.txt"
    let records = map parse input
    print $ map splitByWorking records

splitByWorking :: Record -> SplitRecord
splitByWorking record = (splitted, snd record)
    where
        splitted = filter ((/= '.') . head) $ group $ fst record

parse :: String -> Record
parse input = (str, numbers)
    where
        str = head $ words input
        numbers =  map read $ splitOn "," $ last $ words input