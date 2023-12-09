import Data.List.Split (splitOn)
import Data.List (sort)

type Package = (Int, Int, Int)

main = do
    input <- lines <$> readFile "input.txt"
    let packages = map parse input
    print $ sum $ map calcWrapPaper packages
    print $ sum $ map calcRibbon packages

calcWrapPaper :: Package -> Int
calcWrapPaper (l,w,h) = minimum sides + (sum $ map (2*) sides)
    where
        sides = [l*w, w*h, l*h]

calcRibbon :: Package -> Int
calcRibbon (l,w,h) = (sum $ map (*2) $ take 2 $ sort $ l:w:h:[]) + l*w*h

parse :: String -> Package
parse input = (l,w,h)
    where
        [l,w,h] = map read $ splitOn "x" input