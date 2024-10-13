import Debug.Trace ( trace )
import qualified Data.Array.Unboxed as UA

type Coord = (Int, Int)
type Grid = UA.UArray Coord Int

data Direction = North | West | South | East deriving (Show, Eq, Enum)

main = do
    input <- lines <$> readFile "test.txt"
    let grid :: Grid
        grid = UA.listArray ((0,0), (length input - 1, length (head input) - 1)) $ map (read . (:[])) $ concat input
    print $ show grid