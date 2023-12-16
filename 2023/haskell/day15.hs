import Data.List.Split (splitOn)
import Data.Char (ord)
import Data.Maybe (fromJust)
import qualified Data.IntMap as IM

type Lens = (String, Maybe Int)

amtBoxes = 256

main = do
    input <- splitOn "," <$> readFile "test.txt"
    print $ sum $ map hash input

hash :: String -> Int
hash = foldl (\acc c -> ((acc + ord c) * 17) `mod` 256) 0

sortHandler :: [String] -> IM.IntMap [Lens] -> IM.IntMap [Lens]
sortHandler (lens:lenses) boxes = case parseLens lens of
    (label, Just focus) -> 
        sortHandler lenses newBoxes 
        where
            newBoxes = addOrUpdate (label, Just focus) boxes
    (label, Nothing) -> 
        sortHandler lenses newBoxes 
        where
            newBoxes = remove label boxes

remove :: String -> IM.IntMap [Lens] -> IM.IntMap [Lens]
remove lens boxes = IM.empty

addOrUpdate :: Lens -> IM.IntMap [Lens] -> IM.IntMap [Lens]
addOrUpdate lens@(label,focus) boxes
    | inBox = IM.adjust (update lensesInBox lens) key boxes
    | otherwise = IM.adjust (append lensesInBox lens) key boxes     -- compiler error, not sure why yet
    where 
        inBox = lens `elem` lensesInBox
        lensesInBox = fromJust $ IM.lookup key boxes
        key = hash label

update :: [Lens] -> Lens -> [Lens] -> [Lens]
update [] _ newLenses = newLenses
update (old:lenses) new newLenses
    | fst old == fst new = update lenses new newLenses ++ [new]
    | otherwise = update lenses new newLenses ++ [old]

append :: [Lens] -> Lens -> [Lens]
append lenses new = lenses ++ [new]

-- HELPERS
createBoxes :: IM.IntMap [Lens]
createBoxes = IM.fromList $ map (, []) [1..amtBoxes]

parseLens :: String -> Lens
parseLens str
    | '-' `elem` str = (init str, Nothing)
    | '=' `elem` str = (label, Just (read focus))
    where [label, focus] = splitOn "=" str