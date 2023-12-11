import Data.List.Split (splitOn)
import Data.List (intersect)
import qualified Data.IntMap as M

main = do
    input <- lines <$> readFile "input.txt"
    print $ sum $ map (getCardValue . tail . last . splitOn ":") input
    print $ processCards input

-- PART 1
getNumbers :: String -> [Int]
getNumbers part = map read $ filter (/= "") $ words part

calculateValue :: [Int] -> Int
calculateValue [] = 0
calculateValue [x] = 1
calculateValue (x:xs) = 2 * calculateValue xs

getMatchingNumbers :: String -> [Int]
getMatchingNumbers line =
    let winningNumbers = getNumbers $ head $ splitOn "|" line
        cardNumbers = getNumbers $ last $ splitOn "|" line
        matchedNumbers = intersect winningNumbers cardNumbers
    in matchedNumbers

getCardValue :: String -> Int
getCardValue line = calculateValue $ getMatchingNumbers line

-- PART 2
getTotalCards :: [String] -> Int -> M.IntMap Int -> Int
getTotalCards [] _ cards = sum $ M.elems cards
getTotalCards (x:xs) currCardIndex cards =
    let amtOfMatches = length $ getMatchingNumbers $ last $ splitOn ": " x
        amtOfCards = cards M.! currCardIndex
        adjustedCards = foldl (flip $ M.adjust (+ amtOfCards)) cards [currCardIndex+1..currCardIndex+amtOfMatches]
    in getTotalCards xs (currCardIndex + 1) adjustedCards

cardMap :: [String] -> M.IntMap Int
cardMap input = M.fromList $ zip [1..] (replicate (length input) 1)

processCards :: [String] -> Int
processCards input = getTotalCards input 1 (cardMap input)