import Data.Char (isDigit, digitToInt)
import Data.List (sort, sortBy)
import Data.Map (fromListWith, toList)

type Hand = ([Int], Int, Int)

main = do
    input <- lines <$> readFile "input.txt"
    print $ totalWins input False   -- PART 1
    print $ totalWins input True    -- PART 2

totalWins :: [String] -> Bool -> Int
totalWins inp hasJokers = sum $ zipWith (*) (map (\(_, bid, _) -> bid) sortedHands) [1..]
    where
        sortedHands = sortByTypeAndCardVal (map (`toHandType` hasJokers) inp)

evalHandType :: [Int] -> Int
evalHandType hand = case sort $ map snd $ frequency hand of
    [5] -> 6   -- five of a kind
    [1, 4] -> 5  -- four of a kind
    [2, 3] -> 4    -- full house
    [1, 1, 3] -> 3 -- three of a kind
    [1, 2, 2] -> 2 -- two pair
    [1, 1, 1, 2] -> 1  -- one pair
    _ -> 0    -- nothing

evalJokerHandType :: [Int] -> Int
evalJokerHandType [1,1,1,1,1] = 6
evalJokerHandType hand = evalHandType $ replaceJokerWithMostCommon
    where
        replaceJokerWithMostCommon = map (\n -> if n == 1 then mostCommonNum else n) hand
        mostCommonNum = fst $ last sortedByFreq
        sortedByFreq = sortBy (\(c1, f1) (c2, f2) -> compare f1 f2) $ frequency $ filter (/= 1) hand

frequency :: (Ord a) => [a] -> [(a, Int)]
frequency xs = toList (fromListWith (+) [(x, 1) | x <- xs])

sortByTypeAndCardVal :: [Hand] -> [Hand]
sortByTypeAndCardVal = sortBy compareHighestCard

compareHighestCard :: Hand -> Hand -> Ordering
compareHighestCard (h1, _, t1) (h2, _, t2)
    | typeOrd == EQ = compare h1 h2
    | otherwise = typeOrd
    where typeOrd = compare t1 t2

-- PARSING
cardTypeValue :: Char -> Bool -> Int
cardTypeValue c b = case (c, b) of
    ('A',_) -> 14
    ('K',_) -> 13
    ('Q',_) -> 12
    ('J',False) -> 11
    ('J',True) -> 1
    ('T',_) -> 10

toHandType :: String -> Bool -> Hand
toHandType handString hasJokers = (cards, read $ last $ words handString, handTypeFunc cards)
    where
        cards = map (\c -> if isDigit c then digitToInt c else cardTypeValue c hasJokers) $ head $ words handString
        handTypeFunc
            | hasJokers = evalJokerHandType
            | otherwise = evalHandType
