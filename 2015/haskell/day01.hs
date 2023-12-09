main = do
    input <- readFile "input.txt"
    print $ toFloor input 0
    print $ stepsToBasement input 0 0

toFloor :: String -> Int -> Int 
toFloor [] floor = floor
toFloor (instr:instrs) floor = toFloor instrs $ if instr == '(' then floor + 1 else floor - 1

stepsToBasement :: String -> Int -> Int -> Int
stepsToBasement (instr:instrs) floor steps
    | floor >= 0 = stepsToBasement instrs (if instr == '(' then floor + 1 else floor - 1) (steps + 1)
    | otherwise = steps