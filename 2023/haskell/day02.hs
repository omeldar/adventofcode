import Data.List (span)

main = do
    input <- lines <$> readFile "input.txt"
    print $ sum $ [gameRes game | game <- gameData input]
    print $ sum $ map getProductOfMaxCubes $ gameData input

getProductOfMaxCubes :: (Int, [(Int, Int, Int)]) -> Int
getProductOfMaxCubes game = red * green * blue
    where
        red = maximum $ map first $ snd game
        green = maximum $ map second $ snd game
        blue = maximum $ map third $ snd game

gameRes :: (Int, [(Int,Int,Int)]) -> Int
gameRes game = if validRounds game == length (snd game)
                    then fst game
                    else 0

validRounds :: (Int, [(Int,Int,Int)]) -> Int
validRounds game = sum [if isValid round then 1 else 0 | round <- snd game]

isValid :: (Int,Int,Int) -> Bool
isValid round
    | r > 12 = False
    | g > 13 = False
    | b > 14 = False
    | otherwise = True
    where (r,g,b) = round

gameData :: [String] -> [(Int, [(Int,Int,Int)])]
gameData input = zip [1..] [createGame (splitOnChar ':' game !! 1) | game <- input]

--out: [(r,g,b), (r,g,b), ...] -in:  createGame "5 red, 1 green, 2 blue; 2 green, 8 blue, 6 red"
createGame :: String -> [(Int,Int,Int)]
createGame gameStr = [createRound round | round <- splitOnChar ';' gameStr]

--out: (r,g,b)  -in: "5 red, 1 green, 2 blue"
createRound :: String -> (Int,Int,Int)
createRound roundStr = mergeTriples [createRGB $ trim pull | pull <- splitOnChar ',' roundStr]

mergeTriples :: [(Int,Int,Int)] -> (Int,Int,Int)
mergeTriples [] = (0,0,0)
mergeTriples [triple] = triple
mergeTriples triples = foldl1 merge triples
    where
        merge (x1, y1, z1) (x2, y2, z2) = (x1 + x2, y1 + y2, z1 + z2)

--out: (r,g,b)  -in: "5 red"
createRGB :: String -> (Int,Int,Int)
createRGB pull
    | color == "red" = (value, 0, 0)
    | color == "green" = (0, value, 0)
    | otherwise = (0, 0, value)
    where
        [valueStr, color] = words pull
        value = read valueStr

splitOnChar :: Char -> String -> [String]
splitOnChar char str
    | not (null rest) = until : splitOnChar char (tail rest)
    | otherwise = [until]
    where (until,rest) = span (/= char) str

trim :: String -> String
trim = f . f
    where f = reverse . dropWhile (== ' ')

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z
