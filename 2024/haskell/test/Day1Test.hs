module Day1Test where

import Control.Exception
import Test.HUnit
import qualified Day1 (parse, part1, part2)

tests :: Test
tests = TestList [
    TestLabel "day1p1Test" testDay1Part1Test,
    TestLabel "day1p2Test" testDay1Part2Test
    ]

testData :: ([Int], [Int])
testData = Day1.parse "3   4\n4   3\n2   5\n1   3\n3   9\n3   3"

testDay1Part1Test :: Test
testDay1Part1Test = TestCase $ do
    assertEqual "Day 1, Part 1 Test" 11 (Day1.part1 testData)

testDay1Part2Test :: Test
testDay1Part2Test = TestCase $ do
    assertEqual "Day 1, Part 2 Test" 31 (Day1.part2 testData)