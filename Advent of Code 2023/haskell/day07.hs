import Data.Char (isDigit, digitToInt)
import Data.List (sortBy)
import Data.Map (fromListWith, toList)
import Debug.Trace (trace)

-- ([3,2,10,3,13], 765), ([Cards], BidValue)
type Hand = ([Int], Int)

main = do
    input <- lines <$> readFile "test.txt"
    print $ input

-- HELPER FUNCTIONS
frequency :: (Ord a) => [a] -> [(a, Int)]
frequency xs = toList (fromListWith (+) [(x, 1) | x <- xs])

sortByFrequency :: Ord b => [(a, b)] -> [(a, b)]
sortByFrequency = sortBy (\(_,count1) (_,count2) -> compare count2 count1)

evalHandType :: [Int] -> Int
evalHandType hand =
    let sortedOccurences = sortByFrequency $ frequency hand
    in case map snd sortedOccurences of
        [5] -> 6   -- five of a kind
        [4, 1] -> 5  -- four of a kind
        [3, 2] -> 4    -- full house
        [3, 1, 1] -> 3 -- three of a kind
        [2, 2, 1] -> 2 -- two pair
        [2, 1, 1, 1] -> 1  -- one pair
        _ -> 0    -- nothing

-- PARSING
mapCtoValue :: Char -> Int
mapCtoValue c = case c of
    'A' -> 14
    'K' -> 13
    'Q' -> 12
    'J' -> 11
    'T' -> 10

mapStringHandToHand :: String -> Hand
mapStringHandToHand handString = (cards, bid)
    where
        cards = map (\c -> if isDigit c then digitToInt c else mapCtoValue c) $ head $ words handString
        bid = read $ last $ words handString
