import Data.List.Split (splitOn)
import Data.Char (ord)
import Data.Maybe (fromJust)
import qualified Data.IntMap as IM

type Lens = (String, Int)

amtBoxes = 256

main = do
    input <- splitOn "," <$> readFile "input.txt"
    print $ sum $ map hash input
    print $ focusingPower $ sortHandler input createBoxes

hash :: String -> Int
hash = foldl (\acc c -> ((acc + ord c) * 17) `mod` 256) 0

focusingPower :: IM.IntMap [Lens] -> Int
focusingPower = IM.foldlWithKey (\acc k x -> acc + calcLenses k x 0 0) 0

calcLenses :: IM.Key -> [Lens] -> Int -> Int -> Int
calcLenses key [] boxValue _ = boxValue
calcLenses key ((_, focus):lenses) boxValue counter = calcLenses key lenses newBoxVal (counter + 1)
    where
        newBoxVal = boxValue + (key * (counter + 1) * focus)

sortHandler :: [String] -> IM.IntMap [Lens] -> IM.IntMap [Lens]
sortHandler [] boxes = boxes
sortHandler (lens:lenses) boxes = case parseLens lens of
    (label, 0) ->
        sortHandler lenses newBoxes
        where
            newBoxes = removeHandler label boxes
    (label, focus) ->
        sortHandler lenses newBoxes
        where
            newBoxes = addOrUpdate (label, focus) boxes

removeHandler :: String -> IM.IntMap [Lens] -> IM.IntMap [Lens]
removeHandler label boxes = IM.adjust (remove label) key boxes
    where
        lenses = fromJust $ IM.lookup key boxes
        key = hash label + 1

remove :: String -> [Lens] -> [Lens]
remove label = filter (\(l, _) -> l /= label)

addOrUpdate :: Lens -> IM.IntMap [Lens] -> IM.IntMap [Lens]
addOrUpdate lens@(label,focus) boxes
    | inBox = IM.adjust (update lens) key boxes
    | otherwise = IM.adjust (append lens) key boxes
    where
        inBox = any (\(l, _) -> l == label) lensesInBox
        lensesInBox = fromJust $ IM.lookup key boxes
        key = hash label + 1

update :: Lens -> [Lens] -> [Lens]
update new = map (\l -> if fst l == fst new then new else l)

append :: Lens -> [Lens] -> [Lens]
append new lenses = lenses ++ [new]

-- HELPERS
createBoxes :: IM.IntMap [Lens]
createBoxes = IM.fromList $ map (, []) [1..amtBoxes]

parseLens :: String -> Lens
parseLens str
    | '-' `elem` str = (init str, 0)
    | '=' `elem` str = (label, read focus)
    where [label, focus] = splitOn "=" str