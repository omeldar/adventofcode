import Data.List.Split (splitOn)
import Data.List (findIndex)
import Data.Char (ord)
import Data.Maybe

type Lens = (String, Int)

-- if - ,remove the lens in the box with the given label
-- if = and already in the box, replace the focus of the existing lens
-- if = and not in the box, add to end of the box

-- PART 2 not completed yet, some of it is just some pseudocode so I dont forget what I was trying

main = do
    input <- splitOn "," <$> readFile "input.txt"
    print $ sum $ map (\str -> hash str) input

hash :: String -> Int
hash = foldl (\acc c -> ((acc + (ord c)) * 17) `mod` 256) 0

boxes :: [[Lens]]
boxes = replicate 256 []

sortLenses :: [String] -> [[Lens]] -> Int
sortLenses [] boxes = focusPower boxes
sortLenses (str:strs) boxes = sortLenses strs (newBoxes str boxes)

newBoxes :: String -> [[Lens]] -> [[Lens]]
newBoxes lensStr boxes
    | focus == Nothing = removeLens label idx boxes                         -- removeLens needs to return new list of all boxes
    | isNothing indexInBox = addLens (label, focus) idx boxes     -- addLens needs to return new list of all boxes
    | otherwise = overwriteFocus (label, focus) (fromJust indexInBox) idx boxes          -- overwriteFocus needs to return new list of all boxes
    where
        (label, focus) = lensParse lensStr
        idx = hash label
        indexInBox = lensIndex (label, focus) (boxes !! idx)

removeLens :: String -> Int -> [[Lens]] -> [[Lens]]
removeLens _ _ boxes = boxes

addLens :: Lens -> Int -> [[Lens]] -> [[Lens]]
addLens _ _ boxes = boxes

overwriteFocus :: Lens -> Int -> Int -> [[Lens]] -> [[Lens]]
overwriteFocus _ _ _ boxes = boxes

lensIndex :: String -> [Lens] -> Int
lensIndex (sLabel, _) box = findIndex (\(label, value) -> label == sLabel) box

lensParse :: String -> (String, Maybe Int)
lensParse lens
    | '-' `elem` lens = (init lens, Nothing)
    | '=' `elem` lens = (label, read focus)
    where
        (label, focus) = splitOn "=" lens

focusPower :: [[Lens]] -> Int
focusPower boxes = 0