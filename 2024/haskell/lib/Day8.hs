module Day8 (run) where

import Common (createGrid, Grid, inBounds, Point)
import Data.Array.Unboxed (UArray, listArray, (!), bounds)
import Data.Set (Set)
import qualified Data.Set as Set

type Antenna = (Point, Char)

run :: String -> IO ()
run filePath = do
    content <- createGrid <$> readFile filePath
    print $ part1 content
    print $ part2 content

part1 :: Grid -> Int
part1 grid = Set.size $ collectAntinodes (\p1 p2 _ -> find2xAntinodes p1 p2) grid

part2 :: Grid -> Int
part2 grid = Set.size $ collectAntinodes findAllAntinodes grid 

find2xAntinodes :: Point -> Point -> [Point]
find2xAntinodes (y1, x1) (y2, x2) =
    let antinode1 = (y1 - (y2 - y1), x1 - (x2 - x1))
        antinode2 = (y2 + (y2 - y1), x2 + (x2 - x1))
    in [antinode1, antinode2]

findAllAntinodes :: Point -> Point -> (Int, Int) -> [Point]
findAllAntinodes (y1, x1) (y2, x2) (rows, cols) =
    let generateAntinodes y x dy dx = takeWhile (`inBounds` (rows, cols)) $ iterate (\(r, c) -> (r + dy, c + dx)) (y, x)
    in generateAntinodes y1 x1 (-(y2-y1)) (-(x2-x1)) ++ generateAntinodes y2 x2 (y2-y1) (x2-x1)

collectAntinodes :: (Point -> Point -> (Int, Int) -> [Point]) -> Grid -> Set Point
collectAntinodes findNodesF grid = 
    let ((0, 0), (rows, cols)) = bounds grid
        antennas = [((r, c), grid ! (r, c)) | r <- [0..rows], c <- [0..cols], grid ! (r, c) /= '.']
        sameFreqPairs = [(p1, p2) | ((p1, f1), (p2, f2)) <- [(a1, a2) | a1 <- antennas, a2 <- antennas, a1 /= a2], f1 == f2]
        allAntinodes = concatMap (\(p1, p2) -> findNodesF p1 p2 (rows, cols)) sameFreqPairs
    in Set.fromList $ filter (`inBounds` (rows, cols)) allAntinodes