module Day6Test where

import Control.Exception
import Test.HUnit
import qualified Day6 (part1, part2)
import qualified Common (createGrid)

tests :: Test
tests = TestList [
    TestLabel "day6p1Test" testDay6Part1Test,
    TestLabel "day6p2Test" testDay6Part2Test
    ]

testData :: String
testData = unlines
    [ "....#....."
    , ".........#"
    , ".........."
    , "..#......."
    , ".......#.."
    , ".........."
    , ".#..^....."
    , "........#."
    , "#........."
    , "......#..."
    ]

testDay6Part1Test :: Test
testDay6Part1Test = TestCase $ do
    assertEqual "Day 6, Part 1 Test" 41 (Day6.part1 $ Common.createGrid testData)

testDay6Part2Test :: Test
testDay6Part2Test = TestCase $ do
    assertEqual "Day 6, Part 2 Test" 6 (Day6.part2 $ Common.createGrid testData)