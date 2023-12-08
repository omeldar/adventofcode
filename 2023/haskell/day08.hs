import Data.List.Split (splitOn)
import Data.Maybe (fromJust)
import qualified Data.Map as M

type NetwMap = (String, String)

main = do
    input <- lines <$> readFile "input.txt"
    let instructions = head input
        networkMap = toMap (drop 2 input)
    print $ indexFirstZ (cycle instructions) 0 networkMap "AAA"
    print $ foldl1 lcm $ map (\n -> indexFirstZ (cycle instructions) 0 networkMap n) (filter ((== 'A') . last) (M.keys networkMap))

indexFirstZ :: String -> Int -> M.Map String NetwMap -> String -> Int
indexFirstZ _ steps _ [_, _, 'Z'] = steps
indexFirstZ (instrC:instrs) steps network elem = indexFirstZ instrs (steps+1) network nextKey
    where
        instr = if instrC == 'L' then fst else snd
        nextKey = instr $ fromJust $ M.lookup elem network

-- PARSING
toMap :: [String] -> M.Map String NetwMap
toMap input = M.fromList $ zip (keys input []) (values input [])

keys :: [String] -> [String] -> [String]
keys [] keyValues = reverse keyValues -- prepending and reversing is faster than appending to list
keys (line:input) keyValues = keys input $ (head $ words line):keyValues

values :: [String] -> [NetwMap] -> [NetwMap]
values [] netwMap = reverse netwMap
values (line:input) netwMap = values input $ (v1, v2):netwMap
    where
        [v1, v2] = splitOn ", " netwOpt
        netwOpt = reverse $ drop 1 $ reverse $ last $ splitOn "(" line