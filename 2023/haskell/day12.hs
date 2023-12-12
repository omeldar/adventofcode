import Data.List.Split (splitOn)
import Debug.Trace (trace)
import qualified Data.Map.Strict as M

type Record = (String, [Int])
type DPMap = M.Map (Int, Int, Int) Int

main = do
    input <- lines <$> readFile "input.txt"
    let records = map parse input
    print $ part2 records

part2 :: [Record] -> Int
part2 records = loopRecords records (M.empty :: DPMap) 0

loopRecords :: [Record] -> DPMap -> Int -> Int
loopRecords [] _ permCount = permCount
loopRecords (record:records) dpMap permCount = loopRecords records newMap (permCount + newPermCount)
    where
        (newMap, newPermCount) = uncurry (f dpMap) record 0 0 0

f :: DPMap -> String -> [Int] -> Int -> Int -> Int -> (DPMap, Int)
f dpMap condStr blocks si bi current
    | M.member (si, bi, current) dpMap = (dpMap, dpMap M.! (si, bi, current))
    | si == length condStr =
        if (bi == length blocks && current == 0) || (bi == length blocks - 1 && blocks !! bi == current) then (dpMap,1) else (dpMap,0)
    | otherwise = calcNewPerm dpMap condStr blocks si bi current

calcNewPerm :: DPMap -> String -> [Int] -> Int -> Int -> Int -> (DPMap, Int)
calcNewPerm dpMap condStr blocks si bi current = (M.insert key perms dpMap, perms)
    where
        key = (si, bi, current)
        perms = foldl (\permAcc c ->
            if condStr !! si == c || condStr !! si == '?'
                then if c == '.' && current == 0
                    then permAcc + snd (f dpMap condStr blocks (si + 1) bi 0)
                    else if c == '.' && current > 0 && bi < length blocks && blocks !! bi == current
                        then permAcc + snd (f dpMap condStr blocks (si + 1) (bi + 1) 0)
                        else if c == '#'
                            then permAcc + snd (f dpMap condStr blocks (si + 1) bi (current + 1))
                            else permAcc
                else permAcc
            ) 0 ".#"

parse :: String -> Record
parse input = (str, numbers)
    where
        str = head $ words input
        numbers =  map read $ splitOn "," $ last $ words input