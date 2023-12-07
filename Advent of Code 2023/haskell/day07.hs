import Data.Char (isDigit, digitToInt)
import Data.List (sort, sortBy)
import Data.Map (fromListWith, toList)
import Debug.Trace (trace)

type Hand = ([Int], Int, Int)

main = do
    input <- lines <$> readFile "input.txt"
    let hands = map mapStrHToH input
    print $ sum $ zipWith (*) (map (\(_, bid, _) -> bid) (sortByTypeAndCardVal hands)) [1..]   -- PART 1

-- PART 1
evalHandType :: [Int] -> Int
evalHandType hand = case sort $ map (\(_, s) -> s) $ frequency hand of
        [5] -> 6   -- five of a kind
        [1, 4] -> 5  -- four of a kind
        [2, 3] -> 4    -- full house
        [1, 1, 3] -> 3 -- three of a kind
        [1, 2, 2] -> 2 -- two pair
        [1, 1, 1, 2] -> 1  -- one pair
        _ -> 0    -- nothing

sortByTypeAndCardVal :: [Hand] -> [Hand]
sortByTypeAndCardVal hands  = sortBy compareHighestCard hands

compareHighestCard :: Hand -> Hand -> Ordering
compareHighestCard (h1, _, t1) (h2, _, t2)
    | typeOrd == EQ = compare h1 h2
    | otherwise = typeOrd
    where typeOrd = compare t1 t2

-- PART 2

-- HELPER FUNCTIONS
frequency :: (Ord a) => [a] -> [(a, Int)]
frequency xs = toList (fromListWith (+) [(x, 1) | x <- xs])

-- PARSING
mapCtoValue :: Char -> Int
mapCtoValue c = case c of
    'A' -> 14
    'K' -> 13
    'Q' -> 12
    'J' -> 11
    'T' -> 10

mapStrHToH :: String -> Hand
mapStrHToH handString = (cards, read $ last $ words handString, evalHandType cards)
    where
        cards = map (\c -> if isDigit c then digitToInt c else mapCtoValue c) $ head $ words handString
