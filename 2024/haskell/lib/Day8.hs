module Day8 (run) where

import Common (createGrid, Grid, inBounds, Point)
import Data.Array.Unboxed (UArray, listArray, (!), bounds)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.List (nub)

run :: String -> IO ()
run filePath = do
    content <- createGrid <$> readFile filePath
    print $ Set.size $ collectAntinodes content

findAntinodes :: Point -> Point -> [Point]
findAntinodes (y1, x1) (y2, x2)
    | x1 == x2 && y1 == y2 = []
    | otherwise =
        let antinode1 = (x1 + round (fromIntegral (x2 - x1) * (-1)), y1 + round (fromIntegral (y2 - y1) * (-1)))
            antinode2 = (x1 + round (fromIntegral (x2 - x1) * 2), y1 + round (fromIntegral (y2 - y1) * 2))
        in [antinode1, antinode2]

collectAntinodes :: Grid -> Set Point
collectAntinodes grid =
    let antennas = [((r, c), grid ! (r, c)) | r <- [0..rows-1], c <- [0..cols-1], grid ! (r, c) /= '.']
        sameFreqPairs = [(p1, p2) | (p1, f1) <- antennas, (p2, f2) <- antennas, f1 == f2, p1 /= p2]
        allAntinodes = concatMap (uncurry findAntinodes) sameFreqPairs
        ((0,0), (rows, cols)) = bounds grid
    in Set.fromList $ filter (`inBounds` (rows+1, cols+1)) allAntinodes