module Day2Test where

import Control.Exception
import Test.HUnit
import qualified Day2 (part1, part2)

tests :: Test
tests = TestList [
    TestLabel "day2p1Test" testDay2Part1Test,
    TestLabel "day2p2Test" testDay2Part2Test
    ]

testData :: [[Int]]
testData = (map (map read . words) . lines) "7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9"

testDay2Part1Test :: Test
testDay2Part1Test = TestCase $ do
    assertEqual "Day 2, Part 1 Test" 2 (Day2.part1 testData)

testDay2Part2Test :: Test
testDay2Part2Test = TestCase $ do
    assertEqual "Day 2, Part 2 Test" 4 (Day2.part2 testData)