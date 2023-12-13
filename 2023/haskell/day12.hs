import Data.List.Split (splitOn)
import Data.List (intercalate)
import qualified Data.Map.Strict as M

type Record = (String, [Int])
type DPMap = M.Map (Int, Int, Int) Int

-- ~ 16 seconds (interpreted)
-- ~ 2 seconds (compiled)

main = do
    input <- lines <$> readFile "input.txt"
    let records = map parse input
    print $ loopRecords records (M.empty :: DPMap) 0
    print $ loopRecords (toP2records records []) (M.empty :: DPMap) 0

toP2records :: [Record] -> [Record] -> [Record]
toP2records [] newRecords = newRecords
toP2records (record:records) newRecords = toP2records records $ newRecords ++ [x5record]
    where
        x5record = (intercalate "?" (replicate 5 $ fst record), take (5 * length (snd record)) $ cycle $ snd record)

loopRecords :: [Record] -> DPMap -> Int -> Int
loopRecords [] _ permCount = permCount
loopRecords (record:records) dpMap permCount = loopRecords records (M.empty :: DPMap) (permCount + newPermCount)
    where
        (_, newPermCount) = uncurry (f dpMap) record 0 0 0

f :: DPMap -> String -> [Int] -> Int -> Int -> Int -> (DPMap, Int)
f dpMap condStr blocks si bi current
    | M.member (si, bi, current) dpMap = (dpMap, dpMap M.! (si, bi, current))
    | si == length condStr =
        if (bi == length blocks && current == 0) || (bi == length blocks - 1 && blocks !! bi == current) then (dpMap,1) else (dpMap,0)
    | otherwise = (M.insert (si, bi, current) (permDot + permRoute) routeMap, permDot + permRoute)
    where
        (dotMap, permDot) = getPerm dpMap condStr blocks si bi current '.'
        (routeMap, permRoute) = getPerm dotMap condStr blocks si bi current '#'

getPerm :: DPMap -> String -> [Int] -> Int -> Int -> Int -> Char -> (DPMap, Int)
getPerm dpMap condStr blocks si bi current c
    | condStr !! si /= c && condStr !! si /= '?' = (dpMap, 0)
    | c == '.' && current == 0 = f dpMap condStr blocks (si + 1) bi 0
    | c == '.' && current > 0 && bi < length blocks && blocks !! bi == current = f dpMap condStr blocks (si + 1) (bi + 1) 0
    | c == '#' = f dpMap condStr blocks (si + 1) bi (current + 1)
    | otherwise = (dpMap, 0)

parse :: String -> Record
parse input = (str, numbers)
    where
        str = head $ words input
        numbers =  map read $ splitOn "," $ last $ words input